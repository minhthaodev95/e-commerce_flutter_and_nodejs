import User from '../../models/user.model';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

let saltRounds = 10;



module.exports = {
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
    loginUser: (req, res, next) => {
        User.findOne({ email: req.body.email }).then((user) => {
            if (user !== null) {
                bcrypt.compare(req.body.password, user.password, function(err, result) {
                    if (result) {
                        let token = jwt.sign({ _id: user._id }, process.env.SECRET_KEY, { expiresIn: '1h' });

                        res.status(200).send({
                            message: 'success',
                            data: {
                                ...user.toJSON(),
                                token
                            }
                        });
                    } else {
                        next(err);
                    }
                });
            } else {
                console.error("User not found");
            }
            // console.log(user);

        }).catch(function(err) {


            console.log("Error: " + err.message);
        })
    },
    getUser: (req, res, next) => {
        User.findOne({ _id: req.userId }).then((user) => {
            if (user !== null) {
                console.log("Loggin Successfully logged in");
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
    }

}