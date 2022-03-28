import mongoose from 'mongoose';

const Schema = mongoose.Schema;


// create cart model 
const CartSchema = new Schema({
    items: [{
        productId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Product",
        },
        quantity: {
            type: Number,
            required: true,
            min: [1, 'Quantity can not be less then 1.']
        },
        total: {
            type: Number,
            required: true,
        },
        shop: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",
        }
    }],
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true
    }
}, {
    timestamps: true
})
module.exports = mongoose.model('cart', CartSchema);