/*
Navicat MySQL Data Transfer

Source Server         : susa_rp
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : accounts

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-03-15 17:34:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `skin` int(255) DEFAULT NULL,
  `money` int(255) DEFAULT NULL,
  `team` varchar(255) DEFAULT NULL,
  `x` int(255) DEFAULT NULL,
  `y` int(255) DEFAULT NULL,
  `z` int(255) DEFAULT NULL,
  `inte` int(255) DEFAULT NULL,
  `dim` int(255) DEFAULT NULL,
  `d_licence` int(255) DEFAULT NULL,
  `b_licence` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of accounts
-- ----------------------------
INSERT INTO `accounts` VALUES ('karuzo', '559E9A6591B0F24DFF4F7254EEE517EEAE6429DB3D0BE3F2C2A3D43AC586EF5D', '58', '33159643', null, '-1988', '286', '34', '0', '0', '1', '0');
INSERT INTO `accounts` VALUES ('', '', null, null, '', null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for cars
-- ----------------------------
DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `CARID` int(11) NOT NULL,
  `SPAWNX` int(255) DEFAULT NULL,
  `SPAWNY` int(255) DEFAULT NULL,
  `SPAWNZ` int(255) DEFAULT NULL,
  `ROTX` int(255) DEFAULT NULL,
  `ROTY` int(255) DEFAULT NULL,
  `ROTZ` int(255) DEFAULT NULL,
  `R` int(255) DEFAULT NULL,
  `G` int(255) DEFAULT NULL,
  `B` int(255) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `PRICE` int(255) DEFAULT NULL,
  PRIMARY KEY (`CARID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of cars
-- ----------------------------
INSERT INTO `cars` VALUES ('415', '-1935', '270', '44', '0', '0', '50', '115', '231', '46', 'karuzo', '75000');
