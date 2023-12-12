console.log('Trying to connect...');

const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');
const userRouter = require('./routes/user');
const pushNotiRouter = require('./routes/pushNotification');
const employeeRouter = require('./routes/employee');
const tweetRouter = require('./routes/tweet');
const chatRoomRouter = require('./routes/chat_room');
var mysql = require('mysql2');
const app = express();
const PORT = 3000;
const DB = 'mongodb+srv://neelandra:Neelandra123@cluster0.htzaxnp.mongodb.net/?retryWrites=true&w=majority';
const http = require('http');
const cors = require('cors');
const { initSocket } = require('./routes/socket_manager');
var server = http.createServer(app);



//middleware
app.use(express.json());
app.use(cors());
app.use(authRouter);
app.use(userRouter);
app.use(pushNotiRouter);
app.use(employeeRouter);
app.use(tweetRouter);
app.use(chatRoomRouter);

//connections

const messages = [];
initSocket(server);




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

server.listen(PORT, "192.168.184.6", () => {
  console.log("socket server started");
});