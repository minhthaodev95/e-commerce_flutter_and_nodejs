import express from 'express';
import Cart from '../../models/cart.model';
import User from '../../models/user.model';
import Product from '../../models/product.model';

module.exports = {
    addToCart: async(req, res) => {
        console.log(req.body);
        const {
            productId
        } = req.body;
        const quantity = Number.parseInt(req.body.quantity);
        const user_id = req.userId;
        console.log(user_id, quantity, productId);

        const priceProduct = await Product.findOne({
            _id: productId
        }).then(product => {
            console.log(product);
            return Number.parseInt(product.price);
        });

        // get cart by user_id
        Cart.findOne({
            user_id
        }).then(cart => {
            // if cart is not exist, create new cart
            if (!cart) {
                console.log('none cart');
                const newCart = new Cart({
                    user_id,
                    items: [{
                        productId,
                        quantity,
                        total: quantity * priceProduct
                    }]
                });
                newCart.save().then(cart => {
                    res.status(200).json({
                        cart
                    })
                })
            } else {
                // if cart is exist, add new product to cart
                const item = cart.items.find(item => item.productId.toString() === productId.toString());
                if (item) {
                    item.quantity += quantity;
                    item.total = item.quantity * priceProduct;
                } else {
                    cart.items.push({
                        productId,
                        quantity,
                        total: quantity * priceProduct
                    })
                }
                cart.save().then(cart => {
                    res.status(200).json({
                        cart
                    })
                })
            }
        }).catch(function(err) {
            console.log(err);

        })
    },

    //update cart
    updateCart: async(req, res) => {
        const {
            productId,
            quantity
        } = req.body;
        const user_id = req.userId;
        const priceProduct = await Product.findOne({
            _id: productId
        }).then(product => {
            console.log(product);
            return Number.parseInt(product.price);
        });
        Cart.findOne({
            user_id
        }).then(cart => {
            const item = cart.items.find(item => item.productId.toString() === productId.toString());
            if (item) {
                item.quantity = quantity;
                item.total = item.quantity * priceProduct;
            }
            cart.save().then(cart => {
                res.status(200).json({
                    cart
                })
            })
        })
    },

    //delete a product in cart with productId
    deleteProductInCart: async(req, res) => {
        const productId = req.params.productId;
        console.log(productId);
        const user_id = req.userId;
        Cart.findOne({
            user_id
        }).then(cart => {

            const item = cart.items.find(item => item.productId.toString() === productId.toString());
            if (item) {
                cart.items.splice(cart.items.indexOf(item), 1);
            }
            cart.save().then(cart => {
                res.status(200).json({
                    cart
                })
            })
        })
    },



    getCart: (req, res) => {
        const user_id = req.userId;

        Cart.findOne({
            user_id: user_id
        }).populate([{
            path: "items",
            populate: {
                path: "productId",
                populate: [{
                    path: "user",
                    model: "User"
                }, {
                    path: "category",
                    model: "Category"
                }]

            }
        }]).then((carts) => {
            console.log(carts);
            if (!carts) {
                return res.status(404).json({
                    message: 'Cart not found'
                });
            }

            res.status(200).json({
                message: 'Get cart successfully',
                carts: carts
            });
        }).catch((err) => {
            res.status(500).json({
                message: 'Get cart failed',
                error: err
            });
        });
    },
    deleteCartById: (req, res) => {
        const { cartId } = req.body;
        const { user_id } = req.userId;

        Cart.findOne({
            _id: cartId,
            user_id: user_id
        }).then((cart) => {
            if (!cart) {
                return res.status(404).json({
                    message: 'Cart not found'
                });
            }

            cart.remove().then(() => {
                res.status(200).json({
                    message: 'Delete cart successfully'
                });
            }).catch((err) => {
                res.status(500).json({
                    message: 'Delete cart failed',
                    error: err
                });
            });
        }).catch((err) => {
            res.status(500).json({
                message: 'Delete cart failed',
                error: err
            });
        });
    }
}