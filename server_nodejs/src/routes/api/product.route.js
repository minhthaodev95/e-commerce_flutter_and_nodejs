import express from 'express';
import productController from '../../controllers/api/product.controller';
import authController from '../../controllers/auth/auth.controller';
import multer from 'multer';
require('dotenv').config();


const router = express.Router();



let productApi = (app) => {
    //get all products from
    router.get('/', authController.isAuthenticated, productController.getAllProduct);
    //post a product
    router.post('/', authController.isAuthenticated, authController.isShopOwner,
        multer().array('files', 12),
        productController.createProduct);
    // get product by _id
    router.get('/:id', authController.isAuthenticated, productController.getProductById);
    // delete product by _id
    router.delete('/:id', authController.isAuthenticated, authController.isShopOwner, productController.deleteProduct);
    // update product by _id
    router.put('/:id', authController.isAuthenticated, authController.isShopOwner,
        multer().array('images', 12),
        productController.updateProduct);
    //get product by userId
    router.get('/user/:id', authController.isAuthenticated, productController.getProductByUser);
    //get products by categoryId
    router.get('/category/:categoryId', authController.isAuthenticated, productController.getProductByCategory);
    //stream Image products
    router.get('/image/:filename', productController.getImage);
    // get Products by price (range)
    router.get('/price/:min/:max', authController.isAuthenticated, productController.getProductByPriceRange);
    //get Products by name
    router.get('/name/:name', authController.isAuthenticated, productController.getProductByNames);
    //get products by date (range)
    router.get('/date/:min/:max', authController.isAuthenticated, productController.getProductByDateRange);
    //get product by tag
    router.get('/tags/:tag', authController.isAuthenticated, productController.getProductByTags);
    //get product  filter
    router.get('/filter/product', authController.isAuthenticated, productController.getProductFilter);






    return app.use('/api/product', router);
}

module.exports = productApi;

/**
 * @swagger
 * /api/product:
 *     get:
 *         summary: Get all products
 *         tags:
 *           - Products
 * */
/**
 * @swagger
 * /api/product:
 *     post:
 *         summary: Create a porduct (role is "shopOwner" or "admin" )
 *         tags:
 *           - Products
 * */


/**
 * @swagger
 * /api/product/:id:
 *     get:
 *         summary: Get a product by ID
 *         tags:
 *           - Products
 * */
/**
 * @swagger
 * /api/product/:id:
 *     delete:
 *         summary: Delete product by ID ("shopOwner" or "admin")
 *         tags:
 *           - Products
 * */
/**
 * @swagger
 * /api/product/:id:
 *     put:
 *         summary: Update product by ID ("shopOwner" or "admin")
 *         tags:
 *           - Products
 * */
// update product by _id (delete a image in images array)
/**
 * @swagger
 * /api/product/:id?imageDelete=:images:
 *     put:
 *         summary: Delete a image in images array ("shopOwner" or "admin")
 *         tags:
 *           - Products
 * */


/**
 * @swagger
 * /api/product/user/:id:
 *     get:
 *         summary: Get all user's products by userId 
 *         tags:
 *           - Products
 * */


/**
 * @swagger
 * /api/product/category/:id:
 *     get:
 *         summary: Get all products by category 
 *         tags:
 *           - Products
 * */

/**
 * @swagger
 * /api/product/image/:filename:
 *     get:
 *         summary: Link stream image products
 *         tags:
 *           - Products
 * */


/**
 * @swagger
 * /api/product/price/:min/:max:
 *     get:
 *         summary: Get all products by range price 
 *         tags:
 *           - Products
 * */
/**
 * @swagger
 * /api/product/name/:name:
 *     get:
 *         summary: Get all products by name
 *         tags:
 *           - Products
 * */

/**
 * @swagger
 * /api/product/date/:min/:max:
 *     get:
 *         summary: Get all products by range date 
 *         tags:
 *           - Products
 * */

/**
 * @swagger
 * /api/product/tags/:tags:
 *    get:
 *        summary: Get all products by tag
 *        tags:
 *          - Products
 * */