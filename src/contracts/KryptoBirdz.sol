// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract KryptoBirdz is ERC721Connector{

    // to keep track of the kryptobirdz that are minted
    string[] public kryptoBirdz;

    // to make sure the birdz are unique
    mapping(string => bool) kryptoBirdExists;
    constructor() ERC721Connector('Kryptobirdz','KBIRDZ') {
    }

    function mint(string memory _kryptoBird) public {
        require(!(kryptoBirdExists[_kryptoBird]), "KryptoBird already exists");
        kryptoBirdz.push(_kryptoBird);
        uint id = kryptoBirdz.length - 1;
        _mint(msg.sender, id);
        kryptoBirdExists[_kryptoBird] = true;
    }
}