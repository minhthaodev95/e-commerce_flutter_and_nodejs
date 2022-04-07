import express from 'express';
import productController from '../../controllers/api/product.controller';
import authController from '../../controllers/auth/auth.controller';
import multer from 'multer';
require('dotenv').config();


const router = express.Router();



let productApi = (app) => {
    //get all products from
    router.get('/product', authController.isAuthenticated, productController.getAllProduct);
    //post a product
    router.post('/product', authController.isAuthenticated, authController.isShopOwner,
        multer().array('files', 12),
        productController.createProduct);
    // get product by _id
    router.get('/product/:id', authController.isAuthenticated, productController.getProductById);
    // delete product by _id
    router.delete('/product/:id', authController.isAuthenticated, authController.isShopOwner, productController.deleteProduct);
    // update product by _id
    router.put('/product/:id', authController.isAuthenticated, authController.isShopOwner,
        multer().array('images', 12),
        productController.updateProduct);
    //get products by userId
    router.get('/product/user/:id', authController.isAuthenticated, productController.getProductsByUser);
    //get products by categoryId
    router.get('/product/category/:id', authController.isAuthenticated, productController.getProductsByCategory);
    //stream Image product
    router.get('/product/image/:filename', productController.getImage);
    // get Products by price (range)
    router.get('/product/price/:min/:max', authController.isAuthenticated, productController.getProductsByPriceRange);
    //get Products by name
    router.get('/product/name/:name', authController.isAuthenticated, productController.getProductsByName);
    //get products by date (range)
    router.get('/product/date/:min/:max', authController.isAuthenticated, productController.getProductsByDateRange);
    //get product by tag
    router.get('/product/tags/:tag', authController.isAuthenticated, productController.getProductsByTag);
    //get product  filter
    router.get('/product/filter', authController.isAuthenticated, productController.getProductsFilter);






    return app.use('/api', router);
}

module.exports = productApi;

/**
 * @swagger
 * /api/products:
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
 * /api/products/user/:id:
 *     get:
 *         summary: Get all user's products by userId 
 *         tags:
 *           - Products
 * */


/**
 * @swagger
 * /api/products/category/:id:
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
 * /api/products/price/:min/:max:
 *     get:
 *         summary: Get all products by range price 
 *         tags:
 *           - Products
 * */
/**
 * @swagger
 * /api/products/name/:name:
 *     get:
 *         summary: Get all products by name
 *         tags:
 *           - Products
 * */

/**
 * @swagger
 * /api/products/date/:min/:max:
 *     get:
 *         summary: Get all products by range date 
 *         tags:
 *           - Products
 * */

/**
 * @swagger
 * /api/products/tags/:tags:
 *    get:
 *        summary: Get all products by tag
 *        tags:
 *          - Products
 * */