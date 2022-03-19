import express from 'express';
import orderController from '../../controllers/api/order.controller';


const router = express.Router();


// create an order object
router.post('/', orderController.createOrders);
router.put('/:orderId', orderController.updateStatusOrder);
router.get('/', orderController.getAllOrderByUserId);
router.get('/shopId', orderController.getAllOrderByShopId);

module.exports = router;

/**
 * @swagger
 * /api/order:
 *      post:
 *          description: Create an order
 *          tags:
 *              - Orders
 */

/**
 * @swagger
 * /api/order/{orderId}:
 *     put:
 *         description: Update status order
 *         tags:
 *           - Orders
 */

/**
 * @swagger
 * /api/order:
 *     get:
 *        description: Get all order by user id
 *        tags:
 *        - Orders
 */