import jwt from 'jsonwebtoken';

import User from '../../models/user.model';
import bcrypt from 'bcrypt';
require('dotenv').config();

let saltRounds = 10;

module.exports = {
    isAuthenticated: (req, res, next) => {
        // console.log(req.headers);
        if (req.headers && req.headers.authorization) {
            // console.log(req.headers.authorization);
            var authorization = req.headers.authorization.substring(7);
            jwt.verify(authorization, process.env.SECRET_KEY, function(err, decoded) {
                if (err) {

                    //return token expiresIn
                    return res.status(401).json({
                        error: 'Token is invalid or expired'
                    });

                }
                req.userId = decoded;
                next();
            });
        } else {
            return res.status(401).send({
                message: 'Unauthorized request'
            });
        }
    },
    //check admin role middleware for

    isAdmin: (req, res, next) => {
        User.findById(req.userId).then((user) => {
            if (user.role === 'admin') {
                req.userRole = user.role;
                next();
            } else {
                //return unauthorized request
                return res.status(401).json({
                    message: 'Unauthorized request'
                });

            }
        }, ).catch(function(err) {
            console.log("Error: " + err.message);
        });
    },
    // check shopOwner role middleware
    isShopOwner: (req, res, next) => {
        User.findById(req.userId).then((user) => {
            if (user.role === 'shopOwner' || user.role === 'admin') {
                req.userRole = user.role;
                next();
            } else {
                return res.status(401).json({
                    message: 'Unauthorized request'
                });
            }
        }, ).catch(function(err) {
            console.log("Error: " + err.message);
        });
    },
    // loginUser
    loginUser: (req, res, next) => {
        User.findOne({ email: req.body.email }).then((user) => {
            if (user !== null) {
                bcrypt.compare(req.body.password, user.password, function(err, result) {
                    if (result) {
                        let token = jwt.sign({ _id: user._id }, process.env.SECRET_KEY, { expiresIn: '30d' });
                        res.status(200).send({
                            message: 'success',
                            data: {
                                ...user.toJSON(),
                                token
                            }
                        });
                    } else {
                        res.status(401).send({
                            message: 'Invalid email or password'
                        });

                    }
                });
            } else {
                console.error("User not found");
            }
        }).catch(function(err) {


            console.log("Error: " + err.message);
        })
    },
    registerUser: async(req, res) => {
        let user = await User.findOne({ email: req.body.email });
        if (user == null) {
            bcrypt.hash(req.body.password, saltRounds, function(err, hash) {
                if (err) {
                    console.log(err);
                } else {
                    let user = new User({
                        name: req.body.username,
                        email: req.body.email,
                        password: hash,
                        phone: req.body.phone,
                    });
                    user.save(function(err, result) {
                        if (err) {
                            console.log(err);
                        } else {
                            console.log(result)
                        }
                    });
                    res.status(200).send({
                        "message": " User Registed !",
                        "status": "success"
                    });
                }
            });
        } else {
            console.log("User already exist");
            res.status(203).json({
                "message": "User already exists !",
                "status": "error"
            });

        }
    },

}