import express from 'express';
import cartController from "../../controllers/api/cart.controller";
const router = express.Router();


router.post('/', cartController.addToCart);
router.get('/', cartController.getCart);
router.delete('/', cartController.deleteCartById);
//delete a product from the cart by productId
router.delete('/product/:productId', cartController.deleteProductInCart);
router.put('/', cartController.updateCart);

module.exports = router;

/**
 * @swagger
 * /api/cart:
 *    post:
 *      summary: Add product to cart
 *      tags:
 *          - Cart
 */

/**
 * @swagger
 * /api/cart:
 *   get:
 *    summary: Get all cart
 *    tags:
 *      - Cart
 */

/**
 * @swagger
 * /api/cart:
 *      delete:
 *          summary: Delete cart by id
 *          tags:
 *              - Cart
 * */

/**
 * @swagger
 * /api/cart:
 *     put:
 *        summary: Update cart id
 *        tags:
 *         - Cart
 * */

/**
 * @swagger
 * /api/cart/product/:productId:
 *      delete:
 *          summary: Delete product in cart by productId
 *          tags:
 *              - Cart
 */