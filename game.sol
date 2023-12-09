// Sources flattened with hardhat v2.17.1 https://hardhat.org

// SPDX-License-Identifier: MIT

// File @openzeppelin/contracts/utils/Context.sol@v4.9.3

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}


// File @openzeppelin/contracts/access/Ownable.sol@v4.9.3

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (access/Ownable.sol)

pragma solidity ^0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


// File @openzeppelin/contracts/utils/introspection/IERC165.sol@v4.9.3

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC165.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}


// File @openzeppelin/contracts/token/ERC721/IERC721.sol@v4.9.3

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC721/IERC721.sol)

pragma solidity ^0.8.0;

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Note that the caller is responsible to confirm that the recipient is capable of receiving ERC721
     * or else they may be permanently lost. Usage of {safeTransferFrom} prevents loss, though the caller must
     * understand this adds an external call which potentially creates a reentrancy vulnerability.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}


// File @openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol@v4.9.3

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC721/extensions/IERC721Enumerable.sol)

pragma solidity ^0.8.0;

/**
 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
interface IERC721Enumerable is IERC721 {
    /**
     * @dev Returns the total amount of tokens stored by the contract.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns a token ID owned by `owner` at a given `index` of its token list.
     * Use along with {balanceOf} to enumerate all of ``owner``'s tokens.
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);

    /**
     * @dev Returns a token ID at a given `index` of all the tokens stored by the contract.
     * Use along with {totalSupply} to enumerate all tokens.
     */
    function tokenByIndex(uint256 index) external view returns (uint256);
}


// File @openzeppelin/contracts/token/ERC20/IERC20.sol@v4.9.3

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}


// File @openzeppelin/contracts/token/ERC721/IERC721Receiver.sol@v4.9.3

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC721/IERC721Receiver.sol)

