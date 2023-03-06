// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is ERC721,IERC721Enumerable{

    uint256[] private allTokens;

    // mapping from tokenId to position in allTokens array
    mapping (uint256 => uint256) private _allTokensIndex;

    // mapping from owner to all owned tokens
    mapping(address => uint256[]) private _ownedTokens;

    // mapping from token ID index to owner tokens list
    // where is the token in the owner's list of tokens
    mapping(uint256 => uint256) private _ownedTokensIndex;

    constructor(){
        registerInterface(
            bytes4(keccak256("totalSupply()")^keccak256("tokenByIndex(uint256)")^keccak256("tokenOfOwnerByIndex(address, uint256)"))
            );
    }

    function totalSupply() public view returns (uint256) {
        return allTokens.length;
    }

    function tokenByIndex(uint256 _index) external view returns (uint256){
        require(_index < totalSupply(), "Index out of bounds!");
        return allTokens[_index];
    }

    function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256) {
        require(_owner != address(0),"Invalid address!");
        require(_index < balanceOf(_owner));
        return _ownedTokens[_owner][_index];
    }

    function _mint(address _to, uint256 _tokenId) internal override(ERC721) {
        super._mint(_to, _tokenId);
        addTokensToAllTokenEnumeration(_tokenId);
        addTokenstoOwnerEnumeration(_to, _tokenId);
    }

    function addTokensToAllTokenEnumeration(uint256 _tokenId) private {

        // add token index to the _allTokensIndex mapping
        _allTokensIndex[_tokenId] = allTokens.length;

        // Add token to the allTokens list
        allTokens.push(_tokenId);
    }

    function addTokenstoOwnerEnumeration(address _to,uint256 _tokenId) private {
        
        _ownedTokensIndex[_tokenId] = _ownedTokens[_to].length;
        
        _ownedTokens[_to].push(_tokenId);
    }
}