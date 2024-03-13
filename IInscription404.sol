interface IInscription404 {
    event TransferToken(
        address indexed from,
        address indexed to,
        uint256 amount,
        uint256 decimal
    );

    event TransferNFT(
        address indexed from,
        address indexed to,
        uint256 amount,
        uint256 tokenId,
        uint8 decimal
    );

    // function deploy(
    //     uint8 d
    // ) external;

    function tokenURI(uint256 tokenId) external view returns (string memory);

    function transferToken(uint256 tokenID, address recipient)
        external
        returns (bool);

    function transferTokenFrom(
        uint256 tokenID,
        address sender,
        address recipient
    ) external returns (bool);
}
