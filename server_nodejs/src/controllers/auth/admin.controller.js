import User from '../../models/user.model';

require('dotenv').config();
const mongoose = require('mongoose');

module.exports = {
    // delete user by ID (just for admin)
    deleteUserById: (req, res, next) => {
        User.findOneAndDelete({ _id: req.params.userId }, (err, user) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when deleting user',
                    error: err
                });
            } else {
                if (user != null) {
                    res.status(200).json({
                        message: 'User successfully deleted'
                    });

                } else {
                    res.status(404).json({
                        message: 'User not found !'
                    })
                }
            }
        });
    },
    // get all user
    getAllUsers: (req, res, next) => {
        User.find({}, (err, users) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when getting users',
                    error: err
                });
            } else {
                res.status(200).json(users);
            }
        });
    },
    // get user by ID
    getUserById: (req, res, next) => {
        User.findOne({ _id: req.params.userId }, (err, user) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when getting user',
                    error: err
                });
            } else {
                res.status(200).json(user);
            }
        });
    },
    // get user by email
    getUserByEmail: (req, res, next) => {
        User.findOne({ email: req.params.email }, (err, user) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when getting user',
                    error: err
                });
            } else {
                res.status(200).json(user);
            }
        });
    },
    // get user by username
    getUserByUsername: (req, res, next) => {
        User.findOne({ name: req.params.username }, (err, user) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when getting user',
                    error: err
                });
            } else {
                if (user != null) {

                    res.status(200).json(user);
                } else {
                    res.status(404).json({
                        message: 'User not found'
                    });
                }
            }
        });
    },
    // get user by role
    getUsersByRole: (req, res, next) => {
        User.find({ role: req.params.role }, (err, users) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when getting users',
                    error: err
                });
            } else {
                res.status(200).json(users);
            }
        });
    },
    //update role for user by userId
    updateRoleForUser: (req, res, next) => {
        User.findOneAndUpdate({ _id: req.params.userId }, { $set: { role: req.body.role } }, (err, user) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when updating user',
                    error: err
                });
            } else {
                if (user != null) {
                    res.status(200).json({
                        message: 'User successfully updated'
                    });
                } else {
                    res.status(404).json({
                        message: 'User not found !'
                    })
                }
            }
        });
    }
}