const express = require('express');
const User = require('../models/user');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const authRouter = express.Router();
const auth = require('../middleware/auth');

authRouter.get('/user',(req,res) => {

    const dataToInsert = {
        'name': 'John Doe',
        'age': 30,
        'birthdate': new Date('1993-05-15'),
      };

      console.log(dataToInsert);
  
      // Insert the data into the collection
    res.json(
        dataToInsert
    )
});


//Sign up
authRouter.post('/api/signup',async (req,res)=>{
    
    try {
        const { name,username, email,mobno, password, birthDate } = req.body;

        console.log(req.body);
    
        if(email!=''){
        const existingUserViaMail = await User.findOne({ email });
        if (existingUserViaMail) {
          return res
            .status(400)
            .json({ msg: "User with same email already exists!" });
        }}

        if(mobno!=0){
        const existingUserViaMobno = await User.findOne({ mobno });
        if (existingUserViaMobno) {
          return res
            .status(400)
            .json({ msg: "User with same mobile number already exists!" });
        }}

        const existingUserViaUsername = await User.findOne({ username });
        if (existingUserViaUsername) {
          return res
            .status(400)
            .json({ msg: "User with same username already exists!" });
        }

        const hashedPassword = await bcryptjs.hash(password,8);
        
        let user = new User({
          name,
          username,
          email,
          mobno,
          password: hashedPassword,
          birthDate
        });
        
        user = await user.save();
        res.json(user);

      } catch (e) {
        res.status(500).json({ error: e.message });
      }
    });

    //Check esisting user
    authRouter.post('/api/checkExistingUser', async (req,res)=>{
    
      try {
          const { email,mobno,username } = req.body;

          console.log(req.body);

          const existingUserViaUsername = await User.findOne({ username });
          if (existingUserViaUsername) {
            return res
              .status(400)
              .json({ msg: "User with same username already exists!" });
          }
      
          if(email!=='' && email!==null){
            console.log('email checked');

          const existingUserViaMail = await User.findOne({ email });
          if (existingUserViaMail) {
            return res
              .status(400)
              .json({ msg: "User with same email already exists!" });
          }
          res.status(200).json({msg: 'Proceed'});
        }
  
          if(mobno!=0){
            console.log('mobno checked');
          const existingUserViaMobno = await User.findOne({ mobno });
          if (existingUserViaMobno) {
            return res
              .status(400)
              .json({ msg: "User with same mobile number already exists!" });
          }
          res.status(200).json({msg: 'Proceed'});
        }
  
        } catch (e) {
          res.status(500).json({ error: e.message });
        }
      });


      //Sign in 

      authRouter.post('/api/signin', async (req,res)=>{

        try{

          const { userInput, password } = req.body;

          console.log(req.body);
          const emailRegExp = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
          const mobnoExp = /^\d{10}$/;
          var email = '';
          var mobno = 0;
          var username = '';



          //find user with the email
          if(emailRegExp.test(userInput)){
            email = userInput;
          const userWithEmail = await User.findOne({ email });
          if(!userWithEmail){
            return res.status(400).json({ msg: 'There is no user with this email address'});
          }

          const isMatch = await bcryptjs.compare(password, userWithEmail.password);

          if(!isMatch){
            return res.status(400).json({msg: 'Please enter the correct password'});
          }

          const token = jwt.sign({id: userWithEmail._id},"PasswordKey");
          res.json({token: token, ...userWithEmail._doc});
        }

          //find user with the mobno
          else if(mobnoExp.test(userInput)){
            mobno = parseInt(userInput, 10);
          const userWithMobNo = await User.findOne({ mobno });
          if(!userWithMobNo){
            return res.status(400).json({ msg: 'There is no user with this mobile number'});
          }
          
          const isMatch = await bcryptjs.compare(password, userWithMobNo.password);

          if(!isMatch){
            return res.status(400).json({msg: 'Please enter the correct password'});
          }

          const token = jwt.sign({id: userWithMobNo._id},"PasswordKey");
          res.json({token, ...userWithMobNo._doc});        
        }

          //find user with the username
          else{
            username = userInput;
          const userWithUsername = await User.findOne({ username });
          if(!userWithUsername){
            return res.status(400).json({ msg: 'There is no user with this username'});
          }

          const isMatch = await bcryptjs.compare(password, userWithUsername.password);

          if(!isMatch){
            return res.status(400).json({msg: 'Please enter the correct password'});
          }

          const token = jwt.sign({id: userWithUsername._id},"PasswordKey");
          res.json({token, ...userWithUsername._doc});
        }


        }catch(e){
          res.status(500).json({error: e.message});
        }
      });

      authRouter.post('/api/signin_v2', async (req,res)=>{

        try{

          const { email, mobno, username, password } = req.body;

          console.log(req.body);



          //find user with the email
          if(email!=='' && email!==null){
          const userWithEmail = await User.findOne({ email });
          if(!userWithEmail){
            return res.status(400).json({ msg: 'There is no user with this email address'});
          }

          const isMatch = await bcryptjs.compare(password, userWithEmail.password);

          if(!isMatch){
            return res.status(400).json({msg: 'Please enter the correct password'});
          }

          const token = jwt.sign({id: userWithEmail._id},"PasswordKey");
          res.json({token: token, ...userWithEmail._doc});
        }

          //find user with the mobno
          if(mobno>0){
          const userWithMobNo = await User.findOne({ mobno });
          if(!userWithMobNo){
            return res.status(400).json({ msg: 'There is no user with this mobile number'});
          }
          
          const isMatch = await bcryptjs.compare(password, userWithMobNo.password);

          if(!isMatch){
            return res.status(400).json({msg: 'Please enter the correct password'});
          }

          const token = jwt.sign({id: userWithMobNo._id},"PasswordKey");
          res.json({token, ...userWithMobNo._doc});        
        }

          //find user with the username
          if(username!=''){
          const userWithUsername = await User.findOne({ username });
          if(!userWithUsername){
            return res.status(400).json({ msg: 'There is no user with this username'});
          }

          const isMatch = await bcryptjs.compare(password, userWithUsername.password);

          if(!isMatch){
            return res.status(400).json({msg: 'Please enter the correct password'});
          }

          const token = jwt.sign({id: userWithUsername._id},"PasswordKey");
          res.json({token, ...userWithUsername._doc});
        }


        }catch(e){
          res.status(500).json({error: e.message});
        }
      });

          //Check if token is valid or not
      authRouter.post('/checkToken', async (req,res)=>{

        try{
          
          const token = req.header('x-auth-token');
          console.log(token);
          if(!token) return res.json(false);
          
          const verified = jwt.verify(token,'PasswordKey');
          if(!verified) return res.json(false);

          const checkUser = await User.findById(verified.id);
          if(!checkUser) return res.json(false);

          res.json(true);

        }catch(e){
          res.status(500).json({ error: e.message });
        }

        });

      authRouter.get('/', auth, async (req,res) => {

        const user = await User.findById(req.user);
        res.json({ ...user._doc, token: req.token});
      });  



module.exports = authRouter;
