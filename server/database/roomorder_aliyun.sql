/*
Navicat MySQL Data Transfer

Source Server         : aliyun
Source Server Version : 80013
Source Host           : localhost:3306
Source Database       : ktv

Target Server Type    : MYSQL
Target Server Version : 80013
File Encoding         : 65001

Date: 2019-01-14 01:06:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for roomorder
-- ----------------------------
DROP TABLE IF EXISTS `roomorder`;
CREATE TABLE `roomorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nun` varchar(50) DEFAULT NULL,
  `room` varchar(50) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `package` varchar(50) DEFAULT NULL,
  `packageType` int(11) DEFAULT NULL,
  `grpSelected` varchar(50) DEFAULT NULL,
  `goods` varchar(255) DEFAULT NULL,
  `qty` varchar(255) DEFAULT NULL,
  `startTime` bigint(20) NOT NULL COMMENT '下单时间',
  `endTime` bigint(20) DEFAULT NULL,
  `vip` varchar(50) DEFAULT NULL,
  `totalPrice` decimal(10,2) DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `payMethod` int(11) DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL COMMENT '收银员',
  `printTime` bigint(20) DEFAULT NULL COMMENT '打单时间',
  `createTime` bigint(20) NOT NULL,
  `off` int(11) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of roomorder
-- ----------------------------
INSERT INTO `roomorder` VALUES ('9', '471547135735775', '6666', '1', '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '1', '3', '', '', '1547135735465', '1547135740334', null, '298.00', null, '3', '收银员1', null, '1547135735775', '1');
INSERT INTO `roomorder` VALUES ('10', '321547135760384', '6666', '1', '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '1', '23', '6,14,16,17,18,21', '1,1,1,5,5,1', '1547135760073', null, '15920055057', '538.00', null, null, '收银员1', null, '1547135760384', '1');
INSERT INTO `roomorder` VALUES ('11', '291547185874727', '8016', '1', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '1', '3', '', '', '1547185874893', '1547186303675', null, '98.00', '48.00', '4', '收银员1', null, '1547185874727', '1');
INSERT INTO `roomorder` VALUES ('12', '211547203508309', '8016', '1', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '1', '3', '', '', '1547203508806', null, null, '98.00', null, null, '收银员1', null, '1547203508309', '1');
INSERT INTO `roomorder` VALUES ('13', '971547211208884', '8016', '1', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '1', '2', '2,6,19', '10,4,3', '1547211208378', null, null, '240.00', '1.00', null, '收银员1', null, '1547211208884', '1');
INSERT INTO `roomorder` VALUES ('14', '851547211208971', '8016', '1', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '1', '2', '2,6,19', '10,4,3', '1547211209729', null, null, '240.00', '1.00', null, '收银员1', null, '1547211208971', '1');
INSERT INTO `roomorder` VALUES ('15', '211547373283305', '8016', '1', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '1', '3', '', '', '1547373286861', '1547373311112', null, '98.00', '28.00', '4', '收银员1', null, '1547373283305', '1');
INSERT INTO `roomorder` VALUES ('16', '091547376260495', '6666', '1', '9d1432e0-13f6-11e9-86ad-915cb8e24559', '1', '', '', '', '1547376264078', null, null, '80.00', null, null, '收银员1', null, '1547376260495', '1');
INSERT INTO `roomorder` VALUES ('17', '141547377417376', '8011', '1', 'f0664fa0-1720-11e9-b5e7-cd0a8c11a7bb', '2', '', '', '', '1547377420958', null, null, '80.00', null, null, '收银员1', null, '1547377417376', '1');
INSERT INTO `roomorder` VALUES ('18', '281547377668602', '8016', '1', '15e48c10-1721-11e9-b5e7-cd0a8c11a7bb', '2', '', '', '', '1547377672184', null, null, '60.00', null, null, '收银员1', null, '1547377668602', '1');
INSERT INTO `roomorder` VALUES ('19', '601547378368631', '8016', '1', '15e48c10-1721-11e9-b5e7-cd0a8c11a7bb', '2', '', '', '', '1547378371882', '1547378377679', null, '60.00', null, '2', '收银员1', null, '1547378368631', '1');
INSERT INTO `roomorder` VALUES ('20', '241547382971514', '8016', '1', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '2', '2', '', '', '1547382974898', '1547387114704', null, '198.00', '48.00', '4', '收银员1', null, '1547382971514', '1');
INSERT INTO `roomorder` VALUES ('21', '041547384393908', '8012', '1', '4b53d400-121c-11e9-9989-d75a6f62cec3', '2', '3', '', '', '1547384397326', null, null, '298.00', '198.00', '4', '收银员1', null, '1547384393908', '1');
INSERT INTO `roomorder` VALUES ('22', '061547384998016', '8012', '1', '4b53d400-121c-11e9-9989-d75a6f62cec3', '2', '3', '', '', '1547385001483', '1547385030110', null, '298.00', '198.00', '4', '收银员1', null, '1547384998016', '1');
