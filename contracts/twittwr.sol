// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

contract Twitter {

    uint16 public  MAX_TWEEN_LENGTH  = 100;
    struct Tweet {
        uint256 id;
        address aithor;
        string content;
        uint256 timesstamp;
        uint256 likes;

    }

    mapping(address => Tweet[])public tweets;
    address public  owner;

    constructor(){
        owner=msg.sender;
    }

    modifier onliyOwner(){
        require(msg.sender== owner,"YOUR NOT THE OWNER");
        _;
    }
    function changeTweenLength(uint16 newLength)public onliyOwner{
        MAX_TWEEN_LENGTH = newLength;
    }
    function createTweet(string memory _tweets)public {
        require(bytes(_tweets).length <= MAX_TWEEN_LENGTH, "tweet is to leangth...!");
        Tweet memory newTweet = Tweet({
            id:tweets[msg.sender].length,
            aithor:msg.sender,
            content:_tweets,
            timesstamp:block.timestamp,
            likes:0
        });
        tweets[msg.sender].push(newTweet);
    }
  
    function likeTweet(address aithor,uint256 id)external {
        require(tweets[aithor][id].id==id, "tweet dose not exists...!");
        tweets[aithor][id].likes++;
    }
    function unlikeTweet(address aithor,uint256 id)external {
          require(tweets[aithor][id].id==id, "tweet dose not exists...!");
          require(tweets[aithor][id].likes>0, "tweet like is zero...!");
          tweets[aithor][id].likes--;
    }

    function getTweet(uint _i ,address _owner)public view  returns (Tweet memory) {

        return tweets[_owner][_i];
    }
    function getAllTweet(address _all_owner)public  view  returns(Tweet[] memory){
        return tweets[_all_owner];
    }
}


