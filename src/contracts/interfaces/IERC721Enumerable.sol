// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

interface IERC721Enumerable {

    function totalSupply() external view returns (uint256);

    function tokenByIndex(uint256 _index) external view returns (uint256);

    function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256);

    function addTokensToAllTokenEnumeration(uint256 _tokenId) external;

    function addTokenstoOwnerEnumeration(address _to,uint256 _tokenId) external;

}