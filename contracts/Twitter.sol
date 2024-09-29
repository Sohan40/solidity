// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Twitter{

    uint16 public MAX_TWEET_LENGTH = 20;
    address public owner;

    struct  Tweet{
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    constructor (){
        owner = msg.sender;
    }


    mapping(address => Tweet[]) public tweets;
    

    event TweetCreated(uint256 id , address author , string content, uint256 timestamp);
    event TweetLiked(address liker , address author,uint256 id , uint256 likeCount);
    event TweetUnLiked(address unliker , address author,uint256 id , uint256 likeCount);
   
    modifier isOwner (){

        require(msg.sender == owner);
        _;
    }
    function changeTweetLength(uint16 len) public isOwner {
        MAX_TWEET_LENGTH = len;
    }

    function createTweet(string memory _tweet) public {
        
        require( bytes(_tweet).length <= MAX_TWEET_LENGTH, "tweet is too long!");

        Tweet memory newTweet = Tweet ({
            id : tweets[msg.sender].length,
            author : msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes : 0
        });

        tweets[msg.sender].push(newTweet);
        emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);

    }

    function getTweets(uint ind) public view returns (Tweet memory) {

        return tweets[msg.sender][ind];
    }

    function getAllTweets() public view returns (Tweet [] memory){

        return tweets[msg.sender];
    }

    function likeTweet(uint256 id , address author) external {

        require(tweets[author][id].id == id ,"tweet doesnot exist");
        tweets[author][id].likes +=1;
        emit TweetLiked( msg.sender, author, id, tweets[author][id].likes );
    }

    function unlikeTweet(uint256 id , address author) external {

        require(tweets[author][id].id == id ,"tweet doesnot exist");
        require(tweets[author][id].likes > 0 ,"cannot dislike");

        tweets[author][id].likes -=1;

        emit TweetUnLiked( msg.sender, author, id, tweets[author][id].likes );

    }

}