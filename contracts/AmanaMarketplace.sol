pragma solidity ^0.5.0;

import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./AmanaAuthorizable.sol";



/**
 * @title AmanaMarketplace
 * @notice Implements the classifieds board market. The market will be governed
 * by an ERC20 token as currency, and an ERC721 token that represents the
 * ownership of the items being traded. Only ads for selling items are
 * implemented. The item tokenization is responsibility of the ERC721 contract
 * which should encode any item details.
 */
contract AmanaMarketplace is AmanaAuthorizable {
    event TradeStatusChange(uint256 ad, bytes32 status);
    event BidStatusChange(uint256 ad, bytes32 status);

    IERC20 currencyToken;
    IERC721 itemToken;

    struct Trade {
        address poster;
        uint256 item;
        uint256 price;
        bytes32 status; // Open, Executed, Cancelled
        bytes32 tradeType; // Offer, Bid
        mapping(uint256 => Bid) bids;
        uint256 bidCounter;
    }

    struct Bid {
        address bidder;
        uint256 item;
        uint256 price;
        bytes32 status; // Open, Executed, Cancelled
        bytes32 visibility; // Open, OnlyOwner, 
    }

    mapping(uint256 => Trade) public trades;
    mapping(uint256 => Bid) public bids;

    uint256 tradeCounter;
    uint256 bidCounter;

    constructor (address _currencyTokenAddress, address _itemTokenAddress)
        public
    {
        currencyToken = IERC20(_currencyTokenAddress);
        itemToken = IERC721(_itemTokenAddress);
        tradeCounter = 0;
        bidCounter = 0;
    }

    /**
     * @dev Returns the details for a trade.
     * @param _trade The id for the trade.
     */
    function getTrade(uint256 _trade)
        public
        view
        returns(address, uint256, uint256, bytes32, bytes32, mapping(uint256 => Bid))
    {
        Trade memory trade = trades[_trade];
        return (trade.poster, trade.item, trade.price, trade.status, trade.tradeType, trade.bids);
    }

    /**
     * @dev Returns the details for a bid.
     * @param _trade The id for the trade.
     * @param _bid The id for the bid.
     */
    function getBid(uint256 _trade, uint256 _bid)
        public
        view
        returns(address, uint256, uint256, bytes32, address, uint256, uint256, bytes32)
    {
        Trade memory trade = trades[_trade];
        Bid memory bid = trade.bids[_bid];
        return (trade.poster, trade.item, trade.price, trade.status, bid.bidder, bid.item, bid.price, bid.status);
    }

    /**
     * @dev Opens a new bid. Puts _item in escrow.
     * @param _item The id for the item to bid on.
     * @param _price The amount of currency for which to bid the item.
     */
    function openBid(uint256 _item, uint256 _price)
        public
    {
        Trade memory trade = trades[tradeCounter-1];
        require(trade.tradeType == "Bid", "Trade must be bid type to open a bid.");
        trade.bids[trade.bidCounter] = Bid({
            poster: msg.sender,
            item: _item,
            price: _price,
            status: "Open"
        });
        trade.bidCounter += 1;
        emit BidStatusChange(trade.bidCounter - 1, "Open");
    }


    /**
     * @dev Opens a new trade. Puts _item in escrow.
     * @param _item The id for the item to trade.
     * @param _price The amount of currency for which to trade the item.
     */
    function openTrade(uint256 _item, uint256 _price, bytes32 _tradeType)
        public
    {
        itemToken.transferFrom(msg.sender, address(this), _item);
        trades[tradeCounter] = Trade({
            poster: msg.sender,
            item: _item,
            price: _price,
            status: "Open",
            tradeType: _tradeType
            bidCounter: 0
        });
        tradeCounter += 1;
        emit TradeStatusChange(tradeCounter - 1, "Open");
    }

    /**
     * @dev Executes a trade. Must have approved this contract to transfer the
     * amount of currency specified to the poster. Transfers ownership of the
     * item to the filler.
     * @param _trade The id of an existing trade
     */
    function executeTrade(uint256 _trade)
        public
    {
        Trade memory trade = trades[_trade];
        require(trade.status == "Open", "Trade is not Open.");
        require(trade.tradeType == "Offer", "Trade is not an offer type .");
        currencyToken.transferFrom(msg.sender, trade.poster, trade.price);
        itemToken.transferFrom(address(this), msg.sender, trade.item);
        trades[_trade].status = "Executed";
        emit TradeStatusChange(_trade, "Executed");
    }

    /**
     * @dev Executes a trade. Must have approved this contract to transfer the
     * amount of currency specified to the poster. Transfers ownership of the
     * item to the filler.
     * @param _trade The id of an existing trade
     */
    function executeBid(uint256 _trade, uint256 _bid)
        public
    {
        Trade memory trade = trades[_trade];
        require(
            msg.sender == trade.poster,
            "Bid can be accepted only by poster."
        );
        require(trade.status == "Open", "Trade is not Open.");
        require(trade.tradeType == "Bid", "Trade is not an bid type .");
        Bid memory bid = trade.bids[_bid];
        currencyToken.transferFrom(msg.sender, bid.bidder, bid.price);
        itemToken.transferFrom(address(this), bid.bidder, bid.item);
        trades[_trade].status = "Executed";
        trades[_trade].bids[_bid].status = "Executed";
        emit TradeStatusChange(_trade, "Executed");
        emit BidStatusChange(_bid, "Executed");
    }

    /**
     * @dev Cancels a trade by the poster.
     * @param _trade The trade to be cancelled.
     */
    function cancelTrade(uint256 _trade)
        public
    {
        Trade memory trade = trades[_trade];
        require(
            msg.sender == trade.poster,
            "Trade can be cancelled only by poster."
        );
        require(trade.status == "Open", "Trade is not Open.");
        itemToken.transferFrom(address(this), trade.poster, trade.item);
        trades[_trade].status = "Cancelled";
        emit TradeStatusChange(_trade, "Cancelled");
    }

    /**
     * @dev Cancels a trade by the poster.
     * @param _trade The trade to be cancelled.
     */
    function cancelBid(uint256 _bid)
        public
    {
        Trade memory trade = trades[_trade];
        Bid memory bid = trade.bids[_bid];
        require(
            msg.sender == bid.bidder,
            "Bid can be cancelled only by poster."
        );
        require(trade.status == "Open", "Trade is not Open.");
        require(trade.tradeType == "Bid", "Trade is not bid type.");
        itemToken.transferFrom(address(this), bid.bidder, bid.item);
        trades[_trade].status = "Cancelled";
        emit TradeStatusChange(_trade, "Cancelled");
    }


    function lateInitializee (address _currencyTokenAddress, address _itemTokenAddress)
        public
    {
        currencyToken = IERC20(_currencyTokenAddress);
        itemToken = IERC721(_itemTokenAddress);
        tradeCounter = 0;
    }
}