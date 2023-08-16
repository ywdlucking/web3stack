// SPDX-License-Identifier: GPL-v3
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract Card is ERC721 {
    using Strings for uint256;
    using Counters for Counters.Counter;

    Counters.Counter private counter;

    constructor() ERC721("NFT Card", "CARD") {}

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        bytes memory json = abi.encodePacked(
            '{"name":"#',
            tokenId.toString(),
            '", "image":"',
            getImage(tokenId),
            '"}'
        );
        return
            string(
                json
            );
    }

    function mint() public {
        counter.increment();
        uint256 tokenId = counter.current();
        _safeMint(msg.sender, tokenId);
    }

    function getImage(uint256 tokenId) public view returns (string memory) {
        // address addr = ownerOf(tokenId);
        bytes memory svg = abi.encodePacked(
            "https://xvx-1309942197.cos.ap-shanghai.myqcloud.com/",tokenId.toString(),".svg"
        );
        return
            string(
                abi.encodePacked(svg)
            );
    }

    function getAbbrAddress(address addr) public view returns (string memory) {
        bytes memory alphabet = "0123456789abcdef";
        bytes memory str = new bytes(13);
        str[0] = bytes1(uint8(48)); // "0"
        str[1] = bytes1(uint8(120)); //"x"
        uint256 data = uint256(uint160(addr));
        str[2] = alphabet[
            (data & 0x00_f000_000000000000000000000000000000000000) >> 156
        ];
        str[3] = alphabet[
            (data & 0x00_0f00_000000000000000000000000000000000000) >> 152
        ];
        str[4] = alphabet[
            (data & 0x00_00f0_000000000000000000000000000000000000) >> 148
        ];
        str[5] = alphabet[
            (data & 0x00_000f_000000000000000000000000000000000000) >> 144
        ];
        str[6] = bytes1(uint8(46)); // ".";
        str[7] = bytes1(uint8(46));
        str[8] = bytes1(uint8(46));
        str[9] = alphabet[
            (data & 0x00_000000000000000000000000000000000000_f000) >> 12
        ];
        str[10] = alphabet[
            (data & 0x00_000000000000000000000000000000000000_0f00) >> 8
        ];
        str[11] = alphabet[
            (data & 0x00_000000000000000000000000000000000000_00f0) >> 4
        ];
        str[12] = alphabet[
            data & 0x00_000000000000000000000000000000000000_000f
        ];
        return string(str);
    }
}