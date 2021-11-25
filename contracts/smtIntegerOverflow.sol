pragma solidity >=0.8.0;

contract Overflow {
    uint256 immutable x;
    uint256 immutable y;

    function add(uint256 _x, uint256 _y) internal pure returns (uint256) {
        return _x + _y;
    }

    constructor(uint256 _x, uint256 _y) {
        (x, y) = (_x, _y);
    }

    function stateAdd() public view returns (uint256) {
        return add(x, y);
    }
}
