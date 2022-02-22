import express from 'express';
import categoryController from '../../controllers/api/category.controller';
import authController from '../../controllers/auth/auth.controller';

const router = express.Router();

let categoryAPI = (app) => {
    router.get('/', categoryController.getAllCategory);
    router.post('/', categoryController.createCategory);
    router.put('/:id', categoryController.updateCategory);
    router.delete('/:id', categoryController.deleteCategory);

    return app.use('/api/category', authController.middleWare, router);
}

module.exports = categoryAPI;