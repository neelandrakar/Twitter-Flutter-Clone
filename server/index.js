console.log('Trying to connect...');

const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');
const userRouter = require('./routes/user');
const pushNotiRouter = require('./routes/pushNotification');
const employeeRouter = require('./routes/employee');

const app = express();
const PORT = 3000;
const DB = 'mongodb+srv://neelandra:Neelandra123@cluster0.htzaxnp.mongodb.net/?retryWrites=true&w=majority';


//middleware
app.use(express.json());
app.use(authRouter);
app.use(userRouter);
app.use(pushNotiRouter);
app.use(employeeRouter);

//connections
mongoose.connect(DB)
.then(()=>{
    console.log('Connected Successfully');
})
.catch((e)=>{
    console.log(`Error while connecting. Error: ${e}`);
});


app.listen(PORT,'0.0.0.0',function(){
    console.log(`Connected at ${PORT}`);
});