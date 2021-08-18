// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


/**
 * @title UniArtsNFT: a ERC721 token
 */
contract UniArtsNFT is ERC721 {
  using Roles for Roles.Role;
  Roles.Role private _minters;

  struct TokenInfo {
    string title;
    uint8 class_id;
    uint8 size;
  }

  /* Our tokeninfo are stored here */
  TokenInfo[] public token_infos;

  constructor() public ERC721("UniArtsNFT", "UANFT") {
  }

  /**
   * @dev Creates a new NFT
   */
  function createNFT(
    address user_address,
    string calldata title,
    uint8 class_id,
    uint8 size
    ) external {
    // Only minters can mint
    require(_minters.has(msg.sender), "DOES_NOT_HAVE_MINTER_ROLE");
    uint tokenId = token_infos.push(
      TokenInfo({
        title: title,
        class_id: class_id,
        size: size
      })
    ) - 1;
    _mint(user_address, tokenId);
  }

  /**
   * @dev Gets a NFT
   * @return The title and the size of the NFT
   */
  function getNFT(
    uint tokenId
  ) external view returns (
    string memory title,
    uint8 class_id,
    uint8 size
  ) {
    return (
      token_infos[tokenId].title,
      token_infos[tokenId].class_id,
      token_infos[tokenId].size
    );
  }
}
