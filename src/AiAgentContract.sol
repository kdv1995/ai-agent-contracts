// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

import {Test, console2} from "forge-std/Test.sol"; // TODO: remove

contract AIAgent is Ownable, Pausable {

  event AgentRegistered(address indexed agentAddress, string name, string description);
  event AgreementRegistered(address indexed userAddress, uint256 id);
  event LikeAndPayWithTokenForAgent(address indexed userAddress, uint256 id, uint256 amount);
  event DislikeAndPayMinimumForAgent(address indexed userAddress, uint256 id, uint256 amount);

  struct Agreement {
    uint256 id;
    uint256 createAt;
    address userAddress;
    uint256 balance;
  }

  struct Agent {
    string name;
    string description;
    string endpoint;
  }

  Agent[] public agents;
  Agreement[] public agreements;

  IERC20 public token;

  constructor(address _tokenAddress) {
    token = IERC20(_tokenAddress);
  }

  function registerAgent(string memory name, string memory description, string memory endpoint) public {
    agents.push(Agent(name, description,endpoint));
    emit AgentRegistered(msg.sender, name, description);
  }

  function registerAgreement(uint256 id, uint256 amount) public {
    require(token.allowance(msg.sender, address(this)) >= amount, "Allowance not sufficient");
    token.transferFrom(msg.sender, address(this), amount);
    agreements.push(Agreement(block.timestamp, id, msg.sender, amount));
    emit AgreementRegistered(msg.sender, id);
  }

  function getAgents() public view returns (Agent[] memory) {
    return agents;
  }

  function getAgreements() public view returns (Agreement[] memory) {
    return agreements;
  }

  function likeAndPayWithTokenForAgent (uint256 id, uint256 amount) public {
    require(token.allowance(msg.sender, address(this)) >= amount, "Allowance not sufficient");
    token.transferFrom(msg.sender, address(this), amount);
   }

   function dislikeAndPayMinimumForAgent (uint256 id, uint256 amount) public {
    require(token.allowance(msg.sender, address(this)) >= amount, "Allowance not sufficient");
    token.transferFrom(msg.sender, address(this), amount);
   }
}
