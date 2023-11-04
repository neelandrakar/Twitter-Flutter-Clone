const mongoose = require('mongoose');
const commentSchema = require('./comment');

const tweetSchema = mongoose.Schema({
    tweeted_by: {
        type: String,
        required: true
    },
    content: {
        type: String,
        required: true
    },
    tweeted_at: {
        type: Date,
        default: Date.now
    },
    attachments: {
        imageUrls: [{
            type: String,
            default: '',
        }],
        videoUrls: [{
            type: String,
            default: '',
        }],
    },
    likes: [
        {
            liked_by: {
                type: String,
                default: '',
            },
            liked_on: {
                type: String,
                default: '',
            }
        }
    ],
    retweets: [
        {
            retweeted_by: {
                type: String,
                default: '',
            },
            retweeted_on: {
                type: String,
                default: '',
            }
        }
    ],
    comments: 
        {
            type: mongoose.Schema.Types.Array,
            //ref: 'Comment'
        }
    ,
    d_status: {
        type: Number,
        default: 0
    },
    taggedPeople: [
        {
            type: String,
            default: '',
        }
    ],
});

const Tweet = mongoose.model('Tweet', tweetSchema);

module.exports = Tweet;
