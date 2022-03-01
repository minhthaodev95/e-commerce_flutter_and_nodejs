import Product from '../../models/product.model';
import mongoose from 'mongoose';
require('dotenv').config();

let gridFsBucket;
const connection = mongoose.createConnection(process.env.MONGODB_URI);
connection.once('open', () => {
    // Init stream
    gridFsBucket = new mongoose.mongo.GridFSBucket(connection.db, { bucketName: 'product' }, );
});

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
                res.status(200).json(products);
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
                res.status(200).json(product);
            }
        });
    },
    createProduct: (req, res, next) => {

        // req.file.path = req.file.path.replace('public', '');

        if (req.files && req.files.length > 0) {
            var listImage = [];
            for (var file of req.files) {

                var pathImage = '/image/product/' + file.filename;
                listImage.push(pathImage);
            }
            req.body.images = listImage;
        }
        const product = new Product({
            title: req.body.title,
            description: req.body.description,
            price: req.body.price,
            category: req.body.category,
            user: req.userId,
            featureImage: req.body.images[0],
            images: req.body.images
        });
        product.save((err, product) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when creating product',
                    error: err
                });
            } else {
                res.status(201).json(product);
            }
        });
    },
    updateProduct: (req, res, next) => {

        Product.findOneAndUpdate({ _id: req.params.id, user: req.userId }, {
            $set: req.body
        }, { new: true }, (err, product) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when updating product',
                    error: err
                });
            }
            if (product != null) {
                console.log('success')
                res.status(200).json(product);
            } else {
                res.status(500).json({
                    message: 'Error when updating product',
                    error: err
                })
            }
        });
    },
    deleteProduct: (req, res, next) => {
        Product.findById(req.params.id, (err, product) => {
            if (req.userId._id == product.user || req.userRole == 'admin') {
                product.delete();
                res.status(200).json({
                    message: 'Product deleted successfully'
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
    getProductByCategory: (req, res, next) => {
        Product.find({
            category: req.params.categoryId
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
    getProductByUser: (req, res, next) => {
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
                res.status(200).json(products);
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
    getProductByPrice: (req, res, next) => {
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
            files.forEach((file) => {
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
            });

        });
    },

    //get products by price (range)
    getProductByPriceRange: (req, res, next) => {
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
                res.status(200).json(products);
            }
        });
    },
    //get product by names
    getProductByNames: (req, res, next) => {
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
                res.status(200).json(products);
            }
        });
    },


    //get products by date(range)
    getProductByDateRange: (req, res, next) => {
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
                res.status(200).json(products);
            }
        });
    },
    //get products by tags
    getProductByTags: (req, res, next) => {
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
                res.status(200).json(products);
            }
        });
    }
}