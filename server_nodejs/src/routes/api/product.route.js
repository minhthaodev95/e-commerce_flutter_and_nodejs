import express from 'express';
import productController from '../../controllers/api/product.controller';
import authController from '../../controllers/auth/auth.controller';

const router = express.Router();

let productApi = (app) => {
    router.get('/', productController.getAllProduct);
    router.get('/:id', productController.getProductById);
    router.get('/:user/products', productController.getProductByUser);
    router.get('/:category/products', productController.getProductByCategory);
    router.post('/create', productController.createProduct);
    router.put('/update/:id', productController.updateProduct);
    router.delete('/delete/:id', productController.deleteProduct);

    return app.use('/api/product', authController.middleWare, router);
}

module.exports = productApi;