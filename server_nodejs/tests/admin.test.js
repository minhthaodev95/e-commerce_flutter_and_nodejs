process.env.NODE_ENV = 'test';
import "@babel/polyfill";
let chai = require('chai');
let chaiHttp = require('chai-http');
let should = chai.should();
let server = require('../src/server');
let User = require("../src/models/user.model");

chai.use(chaiHttp);


// test GET all user by admin role
describe('/GET all user by admin role', () => {
    it('it should GET all user by admin role', (done) => {
        chai.request(server)
            .get('/api/admin/user')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.be.a('array');
                // res.body.data.length.should.be.eql(2);
                done();
            }).timeout(5000);
    }).timeout(5000);
});

//test Delete a user in a list user by Admin
describe('/DELETE a user in a list user by Admin', () => {
    //create a new user and delete it
    it('it should DELETE a user in a list user by Admin', (done) => {
        let user = new User({
            email: "demo2@gmail.com",
            password: "123456",
            role: "customer",
            phone: "1234567890",
            name: "demo2",
        });
        user.save((err, user) => {
            if (err) return done(err);
            const { _id } = user;
            chai.request(server)
                .delete('/api/admin/user/' + _id)
                .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                .end((err, res) => {
                    res.should.have.status(200);
                    res.body.should.be.a('object');
                    res.body.should.have.property('data');
                    res.body.data.should.have.property('id');
                    res.body.data.should.have.property('email');
                    res.body.data.should.have.property('name');
                    res.body.data.should.have.property('role');
                    done();
                }).timeout(5000);
        });
    }).timeout(5000);
}).timeout(5000);

// update a user in a list user by Admin
describe('/PUT a user in a list user by Admin', () => {
    //create a new user and update it
    it('it should PUT a user in a list user by Admin', (done) => {
        let user = new User({
            email: "demo03@gmail.com",
            password: "123456",
            role: "customer",
            phone: "1234567890",
            name: "demo03",
        });
        user.save((err, user) => {
            if (err) return done(err);
            const { _id } = user;
            let userUpdate = {
                role: "shopOwner",
            };
            chai.request(server)
                .put('/api/admin/user/' + _id)
                .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                .send(userUpdate)
                .end((err, res) => {
                    res.should.have.status(200);
                    res.body.should.be.a('object');
                    res.body.should.have.property('data');
                    res.body.data.should.have.property('id');
                    res.body.data.should.have.property('email');
                    res.body.data.should.have.property('name');
                    res.body.data.should.have.property('role');
                    done();
                }).timeout(5000);
        });
    }).timeout(5000);
}).timeout(5000);

// get User by email address 
describe('/GET User by email address', () => {
    //create a new user and update it
    it('it should GET User by email address', (done) => {
        let user = new User({
            email: "demo04@gmail.com",
            password: "123456",
            role: "customer",
            phone: "1234567890",
            name: "demo04",
        });
        user.save((err, user) => {
            if (err) return done(err);
            const { email } = user;
            chai.request(server)
                .get('/api/admin/email/' + email)
                .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                .end((err, res) => {
                    res.should.have.status(200);
                    res.body.should.be.a('object');
                    res.body.should.have.property('data');
                    res.body.data.should.have.property('id');
                    res.body.data.should.have.property('email');
                    res.body.data.should.have.property('name');
                    res.body.data.should.have.property('role');
                    done();
                }).timeout(5000);
        });
    }).timeout(5000);
}).timeout(5000);

//get users by role (just for admin)
describe('/GET users by role', () => {
    //create a new user and update it
    it('it should GET users by role', (done) => {
        let user = new User({
            email: "demo5@gmail.com",
            password: "123456",
            role: "customer",
            phone: "1234567890",
            name: "demo5",
        });
        user.save((err, user) => {
            if (err) return done(err);
            const { role } = user;
            chai.request(server)
                .get('/api/admin/role/' + role)
                .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                .end((err, res) => {
                    res.should.have.status(200);
                    res.body.should.be.a('object');
                    res.body.should.have.property('data');
                    res.body.data.should.be.a('array');
                    res.body.data.length.should.be.eql(2);
                    done();
                }).timeout(5000);
        });
    }).timeout(5000);
}).timeout(5000);

//get users by username (just for admin)
describe('/GET users by username', () => {
    //create a new user and update it
    it('it should GET users by username', (done) => {
        let user = new User({
            email: "demo05@gmail.com",
            password: "123456",
            role: "customer",
            phone: "1234567890",
            name: "demo05",
        });
        user.save((err, user) => {
            if (err) return done(err);
            const { name } = user;
            chai.request(server)
                .get('/api/admin/username/' + name)
                .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                .end((err, res) => {
                    res.should.have.status(200);
                    res.body.should.be.a('object');
                    res.body.should.have.property('data');
                    res.body.data.should.have.property('name').eql(name);
                    done();
                }).timeout(5000);
        });
    }).timeout(5000);
}).timeout(5000);

// get user by id (just for admin) 
describe('/GET user by id', () => {
    //create a new user and update it
    it('it should GET user by id', (done) => {
        let user = new User({
            email: "demo06@gmail.com",
            password: "123456",
            role: "customer",
            phone: "1234567890",
            name: "demo06",
        });
        user.save((err, user) => {
            if (err) return done(err);
            const { _id } = user;
            chai.request(server)
                .get('/api/admin/user/' + _id)
                .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                .end((err, res) => {
                    res.should.have.status(200);
                    res.body.should.be.a('object');
                    res.body.should.have.property('data');
                    res.body.data.should.have.property('id');
                    res.body.data.should.have.property('email');
                    res.body.data.should.have.property('name');
                    res.body.data.should.have.property('role');
                    done();
                }).timeout(5000);
        });
    }).timeout(5000);
}).timeout(5000);