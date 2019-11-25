delimiter $$

CREATE DATABASE `trade_data` /*!40100 DEFAULT CHARACTER SET latin1 */$$

delimiter $$

CREATE TABLE `options_data` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `time` varchar(32) NOT NULL,
  `underline` varchar(8) NOT NULL,
  `CALLPUT` varchar(1) NOT NULL,
  `price` double(5,2) NOT NULL,
  `volume` int(11) NOT NULL,
  `strike` double(5,2) NOT NULL,
  `QUOTE_TYPE` varchar(5) NOT NULL,
  `ticker_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`ticker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1$$

delimiter $$

CREATE
DEFINER=`root`@`localhost`
TRIGGER `trade_data`.`tPlaceOrder`
AFTER INSERT ON `trade_data`.`orders_queue`
FOR EACH ROW
set @d=(select place_order_fn())
$$

CREATE TABLE `orders_queue` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `orderId` int(32) DEFAULT '0',
  `symbol` varchar(45) DEFAULT NULL COMMENT 'symbol / string',
  `secType` varchar(45) DEFAULT NULL COMMENT 'Type of securities:\nOPT or STK',
  `expiry` varchar(45) DEFAULT NULL COMMENT 'expiration date. \nFormat: YYYYMMDD (opt only)',
  `strike` decimal(5,2) DEFAULT NULL COMMENT 'strike price (opt only)',
  `right` varchar(45) DEFAULT NULL COMMENT 'contract rights:\nCall/Put',
  `multiplier` int(10) DEFAULT '100',
  `exchange` varchar(45) DEFAULT 'SMART' COMMENT 'SMART',
  `primaryExchange` varchar(45) DEFAULT 'SMART',
  `currency` varchar(45) DEFAULT 'USD' COMMENT 'default: USD',
  `localSymbol` varchar(45) DEFAULT NULL COMMENT 'optional if expration present',
  `clientId` int(24) DEFAULT '1',
  `action` varchar(45) DEFAULT 'SELL',
  `totalQuantity` int(32) DEFAULT '10',
  `orderType` varchar(45) DEFAULT 'LMT',
  `tif` varchar(45) DEFAULT 'GTD' COMMENT '"Time in Force" - DAY, GTC, etc.',
  `transmit` varchar(10) DEFAULT 'TRUE' COMMENT 'if false, order will be created but not transmited',
  `triggerMethod` int(10) DEFAULT NULL COMMENT '0=Default, 1=Double_Bid_Ask, 2=Last, 3=Double_Last, 4=Bid_Ask, 7=Last_or_Bid_Ask, 8=Mid-point',
  `goodAfterTime` varchar(45) DEFAULT '20140112 15:59:00 EST' COMMENT 'Format: 20060505 08:00:00 {time zone',
  `goodTillDate` varchar(45) DEFAULT '20031126 15:59:00 EST' COMMENT 'Format: 20060505 08:00:00 {time zone}',
  `trailStopPrice` double DEFAULT NULL,
  `trailingPercent` varchar(45) DEFAULT NULL,
  `openClose` varchar(45) DEFAULT NULL COMMENT '// O=Open, C=Close',
  `origin` int(11) DEFAULT NULL COMMENT '0=Customer, 1=Firm',
  `shortSaleSlot` int(11) DEFAULT '2' COMMENT '1 if you hold the shares, 2 if they will be delivered from elsewhere.  Only for Action="SSHORT',
  `startingPrice` double DEFAULT '0',
  `stockRangeLower` double DEFAULT NULL,
  `stockRangeUpper` double DEFAULT NULL,
  `continuousUpdate` tinyint(1) DEFAULT NULL,
  `account` varchar(45) DEFAULT 'DU141201' COMMENT ' IB account',
  `lmtPrice` decimal(5,2) DEFAULT NULL,
  `auxPrice` decimal(5,2) DEFAULT NULL,
  `minQty` int(11) DEFAULT '1',
  `cancelInterval` int(32) NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `orderId_UNIQUE` (`orderId`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1$$

delimiter $$

CREATE TABLE `pending_orders` (
  `id` int(32) DEFAULT NULL,
  `orderId` int(32) NOT NULL DEFAULT '0',
  `symbol` varchar(45) DEFAULT NULL COMMENT 'symbol / string',
  `secType` varchar(45) DEFAULT NULL COMMENT 'Type of securities:\nOPT or STK',
  `expiry` varchar(45) DEFAULT NULL COMMENT 'expiration date. \nFormat: YYYYMMDD (opt only)',
  `strike` decimal(5,2) DEFAULT NULL COMMENT 'strike price (opt only)',
  `right` varchar(45) DEFAULT NULL COMMENT 'contract rights:\nCall/Put',
  `multiplier` int(10) DEFAULT '100',
  `exchange` varchar(45) DEFAULT 'SMART' COMMENT 'SMART',
  `primaryExchange` varchar(45) DEFAULT 'SMART',
  `currency` varchar(45) DEFAULT 'USD' COMMENT 'default: USD',
  `localSymbol` varchar(45) DEFAULT NULL COMMENT 'optional if expration present',
  `clientId` int(24) DEFAULT '1',
  `action` varchar(45) DEFAULT 'SELL',
  `totalQuantity` int(32) DEFAULT '10',
  `orderType` varchar(45) DEFAULT 'LMT',
  `tif` varchar(45) DEFAULT 'GTD' COMMENT '"Time in Force" - DAY, GTC, etc.',
  `transmit` varchar(10) DEFAULT 'TRUE' COMMENT 'if false, order will be created but not transmited',
  `triggerMethod` int(10) DEFAULT NULL COMMENT '0=Default, 1=Double_Bid_Ask, 2=Last, 3=Double_Last, 4=Bid_Ask, 7=Last_or_Bid_Ask, 8=Mid-point',
  `goodAfterTime` varchar(45) DEFAULT '20140112 15:59:00 EST' COMMENT 'Format: 20060505 08:00:00 {time zone',
  `goodTillDate` varchar(45) DEFAULT '20031126 15:59:00 EST' COMMENT 'Format: 20060505 08:00:00 {time zone}',
  `trailStopPrice` double DEFAULT NULL,
  `trailingPercent` varchar(45) DEFAULT NULL,
  `openClose` varchar(45) DEFAULT NULL COMMENT '// O=Open, C=Close',
  `origin` int(11) DEFAULT NULL COMMENT '0=Customer, 1=Firm',
  `shortSaleSlot` int(11) DEFAULT '2' COMMENT '1 if you hold the shares, 2 if they will be delivered from elsewhere.  Only for Action="SSHORT',
  `startingPrice` double DEFAULT '0',
  `stockRangeLower` double DEFAULT NULL,
  `stockRangeUpper` double DEFAULT NULL,
  `continuousUpdate` tinyint(1) DEFAULT NULL,
  `account` varchar(45) DEFAULT 'DU141201' COMMENT ' IB account',
  `lmtPrice` decimal(5,2) DEFAULT NULL,
  `auxPrice` decimal(5,2) DEFAULT NULL,
  `minQty` int(11) DEFAULT '1',
  `cancelInterval` int(32) NOT NULL DEFAULT '10',
  PRIMARY KEY (`orderId`),
  UNIQUE KEY `orderId_UNIQUE` (`orderId`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1$$

delimiter $$

CREATE TABLE `stock_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` varchar(45) DEFAULT NULL,
  `underline` varchar(8) DEFAULT NULL,
  `price` double(5,2) DEFAULT NULL,
  `volume` int(16) DEFAULT NULL,
  `ticker_id` int(16) DEFAULT NULL,
  `quote_type` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1$$


