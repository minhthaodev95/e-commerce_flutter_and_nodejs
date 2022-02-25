import express from 'express';
import categoryController from '../../controllers/api/category.controller';
import userController from '../../controllers/auth/user.controller';
import authController from '../../controllers/auth/auth.controller';

import multer from 'multer';
import path from 'path';
var crypto = require('crypto');

const router = express.Router();



var storage = multer.diskStorage({
    destination: './src/public/uploads/',
    filename: function(req, file, cb) {
        crypto.pseudoRandomBytes(16, function(err, raw) {
            if (err) return cb(err)

            cb(null, raw.toString('hex') + path.extname(file.originalname))
        })
    }
});
var storageList = multer.diskStorage({
    destination: './src/public/uploads/lists/',
    filename: function(req, file, cb) {
        crypto.pseudoRandomBytes(16, function(err, raw) {
            if (err) return cb(err)

            cb(null, raw.toString('hex') + path.extname(file.originalname))
        })
    }
});
const upload = multer({ storage: storage });

const uploadFiles = multer({ storage: storageList });

let initApiRoutes = (app) => {
    router.get('/', (req, res) => {
        res.render('index');
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
    router.put('/api/user/me', authController.middleWare, upload.single('file'), userController.updateUser);

    router.post('/api/user/me/upload', authController.middleWare, uploadFiles.array('files'), userController.uploadImage);
    return app.use('/', router);
}

module.exports = initApiRoutes;