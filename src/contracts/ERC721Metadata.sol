// SPDX-License-Identifier: MIT

import "./interfaces/IERC721Metadata.sol";
import "./ERC165.sol";

pragma solidity ^0.8.0;

contract ERC721Metadata is IERC721Metadata,ERC165 {
    string private name;
    string private symbol;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;

        registerInterface(bytes4(keccak256("getName()")^keccak256("getSymbol()")));
    }

    function getName() external view returns(string memory) {
        return name;
    }

    function getSymbol() external view returns(string memory) {
        return symbol;
    }

}