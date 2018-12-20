pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract TokenRegistry is Ownable {
    mapping (bytes32 => address) public tokens;

    constructor() public Ownable() {
    }

    function contains(bytes32 tokenId) public view returns (bool) {
        return tokens[tokenId] == address(0) ? false : true;
    }

    function getAddress(bytes32 tokenId) public view returns (address) {
        require( tokens[tokenId] != address(0) );
        return tokens[tokenId];
    }

    function setToken(bytes32 tokenId, address _addr) public onlyOwner {
        tokens[tokenId] = _addr;
    }
}

