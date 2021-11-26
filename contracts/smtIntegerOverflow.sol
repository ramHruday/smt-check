pragma solidity ^0.5.0;

contract Reentrance {
    mapping(address => uint256) userBalance;

    function getBalance(address u) public returns (uint256) {
        return userBalance[u];
    }

    function addToBalance() public payable {
        userBalance[msg.sender] += msg.value;
    }

    function withdrawBalance() public {
        // send userBalance[msg.sender] ethers to msg.sender
        // if mgs.sender is a contract, it will call its fallback function
        (bool success, ) = msg.sender.call.value(userBalance[msg.sender])("");
        require(success);
        userBalance[msg.sender] = 0;
    }

    function withdrawBalance_fixed() public {
        // to protect against re-entrancy, the state variable
        // has to be change before the call
        uint256 amount = userBalance[msg.sender];
        userBalance[msg.sender] = 0;
        (bool success, ) = msg.sender.call.value(amount)("");
        require(!success);
    }

    function withdrawBalance_fixed_2() public {
        // send() and transfer() are safe against reentrancy
        // they do not transfer the remaining gas
        // and they give just enough gas to execute few instructions
        // in the fallback function (no further call possible)
        msg.sender.transfer(userBalance[msg.sender]);
        userBalance[msg.sender] = 0;
    }
}
