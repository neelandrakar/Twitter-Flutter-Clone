const express = require('express');
const userRouter = express.Router();
const auth = require('../middleware/auth');
const Tweet = require('../models/tweet');
const User = require('../models/user');
const Comment = require('../models/comment');

//Create a tweet

userRouter.post('/api/tweet', auth, async (req,res) => {

    try{
        const { content,imageUrl,videoUrl } = req.body;

        console.log('Tweet api called');

        console.log(req.body);
        const userId = req.user;
        let user = await User.findById(userId);


        //let attachments = [];
        let retweets = [];
        const tweeted_by_name = user ? user.name : '';
        const tweeted_by_username = user ? user.username : '';
        const tweeted_by_avi = user ? user.profilePicture : '';
        const is_tweeted_by_blue = user ? user.hasBlue : 0;
        const hasUserLiked = 0;
        const hasUserRetweeted = 0;
        

        const attachments = {
            imageUrls: imageUrl,
            videoUrls: videoUrl
          };

        const tweeted_by = req.user;

        let tweet = new Tweet({
            content,
            attachments,
            retweets,
            tweeted_by

        });

        tweet = await tweet.save();

        const response = {
            tweet,
            tweeted_by_name
        }

        const tweetRes = {
              ...tweet.toObject(),
              tweeted_by_name,
              tweeted_by_username,
              tweeted_by_avi,
              is_tweeted_by_blue,
              hasUserLiked,
              hasUserRetweeted
          };

          res.json(tweetRes);
        

        
        // res.json(response);

    } catch(e){
        res.status(500).json({msg: e.message});
    }
});

//Fetch tweets

userRouter.get('/api/get-tweets', auth, async (req,res) => {

    try{

       // console.log('get tweets api called');

        const userId = req.user;
        let user = await User.findById(userId);
        const followingIds = user.following;

        const tweetAuthors = [userId,...followingIds];
    



        const tweets = await Tweet.find({
            tweeted_by : { $in: tweetAuthors },
            d_status : 0
        });

        async function getLikedStatus(tweets) {
            let userHasLiked = false;
        
            for (let i = 0; i < tweets.likes.length; i++) {
                if (tweets.likes[i].liked_by === userId) {
                    userHasLiked = true;
                    break; // Assuming you want to stop checking once a match is found
                }
            }
        
            return userHasLiked ? 1 : 0;
        }

        async function getRetweetStatus(tweets) {
            let userHasRetweeted = false;
        
            for (let i = 0; i < tweets.retweets.length; i++) {
                if (tweets.retweets[i].retweeted_by === userId) {
                    userHasRetweeted = true;
                    break; // Assuming you want to stop checking once a match is found
                }
            }
        
            return userHasRetweeted ? 1 : 0;
        }
        


        async function getTweetersName(tweeted_by_id) {

            let user = await User.findById(tweeted_by_id);
            return user ? user.name : ''
        }

        async function getTweetersUsername(tweeted_by_id) {
            let user = await User.findById(tweeted_by_id);
            return user ? user.username : ''; // Check if user exists
        }

        async function getTweetersBlueStatus(tweeted_by_id){

            let user = await User.findById(tweeted_by_id);
            return user ? user.hasBlue : 0;
        }

        async function getTweetersProfilePic(tweeted_by_id){

            let user = await User.findById(tweeted_by_id);
            return user ? user.profilePicture : '';
        }



        // const tweeted_by_id = tweets.map(tweet => tweet.tweeted_by);     //Getting tweeted_by after mapping through tweet
        // console.log(tweeted_by_id);

        const tweetsWithData = await Promise.all(tweets.map(async tweet => ({
            ...tweet.toObject(), // Convert Mongoose document to plain JavaScript object
            tweeted_by_name: await getTweetersName(tweet.tweeted_by),
            tweeted_by_username: await getTweetersUsername(tweet.tweeted_by),
            is_tweeted_by_blue : await getTweetersBlueStatus(tweet.tweeted_by),
            tweeted_by_avi : await getTweetersProfilePic(tweet.tweeted_by),
            hasUserLiked : await getLikedStatus(tweet),
            hasUserRetweeted : await getRetweetStatus(tweet)
        })));

        tweetsWithData.sort((a, b) => b.tweeted_at - a.tweeted_at);


        res.json(tweetsWithData);

    }catch(e){
        res.status(500).json({ msg: e.message });
    }
});

//Like a tweet

