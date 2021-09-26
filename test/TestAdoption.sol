pragma solidity ^0.5.0;

// Assertion libraries
import "truffle/Assert.sol";
// Get the address of the deployed testing contract
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {

    // The address of the adoption contract to be tested
    Adoption adoption = Adoption(DeployedAddresses.Adoption());

    // The id of the pet that will be used for testing
    uint expectedPetId = 8;

    // The expected owner of adopted pet is this contract
    // Because the TestAdoption contract will be sending the transaction
    // Hence it's the adopter according to how the contract design
    address expectedAdopter = address(this);

    // Testing the adopt() function
    // Calling `adopt()` adds the caller address to the addresses array of the contract
    function testUserCanAdoptPet() public {
        uint returnedId = adoption.adopt(expectedPetId);

        Assert.equal(returnedId, expectedPetId, "Adoption of the expected pet should match what is returned.");
    }

    // Testing retrieval of a single pet's owner
    // Stored data will persist for the duration of our tests
    // Hence, the address stored as a result of calling `adopt()` in the above test can be retrieved here
    function testGetAdopterAddressByPetId() public {
        // public variables get getter methods generated automatically
        address adopter = adoption.adopters(expectedPetId);
        
        Assert.equal(adopter, expectedAdopter, "Owner of the expected pet should be this contract");
    }

    // Testing retrieval of all pet owners
    function testGetAdopterAddressByPetIdInArray() public {
        // Temporarily store adopters in memory rather than contract's storage
        address[16] memory adopters = adoption.getAdopters();

        Assert.equal(adopters[expectedPetId], expectedAdopter, "Owner of the expected pet should be this contract");
    }
}