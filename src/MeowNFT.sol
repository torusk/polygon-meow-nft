// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MeowNFT is ERC721URIStorage, Ownable {
    using Strings for uint256;

    uint256 private _nextTokenId;

    event MeowMinted(uint256 indexed tokenId, address indexed creator, string name);

    constructor(address initialOwner) ERC721("MeowNFT", "MEOW") Ownable(initialOwner) {}

    /**
     * @dev Sui版と同様、誰でもNFTを発行（ミント）できるようにします。
     * メタデータJSONをオンチェーンで生成（Base64）するため、画像のIPFS URLだけで発行可能です。
     */
    function mint(
        address recipient,
        string memory name,
        string memory description,
        string memory imageURL
    ) public returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _safeMint(recipient, tokenId);

        // オンチェーンでメタデータを生成
        // 特殊文字対策として、引用符をエスケープします
        string memory safeDescription = _escapeQuotes(description);
        string memory safeName = _escapeQuotes(name);

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "', safeName, '",',
                        '"description": "', safeDescription, '",',
                        '"image": "', imageURL, '",',
                        '"attributes": [',
                            '{"trait_type": "CreatedBy", "value": "Team Meow Chain"},',
                            '{"trait_type": "CreatedWith", "value": "Antigravity"}',
                        ']}'
                    )
                )
            )
        );

        string memory finalTokenUri = string(abi.encodePacked("data:application/json;base64,", json));
        _setTokenURI(tokenId, finalTokenUri);

        emit MeowMinted(tokenId, msg.sender, name);

        return tokenId;
    }

    /**
     * @dev JSON文字列内のダブルクォーテーション (") をエスケープ (\") します。
     */
    function _escapeQuotes(string memory str) internal pure returns (string memory) {
        bytes memory b = bytes(str);
        uint256 count = 0;
        for (uint256 i = 0; i < b.length; i++) {
            if (b[i] == '"') count++;
        }
        if (count == 0) return str;

        bytes memory res = new bytes(b.length + count);
        uint256 j = 0;
        for (uint256 i = 0; i < b.length; i++) {
            if (b[i] == '"') {
                res[j++] = "\\";
                res[j++] = '"';
            } else {
                res[j++] = b[i];
            }
        }
        return string(res);
    }

    /**
     * @dev NFTをバーン（削除）する機能です。
     */
    function burn(uint256 tokenId) public {
        _update(address(0), tokenId, _msgSender());
    }
}