userRouter.post('/api/like-a-tweet', auth, async (req,res) =>{

    try{

        console.log(req.body);
        const {id} = req.body;
        let tweet = await Tweet.findById(id);
        const userId = req.user;
        let hasUserAlreadyLiked = false;

        for (let i = 0; i < tweet.likes.length; i++) {
            if (tweet.likes[i].liked_by === userId) {
                tweet.likes.splice(i, 1); // Remove the element at index i
                await tweet.save();
                hasUserAlreadyLiked = true;
                res.json({ msg: 'Successfully Unliked'});
                break; // Assuming you want to stop checking once a match is found
            }
        }
        

        if(!hasUserAlreadyLiked){
        tweet.likes.push({
            liked_by : req.user,
            liked_on : Date.now()
        });

        await tweet.save();

        res.json({ msg: 'Successfully Liked'});
    }
        

    }catch(e){
        res.status(500).json({ msg: e.message });
    }
} );

//Retweet a tweet

userRouter.post('/api/retweet-a-tweet', auth, async (req,res) =>{

    try{

        console.log(req.body);
        const {id} = req.body;
        let tweet = await Tweet.findById(id);
        const userId = req.user;
        let hasUserAlreadyRetweeted = false;

        for (let i = 0; i < tweet.retweets.length; i++) {
            if (tweet.retweets[i].retweeted_by === userId) {
                tweet.retweets.splice(i, 1); // Remove the element at index i
                await tweet.save();
                hasUserAlreadyRetweeted = true;
                res.json({ msg: 'Successfully Unretweeted'});
                break; // Assuming you want to stop checking once a match is found
            }
        }
        

        if(!hasUserAlreadyRetweeted){
        tweet.retweets.push({
            retweeted_by : req.user,
            retweeted_on : Date.now()
        });

        await tweet.save();

        res.json({ msg: 'Successfully Retweeted'});
    }
        

    }catch(e){
        res.status(500).json({ msg: e.message });
    }
} );

//Comment on a tweet

userRouter.post('/api/comment', auth, async(req, res) =>{

    try{

        const{ content, imageUrl, videoUrl, parent_tweet } = req.body;

        const commented_by = req.user;

        let tweet = await Tweet.findById(parent_tweet);


        const commentSchema = new Comment({
            content,
            parent_tweet,
            commented_by
        });

        //await commentSchema.save();

        tweet.comments.push(commentSchema);

        tweet = await tweet.save();
        res.json(tweet);



    }catch(e){
        res.status(500).json({ msg: e.message });
    }
});

module.exports = userRouter;

//Fetch comments

userRouter.get('/api/get-comments', auth, async (req,res) => {

    try{

        const tweetId = req.query.id;
        console.log(tweetId);
        let tweet = await Tweet.findById(tweetId);

        const allComments = tweet.comments;

        const content = tweet.content;

        let userHasLiked = false;
        let userHasRetweeted = false;
        
        for (let i = 0; i < tweet.likes.length; i++) {
            if (tweet.likes[i].liked_by === req.user) {
                userHasLiked = true;
                break; // Assuming you want to stop checking once a match is found
            }
        }

        for (let i = 0; i < tweet.retweets.length; i++) {
            if (tweet.retweets[i].retweeted_by === req.user) {
                userHasRetweeted = true;
                break; // Assuming you want to stop checking once a match is found
            }
        }

        async function getCommentersName(commented_by_id) {

            let user = await User.findById(commented_by_id);
            return user ? user.name : ''
        }

        async function getCommentersUsername(commented_by_id) {

            let user = await User.findById(commented_by_id);
            return user ? user.username : ''
        }

        async function getCommentersAvi(commented_by_id) {

            let user = await User.findById(commented_by_id);
            return user ? user.profilePicture : ''
        }

        async function getCommentersBlueStatus(commented_by_id) {

            let user = await User.findById(commented_by_id);
            return user ? user.hasBlue : 0
        }

            const commentsWithData = await Promise.all(allComments.map(async comment => ({
            ...comment,
            commented_by_name : await getCommentersName(comment.commented_by),
            commented_by_username : await getCommentersUsername(comment.commented_by),
            commented_by_avi : await getCommentersAvi(comment.commented_by),
            commented_by_blue_status : await getCommentersBlueStatus(comment.commented_by)
        })));

        const response = {
            //content : content,
            userHasLiked : userHasLiked,
            userHasRetweeted : userHasRetweeted,
            comments : commentsWithData
        }

        

        res.json(commentsWithData);

    }catch(e){
        res.status(500).json({ msg: e.message });
    }
} );