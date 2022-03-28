import '@babel/polyfill';

let chaiHttp = require('chai-http');
let chai = require('chai');
let server = require('../src/server');
let should = chai.should();


chai.use(chaiHttp);




// test register with authorization
describe('/POST register', () => {
    it('it should register a user', (done) => {
        let user = {
            username: "Test User",
            email: "example@gmail.com",
            password: "Test Password",
            phone: "1234567890"
        }
        chai.request(server)
            .post('/api/auth/register')
            .send(user)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.have.property('name');
                res.body.data.should.have.property('email');
                res.body.data.should.have.property('phone');
                done();
            });
    }).timeout(5000);

    it('it should check if the user is already registered', (done) => {
        let user = {
            username: "Test User",
            email: "example@gmail.com",
            password: "Test Password",
            phone: "1234567890"
        }
        chai.request(server)

        .post('/api/auth/register')
            .send(user)
            .end((err, res) => {
                res.should.have.status(203);
                res.body.should.be.a('object');
                res.body.should.have.property('message');
                res.body.should.have.property('status');
                done();
            }).timeout(5000);
    }).timeout(5000);
}).timeout(5000);


//test login with valid credentials
describe('/POST login', () => {
    it('it should login with valid credentials', (done) => {
        let user = {
            email: "example@gmail.com",
            password: "Test Password"
        };
        chai.request(server)
            .post('/api/auth/login')
            .send(user)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.have.property('token');
                done();
            });
    }).timeout(5000);
}).timeout(5000);