pragma solidity ^0.8.0;

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721Receiver.onERC721Received.selector`.
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}


// File @openzeppelin/contracts/utils/Counters.sol@v4.9.3

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Counters.sol)

pragma solidity ^0.8.0;

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented, decremented or reset. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 */
library Counters {
    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1;
        }
    }

    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1;
        }
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}


// File contracts/interfaces/IQFG.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.0;


interface IQFGStatsV2 {

    function setStatsArray(string[] memory _statsArray) external returns(bool);
    function getStatsArray() external view returns (string[] memory);
    function getStatsArrayLength() external view returns (uint256);
   
}


interface IQFGBattleGame {

    function setQFGStats(uint256 tokenId, uint256[] memory _stats) external;

}


// File contracts/QFGBattleGame.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.19;






interface IQFGNFT is IERC721Enumerable {
    function tokensOfOwner(address _owner) external view returns(uint256[] memory);
}

contract QFGBattleGame is Ownable, IERC721Receiver {
    using Counters for Counters.Counter;
    Counters.Counter private _matchIdCounter;

    IQFGNFT private NFTContract;
    IERC20 private TokenContract;
    IQFGStatsV2 public StatContract;

    bool public isInitialize;

    struct QFGStats {
        uint256[] stats;
    }

    struct Battle {
        uint256 matchId; //
        uint256 statIndex; //
        uint256 battleamount; //
        uint256 fee; //
        uint256 reward; //
        uint256 createdAt; //
        uint256 playedAt; //
        address creatorAddress; // who created this battle
        address playerAddress; // who played this battle
        uint8 result; // 1 for creator,  2 for player, 3 for Draw
        mapping(uint8 => uint[]) nftIds; // 1 for creator,  2 for player
        mapping(uint8 => uint[]) nftstats; // 1 for creator,  2 for player
        mapping(uint8 => uint) stat; // 1 for creator,  2 for player
    }
    
    struct User {
        uint[] battleCreated;
        uint[] battlePlayed;
        uint[] battleWon;
    }

    address public feeAddress;
    uint256 public fee = 500; //5%
    uint256 public MIN_CARD_DECK = 10;
    uint256 public SELECT_CARD_FROM_DECK = 6;
    uint256 public maxAIPlayAmount = 1000 ether;

    mapping(uint256 => Battle) private _battle;
    mapping(address => User) private _userInfo;
    mapping(uint256 => bool) public matchIdExist;
    mapping(uint256 => bool) public winnerDeclared;
    mapping(uint256 => BattleStatus) private battleStatus;
    mapping(uint256 => QFGStats) private _qfgStats;
    mapping(address => bool) private isWhitelist;

    enum BattleStatus {
        Close,
        Open,
        Cancel,
        Draw
    }

    event BattleCreated(uint matchId, uint tokenAmount, address creator);
    event JoinBattle(uint matchId, address player);
    event BattleCancelled(uint matchId);
    event BattleWithAI(uint matchId, address player);

    function isContract(address _addr) private view returns (bool iscontract) {
        uint32 size;
        assembly {
            size := extcodesize(_addr)
        }
        return (size > 0);
    }

    function initialize(
        address _nft,
        address _token,
        address statContractAddress
    ) public {
        require(!isInitialize, "Already Initialize!");
        require(owner() == msg.sender, "Only owner can initialize");
        require(_nft != address(0) && _token != address(0));
        require(
            isContract(statContractAddress),
            "Stat Address is not contract"
        );
        feeAddress = msg.sender;
        isWhitelist[_nft] = true;
        isWhitelist[statContractAddress];
        NFTContract = IQFGNFT(_nft);
        TokenContract = IERC20(_token);
        StatContract = IQFGStatsV2(statContractAddress);
        isInitialize = true;
    }

    function createBattle(uint256 _tokenamount, uint statindex) external returns (uint256) {
        uint256 numNFTs = NFTContract.balanceOf(msg.sender);
        require(numNFTs >= MIN_CARD_DECK, "Insufficient Nfts balance to play!");
        require(
            TokenContract.balanceOf(msg.sender) >= _tokenamount,
            "Insufficient Token to play "
        );

        //getting random any 6 nfts from user's nftids balance
        uint256[] memory selectedNftIds = selectRandom();
        uint256[] memory selectedNftStats = new uint256[](
            SELECT_CARD_FROM_DECK
        ); 

        string[] memory stattype = StatContract.getStatsArray();
        require(statindex < stattype.length, "Wrong Index");

        uint256 stat;       
        for (uint256 i = 0; i < SELECT_CARD_FROM_DECK; i++) {
            uint256 nft = selectedNftIds[i];
            QFGStats memory nftstats = _qfgStats[nft];
            stat += nftstats.stats[statindex];
            selectedNftStats[i] = nftstats.stats[statindex];
        }

        // working with the selected NFT IDs and sum of stat...
        _matchIdCounter.increment();
        uint256 _matchId = _matchIdCounter.current();
        (uint256 fees, uint256 reward) = calculateFeeAndReward(_tokenamount);
        Battle storage battleDetails = _battle[_matchId];

        battleDetails.matchId = _matchId;
        battleDetails.statIndex = statindex;
        battleDetails.battleamount = _tokenamount;
        battleDetails.fee = fees;
        battleDetails.reward = reward;
        battleDetails.createdAt = block.timestamp;
        battleDetails.creatorAddress = msg.sender;
        battleDetails.nftIds[1] = selectedNftIds;
        battleDetails.nftstats[1] = selectedNftStats;
        battleDetails.stat[1] = stat;

        _userInfo[msg.sender].battleCreated.push(_matchId);
        battleStatus[_matchId] = BattleStatus.Open;
        matchIdExist[_matchId] = true;

        //Perform the transfer of nft from user to contract actions with the selected NFT IDs
        // address creatoraddress;
        for (uint256 i = 0; i < SELECT_CARD_FROM_DECK; i++) {
            uint256 randomNftId = selectedNftIds[i];
            // creatoraddress = NFTContract.ownerOf(randomNftId);
            NFTContract.safeTransferFrom(
                msg.sender,
                address(this),
                randomNftId
            );
        }
        // take token to create battle
        TokenContract.transferFrom(msg.sender, address(this), _tokenamount);

        emit BattleCreated(_matchId, _tokenamount, msg.sender);
        return _matchId;
    }

    function joinBattle(uint _matchId) external {
        require(matchIdExist[_matchId], "Invalid MatchId!!");
        require(!winnerDeclared[_matchId], "MatchId closed");
        uint256 numNFTs = NFTContract.balanceOf(msg.sender);
        require(numNFTs >= MIN_CARD_DECK, "Insufficient Nfts balance to play!");
        Battle storage battleDetails = _battle[_matchId];
        battleDetails.playedAt = block.timestamp;
        battleDetails.playerAddress = msg.sender;

        uint battleAmount = battleDetails.battleamount;
        require(
            TokenContract.balanceOf(msg.sender) >= battleAmount,
            "Insufficient Tokens Balance!"
        );
        require(battleDetails.creatorAddress != msg.sender, "Can't Play");

        // take token to play battle
        TokenContract.transferFrom(msg.sender, address(this), battleAmount);

        _userInfo[msg.sender].battlePlayed.push(_matchId);

        //getting random any 6 nfts from user's nftids balance
        uint256[] memory selectedNftIds = selectRandom();
        uint256[] memory selectedNftStats = new uint256[](
            SELECT_CARD_FROM_DECK
        );

        uint8 result; // 1 = creatorWin, 2 = playerWin, 3 = Draw

        uint statindex = battleDetails.statIndex;
        uint stat;
        for (uint256 i = 0; i < SELECT_CARD_FROM_DECK; i++) {
            uint256 nft = selectedNftIds[i];
            QFGStats memory nftstats = _qfgStats[nft];
            stat += nftstats.stats[statindex];
            selectedNftStats[i] = nftstats.stats[statindex];
        }

        battleDetails.nftIds[2] = selectedNftIds;
        battleDetails.nftstats[2] = selectedNftStats;
        battleDetails.stat[2] = stat;

        uint creatorStats = battleDetails.stat[1];
        address creatorAddress = battleDetails.creatorAddress;

        //Winning conditions
        if (creatorStats > stat) {
            // creator win
            _userInfo[creatorAddress].battleWon.push(_matchId);
            result = uint8(1);
            battleStatus[_matchId] = BattleStatus.Close;
            sendReward(battleAmount, creatorAddress);
        } else if (creatorStats < stat) {
            // player win
            _userInfo[msg.sender].battleWon.push(_matchId);
            result = uint8(2);
            battleStatus[_matchId] = BattleStatus.Close;
            sendReward(battleAmount, msg.sender);
        } else {
            // draw
            result = uint8(3);
            battleStatus[_matchId] = BattleStatus.Draw;
        }

        winnerDeclared[_matchId] = true;
        battleDetails.result = result;

        // nfts giving back to battle creator
        uint totalNfts = battleDetails.nftIds[1].length;
        uint[] memory nftIds = battleDetails.nftIds[1];

        for (uint256 i = 0; i < totalNfts; i++) {
            NFTContract.safeTransferFrom(
                address(this),
                creatorAddress,
                nftIds[i]
            );
        }

        emit JoinBattle(_matchId, msg.sender);
    }

    function battleWithAI(uint _tokenamount) external {
        uint256 numNFTs = NFTContract.balanceOf(msg.sender);
        require(numNFTs >= MIN_CARD_DECK, "Insufficient Nfts balance to play!");
        
        require(
           maxAIPlayAmount > _tokenamount,
            "battleWithAI: amount too high"
        );

        // getting random any 6 nfts from user's nftids balance
        uint256[] memory selectedNftIds = selectRandom();
        uint256[] memory selectedNftStats = new uint256[](
            SELECT_CARD_FROM_DECK
        );

        string[] memory stattype = StatContract.getStatsArray();
        uint256 statindex = uint256(
            keccak256(
                abi.encodePacked(block.timestamp, block.prevrandao, msg.sender)
            )
        ) % stattype.length;
        uint256 stat;
        for (uint256 i = 0; i < SELECT_CARD_FROM_DECK; i++) {
            uint256 nft = selectedNftIds[i];
            QFGStats memory nftstats = _qfgStats[nft];
            for (uint256 j = 0; j < stattype.length; j++) {
                if (statindex == j) {
                    uint power = nftstats.stats[j];
                    stat += power;
                    selectedNftStats[i] = power;
                }  
            } 
        } 

        // working with the selected NFT IDs and sum of stat...
        _matchIdCounter.increment();
        uint256 _matchId = _matchIdCounter.current();
        (uint256 fees, uint256 reward) = calculateFeeAndReward(_tokenamount);
        Battle storage battleDetails = _battle[_matchId];

        battleDetails.matchId = _matchId;
        battleDetails.statIndex = statindex;
        battleDetails.battleamount = _tokenamount;
        battleDetails.fee = fees;
        battleDetails.reward = reward;
        battleDetails.createdAt = block.timestamp;
        battleDetails.playedAt = block.timestamp;
        battleDetails.creatorAddress = msg.sender;
        battleDetails.playerAddress = address(0);
        battleDetails.nftIds[1] = selectedNftIds;
        battleDetails.nftstats[1] = selectedNftStats;
        battleDetails.stat[1] = stat;

        _userInfo[msg.sender].battleCreated.push(_matchId);

        // take token to create battle
        TokenContract.transferFrom(msg.sender, address(this), _tokenamount);

        // fetch any random nft ID from total minted Ntfs
        uint256[] memory aiIds = selectRandomforAI();
        uint256[] memory selectedNftStatsAI = new uint256[](
            SELECT_CARD_FROM_DECK
        );

        uint8 result; // 1 = creatorWin, 2 = playerWin, 3 = Draw

        uint statAI;
        for (uint256 i = 0; i < SELECT_CARD_FROM_DECK; i++) {
            uint256 nft = aiIds[i];
            QFGStats memory nftstats = _qfgStats[nft];
            stat += nftstats.stats[statindex];
            selectedNftStats[i] = nftstats.stats[statindex];
        }

        battleDetails.nftIds[2] = aiIds;
        battleDetails.nftstats[2] = selectedNftStatsAI;
        battleDetails.stat[2] = statAI;

        //Winning conditions
        if (stat > statAI) {
            // creator win
            _userInfo[msg.sender].battleWon.push(_matchId);
            result = uint8(1);
            battleStatus[_matchId] = BattleStatus.Close;
            sendReward(_tokenamount, msg.sender);
        } else if (stat < statAI) {
            // ai win
            result = uint8(2);
            battleStatus[_matchId] = BattleStatus.Close;
        } else {
            // draw
            result = uint8(3);
            battleStatus[_matchId] = BattleStatus.Draw;
        }

        winnerDeclared[_matchId] = true;
        battleDetails.result = result;

        emit BattleWithAI(_matchId, msg.sender);
    }

    function cancelBattle(uint _matchId) external {
        require(matchIdExist[_matchId], "Invalid MatchId!!");
        require(!winnerDeclared[_matchId], "MatchId closed");
        require(
            battleStatus[_matchId] != BattleStatus.Cancel,
            "Battle is already Closed"
        );
        require(
            battleStatus[_matchId] == BattleStatus.Open,
            "Battle is not Open"
        );
        Battle storage battleDetails = _battle[_matchId];
        require(
            battleDetails.creatorAddress == msg.sender,
            "You are not the creator!"
        );

        battleStatus[_matchId] = BattleStatus.Cancel;
        matchIdExist[_matchId] = false;

        // nfts giving back to battle creator
        uint totalNfts = battleDetails.nftIds[1].length;
        uint[] memory nftIds = battleDetails.nftIds[1];

        for (uint256 i = 0; i < totalNfts; i++) {
            NFTContract.safeTransferFrom(address(this), msg.sender, nftIds[i]);
        }
        TokenContract.transfer(msg.sender, battleDetails.battleamount);

        emit BattleCancelled(_matchId);
    }

    function selectRandom() internal returns(uint256[] memory) {
        (bool success, bytes memory result) = address(NFTContract).call(abi.encodeWithSignature("tokensOfOwner(address)", msg.sender));
        require(success, "Call to 'tokensOfOwner()' function failed");
        uint256[] memory nftIds = abi.decode(result, (uint256[]));
        require(nftIds.length >= SELECT_CARD_FROM_DECK, "Insufficient NFTs balance to select.");
        uint256[] memory selectedNftIds = new uint256[](SELECT_CARD_FROM_DECK);
        //Select 6 random NFT IDs
        for (uint256 i = 0; i < SELECT_CARD_FROM_DECK; i++) {
            uint256 randomIndex = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender, i))) % nftIds.length;
            selectedNftIds[i] = nftIds[randomIndex];
            // Remove the selected NFT ID from the array by shifting elements
            for (uint256 j = randomIndex; j < nftIds.length - 1; j++) {
                nftIds[j] = nftIds[j + 1];
            }
            // Resize the array by creating a new array with length-1
            uint256[] memory resizedArray = new uint256[](nftIds.length - 1);
            for (uint256 j = 0; j < resizedArray.length; j++) {
                resizedArray[j] = nftIds[j];
            }
            nftIds = resizedArray;
        }
        return selectedNftIds;
    }

    function selectRandomforAI() internal view returns(uint256[] memory) {
       
        uint totalSupply = NFTContract.totalSupply();
        uint256[] memory selectedNftIds = new uint256[](SELECT_CARD_FROM_DECK);

        uint counter = 0;
        //Select 6 random NFT IDs from totalSupply
        for (uint256 i = 0; i < SELECT_CARD_FROM_DECK; i++) {
            bool isIdNotFound = true;
            while (isIdNotFound) {
              uint256 randomId = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender, counter))) % totalSupply + 1;
              counter = counter + 1;
              address idOwner = NFTContract.ownerOf(randomId);
              if (idOwner != msg.sender) {
                isIdNotFound = false;
                selectedNftIds[i] = randomId;
              }
            }
        }

        return selectedNftIds;
    }

    // function selectRandom() internal returns (uint256[] memory) {
    //     uint256[] memory nftIds = NFTContract.tokensOfOwner(msg.sender); 
    //     require(
    //         nftIds.length >= SELECT_CARD_FROM_DECK,
    //         "Insufficient NFTs balance to select."
    //     );

    //     uint256[] memory selectedNftIds = new uint256[](SELECT_CARD_FROM_DECK);

    //     for (uint256 i = 0; i < SELECT_CARD_FROM_DECK; i++) {
    //         uint256 randomIndex = uint256(
    //             keccak256(abi.encodePacked(block.timestamp, msg.sender, i))
    //         ) % nftIds.length;
    //         selectedNftIds[i] = nftIds[randomIndex];



  
    //     }

    //     return selectedNftIds;
    // }

    function sendReward(uint256 _battleamount, address _winner) internal {
        uint256 amount = _battleamount * 2;
        uint256 platformFee = (amount * fee) / 10000;
        uint256 winamount = amount - platformFee;
        TokenContract.transfer(feeAddress, platformFee);
        TokenContract.transfer(_winner, winamount);
    }

    function calculateFeeAndReward(
        uint256 _battleamount
    ) internal view returns (uint256, uint256) {
        uint256 amount = _battleamount + _battleamount;
        uint256 platformFee = (amount * fee) / 10000;
        uint256 winamount = amount - platformFee;
        return (platformFee, winamount);
    }

    function setInitialize(bool _bool) external onlyOwner {
        isInitialize = _bool;
    }

    function setMinCardDeck(uint256 _deck) external onlyOwner {
        (bool success, bytes memory result) = address(NFTContract).call(
            abi.encodeWithSignature("MAX_TO_MINT()")
        );
        require(success, "Call to 'MAX_TO_MINT()' function failed");
        uint256 mintlimit = abi.decode(result, (uint256));
        require(
            _deck < mintlimit,
            "minimum deck limit must be less than miniting limit!"
        );
        MIN_CARD_DECK = _deck;
    }

    function setSelectCardFromDeck(uint256 _selectCard) external onlyOwner {
        SELECT_CARD_FROM_DECK = _selectCard;
    }

    function setTokenaddress(address _token) public onlyOwner {
        require(isContract(address(_token)), "This address is not a contract!");
        TokenContract = IERC20(_token);
    }

    function setFeeAddress(address _feeCollector) public onlyOwner {
        require(
            _feeCollector != address(0),
            "Fee address can't be set to Zero!"
        );
        feeAddress = _feeCollector;
    }

    function setFeePercent(uint256 _fee) public onlyOwner {
        require(_fee > 0, "Fee percent should be greater than Zero !");
        fee = _fee;
    }

    function setQFGStats(uint256 tokenId, uint256[] memory _stats) external {
        require(
            isWhitelist[msg.sender],
            "StatsContract: Only the whitelisted addresses can set Pokemon stats."
        );
        uint256 sumofstats;
        for (uint256 i = 0; i < _stats.length; i++) {
            sumofstats += _stats[i];
        }
        //////////////////console.log("sumofstats - ",sumofstats);
        // require(sumofstats <= 150 && sumofstats >= 50, "StatsContract: Total stats can't exceed 150.");
        require(sumofstats >= 50, "Error :- Sum of stats less than 50!");
        require(sumofstats <= 150, "Error :- Sum of stats greater than 150!");

        QFGStats memory stat = QFGStats({stats: _stats});
        _qfgStats[tokenId] = stat;
    }

    // //  GETTER FUNCTIONS
    function getQFGNFTStats(
        uint256 tokenId
    ) external view returns (uint256[] memory) {
        QFGStats memory stats = _qfgStats[tokenId];
        return (stats.stats); 
    }

    function getBattleInfo(
        uint256 _matchId
    )
        external
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            address,
            address,
            uint8
        )
    {
        Battle storage battleDetails = _battle[_matchId];
        return (
            battleDetails.matchId,
            battleDetails.statIndex,
            battleDetails.battleamount,
            battleDetails.fee,
            battleDetails.reward,
            battleDetails.createdAt,
            battleDetails.playedAt,
            battleDetails.creatorAddress,
            battleDetails.playerAddress,
            battleDetails.result
        );
    }

    function getBattleCreatorStats(
        uint _matchId
    ) external view returns (uint[] memory, uint[] memory, uint, uint) {
        Battle storage battleDetails = _battle[_matchId];
        return (
            battleDetails.nftIds[1],
            battleDetails.nftstats[1],
            battleDetails.stat[1],
            battleDetails.statIndex
        );
    }

    function getBattleJoinerStats(
        uint _matchId
    ) external view returns (uint[] memory, uint[] memory, uint) {
        Battle storage battleDetails = _battle[_matchId];
        return (
            battleDetails.nftIds[2],
            battleDetails.nftstats[2],
            battleDetails.stat[2]
        );
    }

    function getUserCreatedBattles(
        address _user
    ) public view returns (uint[] memory) {
        User storage userDetails = _userInfo[_user];
        return userDetails.battleCreated;
    }

    function getUserPlayedBattles(
        address _user
    ) public view returns (uint[] memory) {
        User storage userDetails = _userInfo[_user];
        return userDetails.battlePlayed;
    }

    function getUserWonBattles(
        address _user
    ) public view returns (uint[] memory) {
        User storage userDetails = _userInfo[_user];
        return userDetails.battleWon;
    }

    function getUserAllBattles(
        address _user
    ) external view returns (uint[] memory, uint[] memory, uint[] memory) {
        return (
            getUserCreatedBattles(_user),
            getUserPlayedBattles(_user),
            getUserWonBattles(_user)
        );
    }

    function isWhitelisted(address _addr) external view returns (bool) {
        return isWhitelist[_addr];
    }

    function getNFTContract() external view returns (IQFGNFT) {
        return NFTContract;
    }

    function getTokenContract() external view returns (IERC20) {
        return TokenContract;
    }

    function getWinner(uint256 _matchId) external view returns (address) {
        Battle storage battleDetails = _battle[_matchId];
        uint8 result = uint8(battleDetails.result);

        if (result == uint8(1)) {
            return battleDetails.creatorAddress;
        } else if (result == uint8(2)) {
            return battleDetails.playerAddress;
        } else {
            return address(0);
        }
    }

    function getstatArrayfromStat() public view returns (string[] memory) {
        return StatContract.getStatsArray();
    }

    function getBattleStatus(
        uint256 _matchId
    ) external view returns (string memory) {
        if (battleStatus[_matchId] == BattleStatus.Close) {
            return "Close"; //Close, Open, Cancel, Draw
        } else if (battleStatus[_matchId] == BattleStatus.Open) {
            return "Open";
        } else if (battleStatus[_matchId] == BattleStatus.Cancel) {
            return "Cancel";
        } else {
            return "Draw";
        }
    }

    function getOpenBattles() public view returns (uint[] memory) {
        uint totalBattles = _matchIdCounter.current();
        uint[] memory openBattlesIds = new uint[](totalBattles);
        uint counter;
        for (uint i = 1; i <= totalBattles; i = i + 1) {
            if (battleStatus[i] == BattleStatus.Open) {
                openBattlesIds[counter] = i;
                counter++;
            }
        }
        return openBattlesIds;
    }

    function getCancelBattles() public view returns (uint[] memory) {
        uint totalBattles = _matchIdCounter.current();
        uint[] memory cancelBattlesIds = new uint[](totalBattles);
        uint counter;
        for (uint i = 1; i <= totalBattles; i = i + 1) {
            if (battleStatus[i] == BattleStatus.Cancel) {
                cancelBattlesIds[counter] = i;
                counter++;
            }
        }
        return cancelBattlesIds;
    }

    function getDrawBattles() public view returns (uint[] memory) {
        uint totalBattles = _matchIdCounter.current();
        uint[] memory drawBattlesIds = new uint[](totalBattles);
        uint counter;
        for (uint i = 1; i <= totalBattles; i = i + 1) {
            if (battleStatus[i] == BattleStatus.Draw) {
                drawBattlesIds[counter] = i;
                counter++;
            }
        }
        return drawBattlesIds;
    }

    function getCloseBattles() public view returns (uint[] memory) {
        uint totalBattles = _matchIdCounter.current();
        uint[] memory closeBattlesIds = new uint[](totalBattles);
        uint counter;
        for (uint i = 1; i <= totalBattles; i = i + 1) {
            if (battleStatus[i] == BattleStatus.Close) {
                closeBattlesIds[counter] = i;
                counter++;
            }
        }
        return closeBattlesIds;
    }

    function getAllBattles()
        external
        view
        returns (uint[] memory, uint[] memory, uint[] memory, uint[] memory)
    {
        return (
            getOpenBattles(),
            getCloseBattles(),
            getDrawBattles(),
            getCancelBattles()
        );
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }


}
