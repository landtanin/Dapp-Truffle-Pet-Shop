// Solidity version 0.5.0 or above
pragma solidity ^0.5.0;

contract Adoption {

    // address is a spcial type in Solidity. It's for storing the account address on the ETH blockchain.
    address[16] public adopters;

    function adopt(uint petId) public returns (uint) {
        // check array is within our acceptable range (our pet shop only have 16 cages for pets)
        require(petId >= 0 && petId <= 15);

        // add the name of the contract sender as the pet adopter
        adopters[petId] = msg.sender;

        return petId;
    }

    // `memory` gives the data location for the variable
    // `view` means this won't mutate the state of the contract
    function getAdopters() public view returns (address[16] memory) {
        return adopters;
    }
}