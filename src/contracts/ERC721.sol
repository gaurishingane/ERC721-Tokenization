// SPDX-License-Identifier: MIT

import "./ERC165.sol";
import "./interfaces/IERC721.sol";

pragma solidity ^0.8.0;

contract ERC721 is ERC165, IERC721 {

    // mapping to get the address of owner for each token
    mapping(uint256 => address) private _tokenOwner;
    // mapping to get the number of tokens owned by each address
    mapping(address => uint256) private _ownedTokensCount;
    // mapping from token Id to the approved address
    mapping(uint256 => address) private _tokenIdApprovals;

    function balanceOf(address _owner) public view returns(uint256) {
        require(_owner != address(0),"Error - Invalid owner address");
        return _ownedTokensCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns(address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "Error - Invalid owner address found!");
        return owner;
    }

    // check whether a token exists
    function exists(uint256 _tokenId) internal view returns(bool) {
        address tokenOwner =_tokenOwner[_tokenId];
        return (tokenOwner != address(0));
    }

    // minting function
    function _mint(address _to, uint256 _tokenId) internal virtual {
        require(!exists(_tokenId), "Invalid address found!");
        require(_tokenOwner[_tokenId] == address(0),"Token already minted!");

        // map the newly minted token to the owner address
        _tokenOwner[_tokenId] = _to;
        // increase the count of tokens owned by the owner address
        _ownedTokensCount[_to] += 1;
        // emit Transfer event
        emit Transfer(address(0), _to, _tokenId);
    }

    // main _transfer from function with logic
    // kept internal for security
    // this function will be invoked by another transferFrom public function
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        require(_from == ownerOf(_tokenId),"From address does not match the Token owner");
        require(_to != address(0), "Invalid address!");

        // deduct NFT count from old owner
        _ownedTokensCount[_from] -= 1;
        // add NFT count to new owner
        _ownedTokensCount[_to] += 1;
        // change the owner of NFT
        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    // transferFrom function with public visibility
    // invokes the internal _transferFrom function
    function transferFrom(address _from,address _to,uint256 _tokenId) public payable {
        require(isApprovedOrOwner(msg.sender, _tokenId),"Only owner or approved addresses can transfer tokens");
        _transferFrom(_from, _to, _tokenId);
    }

    function approve(address _to, uint256 _tokenId) public {
        address owner = ownerOf(_tokenId);
        require(_to != owner, "Cannot approve owner address for same token");
        require(msg.sender == owner,"Only owners can approve");
        _tokenIdApprovals[_tokenId] = _to;
        emit Approval(msg.sender, _to, _tokenId);
    }

    function isApprovedOrOwner(address _spender, uint256 _tokenId) internal view returns (bool) {
        require(exists(_tokenId), "Token does not exists");
        address owner = ownerOf(_tokenId);
        require(owner == _spender || getApproved(_tokenId) == _spender);
        return true;
    }

    function getApproved(uint256 _tokenId) internal view returns(address) {
        require(exists(_tokenId), "Token does not exists");
        return _tokenIdApprovals[_tokenId];
    }
}