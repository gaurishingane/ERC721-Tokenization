// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ERC721Metdata{

    function getName() external view returns(string memory);

    function getSymbol() external view returns(string memory);

}