import express from 'express';

import Order from '../../models/order.model';
import Product from '../../models/product.model';
import User from '../../models/user.model';

module.exports = {
    createOrders: async (req, res) => {
        const orders = req.body.items;
        var mapped = orders.reduce((map, val) => {
            if (!map[val.shop]) {
                map[val.shop] = [];
            }
            map[val.shop].push(val);
            return map;
        }, {});

        var arrMapped = Object.values(mapped);


        var arrOrders = arrMapped.map((order) => {
            return {
                shop_id: order[0].shop,
                customer_id: req.userId,
                items: order.map((item) => {
                    return {
                        productId: item.productId,
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
                res.status(200).json({
                    message: 'Orders added successfully',
                    data: docs
                });
            }
        });
    },
    updateStatusOrder: (req, res) => {
        const status = req.body.status;
        let order_id = req.params.orderId;
        Order.findByIdAndUpdate(order_id, {
            $set: {
                status: status
            }
        }, { new: true }, (err, order) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when updating order',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Order updated successfully',
                    data: order
                });
            }
        });
    },
    getAllOrderByUserId: (req, res, next) => {
        const userId = req.params.user
        const user_id = req.userId;

        Order.find({
            $or: [{ shop_id: user_id }, { customer_id: user_id }]
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
        })
            .then((orders) => {
                if (!orders) {
                    return res.status(404).json({
                        message: 'Order not found'
                    });
                }
                res.status(200).json({
                    message: 'Get orders successfully',
                    data: orders
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
            sho_id: shopId
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