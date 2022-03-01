import express from 'express';
import categoryController from '../../controllers/api/category.controller';
import authController from '../../controllers/auth/auth.controller';

const router = express.Router();

let categoryAPI = (app) => {
    /**
     * @swagger
     * /api/category:
     *     get:
     *         summary: Get all categries
     *         tags:
     *           - Category
     * */
    router.get('/', categoryController.getAllCategory);
    /**
     * @swagger
     * /api/category:
     *     post:
     *         summary: Create a Category (Just user has role is "admin" can do)
     *         tags:
     *           - Category
     * */
    router.post('/', authController.isAdmin, categoryController.createCategory);
    /**
     * @swagger
     * /api/category/:id:
     *     put:
     *         summary: Update category by ID (Just admin can)
     *         tags:
     *           - Category
     * */
    router.put('/:id', authController.isAdmin, categoryController.updateCategory);
    /**
     * @swagger
     * /api/category/:id:
     *     delete:
     *         summary: Delete a category by ID (Just admin can)
     *         tags:
     *           - Category
     * */
    router.delete('/:id', authController.isAdmin, categoryController.deleteCategory);

    return app.use('/api/category', authController.isAuthenticated, router);
}

module.exports = categoryAPI;