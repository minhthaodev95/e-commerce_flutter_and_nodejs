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
    /**
     * @swagger
     * /api/product:
     *     get:
     *         summary: Get all products
     *         tags:
     *           - Products
     * */
    router.get('/', productController.getAllProduct);
    //post a product
    /**
     * @swagger
     * /api/product:
     *     post:
     *         summary: Create a porduct (role is "shopOwner" or "admin" )
     *         tags:
     *           - Products
     * */
    router.post('/', authController.isShopOwner,
        upload.array('images', 12),
        productController.createProduct);
    // get product by _id
    /**
     * @swagger
     * /api/product/:id:
     *     get:
     *         summary: Get a product by ID
     *         tags:
     *           - Products
     * */
    router.get('/:id', productController.getProductById);
    // delete product by _id
    /**
     * @swagger
     * /api/product/:id:
     *     delete:
     *         summary: Delete product by ID ("shopOwner" or "admin")
     *         tags:
     *           - Products
     * */
    router.delete('/:id', authController.isShopOwner, productController.deleteProduct);
    // update product by _id
    /**
     * @swagger
     * /api/product/:id:
     *     put:
     *         summary: Update product by ID ("shopOwner" or "admin")
     *         tags:
     *           - Products
     * */
    router.put('/:id', authController.isShopOwner, productController.updateProduct);
    //get product by userId
    /**
     * @swagger
     * /api/product/user/:id:
     *     get:
     *         summary: Get all user's products by userId 
     *         tags:
     *           - Products
     * */
    router.get('/user/:id', productController.getProductByUser);

    //get products by categoryId
    //get product by userId
    /**
     * @swagger
     * /api/product/category/:id:
     *     get:
     *         summary: Get all products by category 
     *         tags:
     *           - Products
     * */
    router.get('/category/:categoryId', productController.getProductByCategory);
    //stream Image products
    //get product by userId
    /**
     * @swagger
     * /api/product/image/:filename:
     *     get:
     *         summary: Link stream image products
     *         tags:
     *           - Products
     * */
    router.get('/image/:filename', productController.getImage);

    // get Products by price (range)
    //get product by userId
    /**
     * @swagger
     * /api/product/price/:min/:max:
     *     get:
     *         summary: Get all products by range price 
     *         tags:
     *           - Products
     * */
    router.get('/price/:min/:max', productController.getProductByPriceRange);
    //get Products by name
    //get product by userId
    /**
     * @swagger
     * /api/product/name/:name:
     *     get:
     *         summary: Get all products by name
     *         tags:
     *           - Products
     * */
    router.get('/name/:name', productController.getProductByNames);

    //get products by date (range)
    //get product by userId
    /**
     * @swagger
     * /api/product/date/:min/:max:
     *     get:
     *         summary: Get all products by range date 
     *         tags:
     *           - Products
     * */
    router.get('/date/:min/:max', productController.getProductByDateRange);

    //get product by tag
    /**
     * @swagger
     * /api/product/tags/:tags:
     *    get:
     *        summary: Get all products by tag
     *        tags:
     *          - Products
     * */
    router.get('/tags/:tag', productController.getProductByTags);



    return app.use('/api/product', authController.isAuthenticated, router);
}

module.exports = productApi;