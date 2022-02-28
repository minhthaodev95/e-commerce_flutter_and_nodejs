import express from 'express';
import userController from '../../controllers/auth/user.controller';
import authController from '../../controllers/auth/auth.controller';
import multer from 'multer';
import { GridFsStorage } from 'multer-gridfs-storage';
import path from 'path';
var crypto = require('crypto');
require('dotenv').config();

const router = express.Router();

//storage save avatar image
const storage_avatar = new GridFsStorage({
    url: process.env.MONGODB_URI,
    file: (req, file) => {
        return new Promise((resolve, reject) => {
            crypto.randomBytes(16, (err, buf) => {
                if (err) {
                    return reject(err);
                }
                const filename = buf.toString('hex') + path.extname(file.originalname);
                const fileInfo = {
                    filename: filename,
                    bucketName: 'avatar',
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


const upload = multer({ storage: storage_avatar });


let userRoutes = (app) => {

    router.get('/me', authController.isAuthenticated, userController.getUser);
    //update user routes
    router.put('/me', authController.isAuthenticated, upload.single('files'), userController.updateUser);
    //delete user routes
    router.delete('/me', authController.isAuthenticated, userController.deleteUser);
    // stream image routes
    router.get('/me/avatar/:filename', userController.getAvatar);

    return app.use('/api/user', router);
}
module.exports = userRoutes;