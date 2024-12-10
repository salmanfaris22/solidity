// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

contract Twitter {

    uint constant MAX_TWEEN_LENGTH  = 100;
    struct Tweet {
        address aithor;
        string content;
        uint256 timesstamp;
        uint256 likes;

    }

    mapping(address => Tweet[])public tweets;

    function createTweet(string memory _tweets)public {
        require(bytes(_tweets).length <= MAX_TWEEN_LENGTH, "tweet is to leangth...!");
        Tweet memory newTweet = Tweet({
            aithor:msg.sender,
            content:_tweets,
            timesstamp:block.timestamp,
            likes:0
        });
        tweets[msg.sender].push(newTweet);
    }
    function getTweet(uint _i ,address _owner)public view  returns (Tweet memory) {

        return tweets[_owner][_i];
    }
    function getAllTweet(address _all_owner)public  view  returns(Tweet[] memory){
        return tweets[_all_owner];
    }
}


