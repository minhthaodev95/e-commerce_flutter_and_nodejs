import express from 'express';
import categoryController from '../../controllers/api/category.controller';
import userController from '../../controllers/auth/user.controller';
import authController from '../../controllers/auth/auth.controller';

const router = express.Router();


let initApiRoutes = (app) => {
    router.get('/', (req, res) => {
        res.send('Hello World!');
    });
    router.get('/api', (req, res, next) => {
        // response a json
        res.json({
            "message": "Hello World!",
            "status": "success"
        });
        console.log('API request received');
    });
    // router.get('/api/category', categoryController.getCategory);
    // router.get('/api/user', userController.getUser);
    router.post('/api/user/register', userController.registerUser);
    // route login routes
    router.post('/api/user/login', userController.loginUser);

    router.get('/api/user/me', authController.middleWare, userController.getUser);

    return app.use('/', router);
}

module.exports = initApiRoutes;