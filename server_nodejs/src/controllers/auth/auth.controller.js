import jwt from 'jsonwebtoken';

module.exports = {
    middleWare: function(req, res, next) {
        if (req.headers && req.headers.authorization) {
            // console.log(req.headers.authorization);
            var authorization = req.headers.authorization.substring(7);
            jwt.verify(authorization, process.env.SECRET_KEY, function(err, decoded) {
                if (err) {
                    return res.status(401).json({
                        message: 'Unauthorized request'
                    });
                }
                req.userId = decoded;
                next();
            });
        } else {
            console.log('No token');
            return res.status(401).send({
                message: 'Unauthorized request'
            });
        }
    }
}