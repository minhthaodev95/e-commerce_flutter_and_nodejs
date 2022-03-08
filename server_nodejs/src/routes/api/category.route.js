import express from 'express';
import categoryController from '../../controllers/api/category.controller';
import authController from '../../controllers/auth/auth.controller';

const router = express.Router();

let categoryAPI = (app) => {
    router.get('/', categoryController.getAllCategory);
    router.post('/', authController.isAdmin, categoryController.createCategory);
    router.put('/:id', authController.isAdmin, categoryController.updateCategory);
    router.delete('/:id', authController.isAdmin, categoryController.deleteCategory);

    return app.use('/api/category', authController.isAuthenticated, router);
}

module.exports = categoryAPI;


/**
 * @swagger
 * /api/category:
 *     get:
 *         summary: Get all categries
 *         tags:
 *           - Category
 * */
/**
 * @swagger
 * /api/category:
 *     post:
 *         summary: Create a Category (Just user has role is "admin" can do)
 *         tags:
 *           - Category
 * */
/**
 * @swagger
 * /api/category/:id:
 *     put:
 *         summary: Update category by ID (Just admin can)
 *         tags:
 *           - Category
 * */
/**
 * @swagger
 * /api/category/:id:
 *     delete:
 *         summary: Delete a category by ID (Just admin can)
 *         tags:
 *           - Category
 * */