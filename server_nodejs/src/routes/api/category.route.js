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