import Product from '../../models/product.model';
import mongoose from 'mongoose';
import { GridFsStorage } from 'multer-gridfs-storage';
import path from 'path';
import { Readable } from 'stream';
import sharp from 'sharp';

var crypto = require('crypto');

require('dotenv').config();

let gridFsBucket;
const connection = mongoose.createConnection(process.env.MONGODB_URI);
connection.once('open', () => {
    // Init stream
    gridFsBucket = new mongoose.mongo.GridFSBucket(connection.db, { bucketName: 'product' },);
});


//storage save data 

// config folder store images of product
const storage = new GridFsStorage({
    url: process.env.MONGODB_URI,
    options: { useNewUrlParser: true, useUnifiedTopology: true },
    file: (req, file) => {
        return new Promise((resolve, reject) => {
            crypto.randomBytes(16, (err, buf) => {
                if (err) {
                    return reject(err);
                }
                const filename = buf.toString('hex') + path.extname(file.originalname);
                const fileInfo = {
                    filename: filename,
                    bucketName: 'product',
                };
                resolve(fileInfo);
            });
        });
    },
    fileFilter: (req, file, cb) => {
        const allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];
        if (allowedTypes.includes(file.mimetype)) {
            cb(null, true);
        } else {
            cb(new Error('Invalid file type. Only jpeg and png is allowed.'));
        }
    }
})

