//During the test the env variable is set to test
process.env.NODE_ENV = 'test';
let Product = require("../src/models/product.model");
let User = require("../src/models/user.model");
let Category = require("../src/models/category.model");
let Cart = require("../src/models/cart.model");
let Order = require("../src/models/order.model");
import '@babel/polyfill';
let chai = require('chai');
let chaiHttp = require('chai-http');
import bcrypt from 'bcrypt';
let server = require('../src/server');
let saltRounds = 10;


chai.use(chaiHttp);

before(done => {
    User.deleteMany({}).then(done => {
        console.log("User deleted");
    }).catch(err => {
        console.log(err);
    });

    Product.deleteMany({}).then(done => {
        console.log("Product deleted");
    }).catch(err => {
        console.log(err);
    });
    Category.deleteMany({}).then(done => {
        console.log("Category deleted");
    }).catch(err => {
        console.log(err);
    });
    //delete Carts
    Cart.deleteMany({}).then(done => {
        console.log("Cart deleted");
    }).catch(err => {
        console.log(err);
    });

    // delete Order 
    Order.deleteMany({}).then(done => {
        console.log("Order deleted");
    }).catch(err => {
        console.log(err);
    });
    //create a user with the role is shopOwner
    bcrypt.hash('123456', saltRounds, function(err, hash) {
        if (err) {
            console.log(err);
        } else {
            //create a user with the role is shopOwner
            let user = new User({
                name: 'Shop Owner',
                email: "demo@gmail.com",
                password: hash,
                role: "admin",
                phone: "1234567890",
                address: "123 Main St",

            });
            user.save((err, user) => {
                if (err) {
                    console.log(err);
                } else {
                    // login user anbd get token
                    let userLogin = {
                        email: user.email,
                        password: "123456"
                    };
                    chai.request(server)
                        .post('/api/auth/login')
                        .send(userLogin)
                        .end((err, res) => {
                            res.should.have.status(200);
                            res.body.should.be.a('object');
                            res.body.should.have.property('data');
                            res.body.data.should.have.property('token');
                            process.env.BEARER_TOKEN = res.body.data.token;
                            process.env.USER_ID = res.body.data.id;
                            done();
                        });

                }
            });
        }
    });

})

after('delete all data', done => {
    User.deleteMany({}).then(done => {
        console.log("User deleted");
    }).catch(err => {
        console.log(err);
    });

    Product.deleteMany({}).then(done => {
        console.log("Product deleted");
    }).catch(err => {
        console.log(err);
    });
    Category.deleteMany({}).then(done => {
        console.log("Category deleted");
    }).catch(err => {
        console.log(err);
    });
    //delete Carts
    Cart.deleteMany({}).then(done => {
        console.log("Cart deleted");
    }).catch(err => {
        console.log(err);
    });

    // delete Order 
    Order.deleteMany({}).then(done => {
        console.log("Order deleted");
    }).catch(err => {
        console.log(err);
    });
    done();
});