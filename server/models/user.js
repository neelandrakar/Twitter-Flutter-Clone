const mongoose = require('mongoose');


const userSchema = mongoose.Schema({

    name:{
        required: true,
        type: String,
        trim: true
    },

    username:{
        required: true,
        type: String,
        trim: true
    },

    email: {
        type: String,
        trim: true, 
        validate: {
            validator: (value) => {
                if (value === '') return true; // Allow empty strings
                const re =   /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: 'Please enter a valid email address'
        },
    },

    mobno: {
        type: Number,
        trim: true, 
        
    },

    birthDate:{
        required: true,
        type: String,
    },

    password:{
        required: true,
        type: String,
    },

    hasBlue:{
        type: Number,
        default: 0
    },

    profilePicture:{
        type: String,
        default: '',
    },

    coverPicture:{
        type: String,
        default: '',
    },

    followers:[{
        type: String,
        default: '',
    }],

    following: [{
        type: String,
        default: '',
    }],

    created_at : {
        type: Date,
        default: Date.now
      },
});

const User = mongoose.model('User',userSchema);

module.exports = User;