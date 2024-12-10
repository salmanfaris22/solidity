// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

contract Twitter {
    mapping(address=>string)public tweets;

    function createTweet(string memory _tweets)public {
        tweets[msg.sender]=_tweets;
    }
    function getTweet(address _owner)public view  returns (string memory) {
        return tweets[_owner];
    }
}