module.exports = {
    getAllProduct: (req, res, next) => {
        Product.find({}).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting category',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Success',
                    data: products
                });
            }
        });
    },
    getProductById: (req, res, next) => {
        Product.findById(req.params.id).populate('category').populate('user').exec((err, product) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Success',
                    data: product
                });
            }
        });
    },
    createProduct: async (req, res, next) => {


        if (req.files && req.files.length > 0) {
            var listImage = [];
            for (var file of req.files) {
                //resize image with sharp 
                var buffer = await sharp(file.buffer)
                    .resize(200, 200)
                    .jpeg({ quality: 50 })
                    .toBuffer();
                const fileStream = Readable.from(buffer);
                //save to gridFsBucket
                var f = await storage.fromStream(fileStream, req, file);
                var pathImage = '/product/image/' + f.filename;
                listImage.push(pathImage);
            }
            req.body.images = listImage;
            req.body.featureImage = listImage[0];
        }
        const product = new Product({
            title: req.body.title,
            description: req.body.description,
            price: req.body.price,
            category: req.body.category,
            user: req.userId,
            tags: req.body.tags,
            featureImage: req.body.featureImage != undefined ? req.body.featureImage : '',
            images: req.body.images != undefined ? req.body.images : [],
        });
        product.save((err, product) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when creating product',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Success',
                    data: product
                });
            }
        });
    },
    updateProduct: async (req, res, next) => {
        if (req.files && req.files.length > 0) {
            var listImage = [];
            for (var file of req.files) {
                //resize image with sharp 
                var buffer = await sharp(file.buffer)
                    .resize(200, 200)
                    .jpeg({ quality: 50 })
                    .toBuffer();
                const fileStream = Readable.from(buffer);
                //save to gridFsBucket
                var f = await storage.fromStream(fileStream, req, file);
                var pathImage = '/product/image/' + f.filename;
                listImage.push(pathImage);
            }
            req.body.images = listImage;
        }
        Product.findOne({ _id: req.params.id, user: req.userId }).then(function (product) {
            if (!product) {
                return res.status(404).json({
                    message: 'Product not found'
                });
            }
            if (req.query.imageDelete != null) {

                var imageDelete = req.query.imageDelete;

                gridFsBucket.find({ filename: imageDelete }).toArray(function (err, files) {
                    files.forEach(function (file) {
                        gridFsBucket.delete(file._id);
                    })
                });

                function arrayRemove(arr, value) {
                    return arr.filter(function (ele) {
                        return ele != value;
                    });
                }
                imageDelete = "/product/image/" + imageDelete;
                var images = arrayRemove(product.images, imageDelete);
                product.images = images;
            }

            product.title = req.body.title != null ? req.body.title : product.title;
            product.description = req.body.description != null ? req.body.description : product.description;
            product.price = req.body.price != null ? req.body.price : product.price;
            product.category = req.body.category != null ? req.body.category : product.category;
            product.images = req.body.images != null ? product.images.concat(req.body.images) : product.images;
            product.tags = req.body.tags != null ? product.tags.concat(req.body.tags) : product.tags;
            product.save().then(function (product) {
                res.status(200).json({
                    message: 'Success',
                    data: product
                });
            }).catch(function (err) {
                res.status(500).json({
                    message: 'Error when updating product',
                    error: err
                });
            });
        });
    },
    deleteProduct: (req, res, next) => {
        Product.findById(req.params.id, (err, product) => {
            if (req.userId._id == product.user || req.userRole == 'admin') {
                if (product.images != null) {
                    product.images.forEach((image) => {
                        var arrImage = image.split('/');
                        arrImage.splice(0, 3);
                        var fileimage = arrImage.join('');
                        gridFsBucket.find({ filename: fileimage }).toArray(function (err, files) {
                            files.forEach(function (file) {
                                gridFsBucket.delete(file._id);
                            })
                        })
                    });
                }
                product.delete();

                res.status(200).json({
                    message: 'Product deleted successfully',
                    data: product
                });
            } else {
                res.status(500).json({
                    message: 'Error when deleting product',
                    error: err
                });
            }
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when deleting product',
                    error: err
                })
            }
        });
    },
    getProductsByCategory: (req, res, next) => {
        Product.find({
            category: req.params.id
        }).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Success',
                    data: products
                });
            }
        });
    },
    getProductsByUser: (req, res, next) => {
        Product.find({
            user: req.params.id
        }).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Success',
                    data: products
                });
            }
        });
    },
    getProductByTitle: (req, res, next) => {
        Product.find({
            title: req.params.title
        }).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json(products);
            }
        });
    },
    getProductsByPrice: (req, res, next) => {
        Product.find({
            price: req.params.price
        }).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json(products);
            }
        });
    },
    getImage: (req, res, next) => {
        gridFsBucket.find({ filename: req.params.filename }).toArray((err, files) => {
            files.length > 0 ? files.forEach((file) => {
                if (!file || file.length === 0) {
                    return res.status(404).json({
                        err: 'No file exists'
                    });
                }
                // Check if image
                if (file.contentType === 'image/jpeg' || file.contentType === 'image/png' || file.contentType === 'application/octet-stream') {
                    const readstream = gridFsBucket.openDownloadStream(file._id);
                    readstream.pipe(res);
                } else {
                    res.status(404).json({
                        err: 'Not an image'
                    });
                }
            }) : res.status(404).json({
                err: 'No file exists'
            });

        });
    },

    //get products by price (range)
    getProductsByPriceRange: (req, res, next) => {
        Product.find({
            price: { $gte: req.params.min, $lte: req.params.max }
        }).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Success',
                    data: products
                });
            }
        });
    },
    //get product by names
    getProductsByName: (req, res, next) => {
        Product.find({
            title: { $regex: req.params.name, $options: 'i' }
        }).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Success',
                    data: products
                });
            }
        });
    },


    //get products by date(range)
    getProductsByDateRange: (req, res, next) => {
        Product.find({
            created_at: { $gte: new Date(req.params.min), $lte: new Date(req.params.max).setHours(23, 59, 59) }
        }).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Success',
                    data: products
                });
            }
        });
    },
    //get products by tags
    getProductsByTag: (req, res, next) => {
        Product.find({
            tags: { $in: req.params.tag }
        }).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Success',
                    data: products
                });
            }
        });
    },
    // get product  filter by category, price, date, tags, name
    getProductsFilter: (req, res, next) => {
        var query = {};
        if (req.query.category) {
            query.category = req.query.category;
        }
        //range price and
        if (req.query.priceMin && req.query.priceMax) {
            query.price = { $gte: req.query.priceMin, $lte: req.query.priceMax };
        }
        if (req.query.date) {
            query.created_at = { $gte: new Date(req.query.date).setHours(0, 0, 0), $lte: new Date(req.query.date).setHours(23, 59, 59) };
        }
        if (req.query.tags) {
            query.tags = { $in: req.query.tags };
        }
        if (req.query.title) {
            query.title = { $regex: req.query.title, $options: 'i' };
        }

        Product.find(query).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Success',
                    data: products
                });

            }
        });
    },



}