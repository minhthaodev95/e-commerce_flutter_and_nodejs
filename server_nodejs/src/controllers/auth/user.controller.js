import User from '../../models/user.model';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
const mongoose = require('mongoose');
import path from 'path';
import sharp from 'sharp';
var crypto = require('crypto');
import { GridFsStorage } from 'multer-gridfs-storage';
import { Readable } from 'stream';
require('dotenv').config();



let gridfsBucket;
const conn = mongoose.createConnection(process.env.MONGODB_URI);

// Init gfs
conn.once('open', () => {
    // Init stream
    gridfsBucket = new mongoose.mongo.GridFSBucket(conn.db, {
        bucketName: 'avatar',
    });

});


// avatar storage 
const storage = new GridFsStorage({
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



module.exports = {

    getUser: (req, res, next) => {
        User.findOne({ _id: req.userId }).then((user) => {
            if (user !== null) {

                res.status(200).send({
                    message: "User found !",
                    data: user
                });
            } else {
                res.status(203).json({
                    "message": "User not found !",
                    "status": "error"
                });
            }
        }).catch(function(err) {
            console.log("Error: " + err.message);
        })
    },
    updateUser: async(req, res, next) => {
        if (req.file) {
            // write image to disk
            const file = req.file;
            const data = file.buffer;
            var buffer = await sharp(data)
                .resize(200, 200)
                .jpeg({ quality: 50 })
                .toBuffer();

            // data here directly contains the buffer object.
            const fileStream = Readable.from(buffer);
            // save to gridfs
            var files = await storage.fromStream(fileStream, req, file);
            req.body.image = '/avatar/' + files.filename;
        }
        User.findOneAndUpdate({ _id: req.userId }, {
            $set: req.body
        }, (err, user) => {
            if (err) {
                // console.error(err);
                res.status(500).json({
                    message: 'Error when updating user',
                    error: err
                });
            } else {
                if (user.image != null) {
                    var arrImage = user.image.split('/');
                    arrImage.shift();
                    arrImage.shift();
                    var fileimage = arrImage.join('');

                    gridfsBucket.find({ filename: fileimage }).toArray(function(err, files) {
                        files.forEach(function(file) {
                            gridfsBucket.delete(file._id);
                        })
                    })

                }

                res.status(200).json(user);
            }
        });
    },
    // delete user
    deleteUser: (req, res, next) => {
        User.findOneAndDelete({ _id: req.userId }, (err, user) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when deleting user',
                    error: err
                });
            } else {
                res.status(204).json({
                    message: 'User successfully deleted'
                });
            }
        });
    },
    // request update role for user
    // updateRole:
    // get avatar for user
    getAvatar: (req, res, next) => {
        gridfsBucket.find({ filename: req.params.filename }).toArray((err, files) => {
            // Check if file
            //console.log('file : ', file);
            files.forEach((file) => {
                if (!file || file.length === 0) {
                    return res.status(404).json({
                        err: 'No file exists'
                    });
                }
                // Check if image
                if (file.contentType === 'image/jpeg' || file.contentType === 'image/png') {
                    // Read output to browser
                    const readstream = gridfsBucket.openDownloadStream(file._id);
                    readstream.pipe(res);
                } else if (file.contentType === 'application/octet-stream') {
                    //console.log('file.contentType', file.contentType); /// run here
                    const readstream = gridfsBucket.openDownloadStream(file._id);
                    readstream.pipe(res);
                } else {
                    res.status(404).json({
                        err: 'Not an image'
                    });
                }
            });

        });
    },


}