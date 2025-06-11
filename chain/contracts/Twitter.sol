// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Twitter {
//用户的结构：用户的ipfshash： 头像、名字、简介 ipfs hash 链下存储
    struct UserProfile {
        string ipfsCid;
        bool exists;
    }
//结构体post
    struct Post {
        string title;
        string ipfsHash;//正文。存到ipfs====>hash
        address author;
        uint256 timestamp;
    }

    mapping(address => UserProfile) public userProfiles;//某个地址的用户，详细用户信息是什么？
    mapping(address => uint256[]) public userPostIds; //某个地址的用户，发的文章有哪些 文章id
    Post[] public posts;//所有发过的文章

   
    function setUserProfile(string calldata _ipfsCid) external {
        require(bytes(_ipfsCid).length > 0, "CID required");

        userProfiles[msg.sender] = UserProfile({
            ipfsCid: _ipfsCid,
            exists: true
        });


    }

    function getUserProfile(address _user) external view returns (UserProfile memory) {
        return userProfiles[_user];
    }

    function createPost(string calldata _title, string calldata _ipfsHash) external {
        require(userProfiles[msg.sender].exists, "User not registered");
        require(bytes(_title).length > 0, "Title required");
        require(bytes(_ipfsHash).length > 0, "Content required");

        posts.push(
        Post({
            title: _title,
            ipfsHash: _ipfsHash,
            author: msg.sender,
            timestamp: block.timestamp
        }));
// posts数组 存储的是所有的文章，长度  
        uint256 postId = posts.length - 1; 
        userPostIds[msg.sender].push(postId);

     
    }
//查，，某篇文章
    function getPost(uint256 _postId) external view returns (Post memory) {
        require(_postId < posts.length, "Invalid post ID");
        return posts[_postId];
    }

    function getAllPosts() external view returns (Post[] memory) {
        return posts;
    }

    function getPostCount() external view returns (uint256) {
        return posts.length;
    }

    function getUserPosts(address _user) external view returns (uint256[] memory) {
        return userPostIds[_user];
    }
}
