import Category from '../../models/category.model';
import Product from '../../models/product.model';
import User from '../../models/user.model';

module.exports = {
    getAllCategory: (req, res, next) =>
        Category.find({}).exec((err, categories) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when getting categories',
                    error: err
                });
            } else {
                res.status(200).json(categories);
            }
        }),
    createCategory: (req, res, next) => {
        const category = new Category({
            title: req.body.title,
            description: req.body.description
        });
        category.save((err, category) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when creating category',
                    error: err
                });
            } else {
                res.status(201).json(category);
            }
        });
    },
    updateCategory: (req, res, next) => {
        Category.findByIdAndUpdate(req.params.id, {
            $set: req.body
        }, { new: true }, (err, category) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when updating category',
                    error: err
                });
            } else {
                res.status(200).json(category);
            }
        });
    },
    deleteCategory: (req, res, next) => {
        Category.findByIdAndRemove(req.params.id, (err, category) => {
            if (err) {
                res.status(500).json({
                    message: 'Error when deleting category',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Delete category success'
                });
            }
        });
    }
}