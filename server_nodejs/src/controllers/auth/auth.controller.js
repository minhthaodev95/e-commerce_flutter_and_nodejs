import jwt from 'jsonwebtoken';

module.exports = {
    middleWare: function(req, res, next) {
        if (req.headers && req.headers.authorization) {
            // console.log(req.headers.authorization);
            var authorization = req.headers.authorization.substring(7);
            var decoded = jwt.verify(authorization, process.env.SECRET_KEY);
            req.userId = decoded._id;
            next();
        } else {
            return res.status(401).send({
                message: 'Unauthorized request'
            });
        }
    }
}