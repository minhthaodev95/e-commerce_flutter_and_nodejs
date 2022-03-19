import express from 'express';

import Order from '../../models/order.model';
import Product from '../../models/product.model';
import User from '../../models/user.model';

module.exports = {
    createOrders: async(req, res) => {
        const orders = req.body.items;
        var mapped = orders.reduce((map, val) => {
            if (!map[val.productId.user]) {
                map[val.productId.user] = [];
            }
            map[val.productId.user].push(val);
            return map;
        }, {});

        var arrMapped = Object.values(mapped);

        var arrOrders = arrMapped.map((order) => {
            return {
                user_seller_id: order[0].productId.user,
                user_buyer_id: req.userId,
                items: order.map((item) => {
                    return {
                        productId: item.productId.idProduct,
                        quantity: item.quantity,
                        total: item.total
                    }
                }),
                total: order.reduce((acc, item) => {
                    return acc + item.total;
                }, 0)
            };
        })
        Order.insertMany(arrOrders, (err, docs) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when adding orders',
                    error: err
                });
            } else {
                console.log(docs);
                res.status(200).json({

                    message: 'Orders added successfully',
                    orders: docs
                });
            }
        });
    },
    updateStatusOrder: (req, res) => {
        const { status } = req.body;
        order_id = req.params.orderId;
        console.log(req);
        Order.findByIdAndUpdate(order_id, {
            $set: {
                status: status
            }
        }, (err, order) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when updating order',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Order updated successfully',
                    order: order
                });
            }
        });
    },
    getAllOrderByUserId: (req, res, next) => {
        const userId = req.params.user
        const user_id = req.userId;

        Order.find({
            $or: [{ user_buyer_id: user_id }, { user_seller_id: user_id }]
        }).populate({
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
        }).then((orders) => {
            if (!orders) {
                return res.status(404).json({
                    message: 'Order not found'
                });
            }
            res.status(200).json({
                message: 'Get orders successfully',
                orders: orders
            });
        }).catch((err) => {
            res.status(500).json({
                message: 'Get orders failed',
                error: err
            });
        });
    },

    // get all orders by shopId
    getAllOrderByShopId: (req, res, next) => {
        const shopId = req.params.shopId;
        const user_id = req.userId;

        Order.find({
            user_seller_id: shopId
        }).populate({
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
        }).then((orders) => {
            if (!orders) {
                return res.status(404).json({
                    message: 'Order not found'
                });
            }
            res.status(200).json({
                message: 'Get orders successfully',
                orders: orders
            });
        }).catch((err) => {
            res.status(500).json({
                message: 'Get orders failed',
                error: err
            });
        });
    }
}