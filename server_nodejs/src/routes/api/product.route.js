import express from 'express';
import productController from '../../controllers/api/product.controller';
import authController from '../../controllers/auth/auth.controller';
import multer from 'multer';
import { GridFsStorage } from 'multer-gridfs-storage';
import path from 'path';
var crypto = require('crypto');
require('dotenv').config();


const router = express.Router();

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
const upload = multer({ storage: storage });

let productApi = (app) => {
    //get all products from
    router.get('/', productController.getAllProduct);
    //post a product
    router.post('/', authController.isShopOwner,
        upload.array('images', 12),
        productController.createProduct);
    // get product by _id
    router.get('/:id', productController.getProductById);
    // delete product by _id
    router.delete('/:id', authController.isShopOwner, productController.deleteProduct);
    // update product by _id
    router.put('/:id', authController.isShopOwner, productController.updateProduct);
    //get product by userId
    router.get('/user/:id', productController.getProductByUser);

    //get products by categoryId
    router.get('/category/:categoryId', productController.getProductByCategory);
    //stream Image products
    router.get('/image/:filename', productController.getImage);

    // get Products by price (range)
    router.get('/price/:min/:max', productController.getProductByPriceRange);
    //get Products by name
    router.get('/name/:name', productController.getProductByNames);

    //get products by date (range)
    router.get('/date/:min/:max', productController.getProductByDateRange);
    return app.use('/api/product', authController.isAuthenticated, router);
}

module.exports = productApi;