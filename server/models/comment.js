const mongoose = require('mongoose');

const commentSchema = mongoose.Schema({

    commented_by : {
        type: String,
        required: true
    },

    commented_at : {
        type: Date,
        default: Date.now
    },

    content : {
        type: String,
        required: true
    },

    parent_tweet : {
        type: String,
        required: true
    },

    attachments : 

    {

        imageUrls : [{
            type : String,
            default : '',
        }],

        videoUrls : [{
            type : String,
            default : '',
        }],
    }
    ,

    likes : [
        {
            liked_by : {
                type : String,
                default : '',
            },

            liked_on : {
                type : String,
                default : '',
            }
        }
    ],

    retweets : [
        {
            retweeted_by : {

                type : String,
                default : '',

            },

            retweeted_on : {

                type : String,
                default : '',

            }
        }
    ],

    // replies: [
    //     {
    //       type: mongoose.Schema.Types.ObjectId,
    //       ref: 'Comment', // Reference to the Comment model for reply comments
    //     },
    //   ],

    d_status : {

        type : Number,
        default : 0

    },

    taggedPeople : [
        {
            
            type : String,
            default : '',
        
        }
    ],


});

const Comment = mongoose.model('Comment', commentSchema);

module.exports = Comment;