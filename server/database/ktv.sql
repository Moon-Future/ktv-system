/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : ktv

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2019-01-05 02:29:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `unit` int(11) NOT NULL,
  `descr` varchar(255) DEFAULT NULL,
  `vipDiscount` int(11) NOT NULL DEFAULT '0' COMMENT '开启会员折扣',
  `discount` decimal(10,2) DEFAULT NULL COMMENT '会员折扣',
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1', '纯啤啤酒', null, '20.00', '1', '', '0', null, '1545710870689', null, '0');
INSERT INTO `goods` VALUES ('2', '冰纯啤酒', null, '30.00', '1', '冰火两重天！', '0', null, '1545710972654', null, '0');
INSERT INTO `goods` VALUES ('3', '雪花啤酒', null, '10.00', '1', '真的有雪花哦', '0', null, '1545711013154', null, '0');
INSERT INTO `goods` VALUES ('4', '华夏干红', null, '88.00', '1', '', '0', null, '1545711043902', null, '0');
INSERT INTO `goods` VALUES ('5', '雪碧', null, '5.00', '6', '透心凉', '0', null, '1545711071418', null, '0');
INSERT INTO `goods` VALUES ('6', '茶', null, '15.00', '7', '', '0', null, '1545711147913', null, '0');
INSERT INTO `goods` VALUES ('7', '爆米花', null, '10.00', '4', '爆！爆！爆！', '0', null, '1545711196951', null, '0');
INSERT INTO `goods` VALUES ('8', '蚕豆', null, '10.00', '2', '', '0', null, '1545711308809', null, '0');
INSERT INTO `goods` VALUES ('9', '瓜子', null, '10.00', '2', '', '0', null, '1545711339119', null, '0');
INSERT INTO `goods` VALUES ('10', '锅巴', null, '10.00', '2', '小吃', '0', null, '1545711366170', null, '0');
INSERT INTO `goods` VALUES ('11', '花生', null, '10.00', '2', '小吃', '0', null, '1545711380608', null, '0');
INSERT INTO `goods` VALUES ('12', '开心果', null, '10.00', '2', '小吃', '0', null, '1545711409836', null, '0');
INSERT INTO `goods` VALUES ('13', '杏仁', null, '10.00', '2', '小吃', '0', null, '1545711427555', null, '0');
INSERT INTO `goods` VALUES ('14', '什锦果盘小拼', null, '20.00', '2', '', '0', null, '1545711468435', null, '0');
INSERT INTO `goods` VALUES ('15', '什锦果盘中拼', null, '50.00', '2', '', '0', null, '1545711489771', null, '0');
INSERT INTO `goods` VALUES ('16', '什锦果盘大拼', null, '80.00', '2', '', '0', null, '1545711509813', null, '0');

-- ----------------------------
-- Table structure for package
-- ----------------------------
DROP TABLE IF EXISTS `package`;
CREATE TABLE `package` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `goods` int(11) DEFAULT NULL COMMENT '商品',
  `qty` int(11) DEFAULT NULL,
  `grp` varchar(50) DEFAULT NULL,
  `type1` int(11) DEFAULT NULL COMMENT '价格档 1：阳光档 2：黄金档',
  `price1` decimal(10,2) DEFAULT NULL COMMENT '阳光档价格',
  `type2` int(11) DEFAULT NULL COMMENT '2：黄金档',
  `price2` decimal(10,2) DEFAULT NULL COMMENT '黄金档价格',
  `descr` varchar(255) DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of package
-- ----------------------------
INSERT INTO `package` VALUES ('1', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '1', '12', '1,2,3', '0', '0.00', '1', '198.00', '1、纯啤啤酒12瓶 或 冰纯啤酒10瓶 或 雪花啤酒8瓶\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624646261', null, '0');
INSERT INTO `package` VALUES ('2', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '2', '10', '1,2,3', '0', '0.00', '1', '198.00', '1、纯啤啤酒12瓶 或 冰纯啤酒10瓶 或 雪花啤酒8瓶\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624646261', null, '0');
INSERT INTO `package` VALUES ('3', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '3', '8', '1,2,3', '0', '0.00', '1', '198.00', '1、纯啤啤酒12瓶 或 冰纯啤酒10瓶 或 雪花啤酒8瓶\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624646261', null, '0');
INSERT INTO `package` VALUES ('4', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '8', '1', '1,2,3', '0', '0.00', '1', '198.00', '1、纯啤啤酒12瓶 或 冰纯啤酒10瓶 或 雪花啤酒8瓶\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624646261', null, '0');
INSERT INTO `package` VALUES ('5', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '9', '1', '1,2,3', '0', '0.00', '1', '198.00', '1、纯啤啤酒12瓶 或 冰纯啤酒10瓶 或 雪花啤酒8瓶\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624646261', null, '0');
INSERT INTO `package` VALUES ('6', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '7', '1', '1,2,3', '0', '0.00', '1', '198.00', '1、纯啤啤酒12瓶 或 冰纯啤酒10瓶 或 雪花啤酒8瓶\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624646261', null, '0');
INSERT INTO `package` VALUES ('7', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '14', '1', '1,2,3', '0', '0.00', '1', '198.00', '1、纯啤啤酒12瓶 或 冰纯啤酒10瓶 或 雪花啤酒8瓶\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624646261', null, '0');
INSERT INTO `package` VALUES ('8', '5e2d9260-104a-11e9-a1db-0d5fe7aa5fe3', '红酒套餐', '4', '1', '', '1', '150.00', '1', '198.00', '1、华夏干红1支加雪碧2罐\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624720518', null, '0');
INSERT INTO `package` VALUES ('9', '5e2d9260-104a-11e9-a1db-0d5fe7aa5fe3', '红酒套餐', '5', '2', '', '1', '150.00', '1', '198.00', '1、华夏干红1支加雪碧2罐\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624720518', null, '0');
INSERT INTO `package` VALUES ('10', '5e2d9260-104a-11e9-a1db-0d5fe7aa5fe3', '红酒套餐', '8', '1', '', '1', '150.00', '1', '198.00', '1、华夏干红1支加雪碧2罐\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624720518', null, '0');
INSERT INTO `package` VALUES ('11', '5e2d9260-104a-11e9-a1db-0d5fe7aa5fe3', '红酒套餐', '9', '1', '', '1', '150.00', '1', '198.00', '1、华夏干红1支加雪碧2罐\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624720518', null, '0');
INSERT INTO `package` VALUES ('12', '5e2d9260-104a-11e9-a1db-0d5fe7aa5fe3', '红酒套餐', '7', '1', '', '1', '150.00', '1', '198.00', '1、华夏干红1支加雪碧2罐\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624720518', null, '0');
INSERT INTO `package` VALUES ('13', '5e2d9260-104a-11e9-a1db-0d5fe7aa5fe3', '红酒套餐', '14', '1', '', '1', '150.00', '1', '198.00', '1、华夏干红1支加雪碧2罐\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', '1546624720518', null, '0');
INSERT INTO `package` VALUES ('14', '994a79d0-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '1', '20', '1,2,3', '0', '0.00', '1', '298.00', '1、纯啤啤酒20瓶 或 冰纯啤酒15瓶 或 雪花啤酒12瓶\n2、小吃4份（蚕豆、瓜子、锅巴、花生），爆米花1包，什锦果盘中拼1个', '1546624819693', null, '0');
INSERT INTO `package` VALUES ('15', '994a79d0-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '2', '15', '1,2,3', '0', '0.00', '1', '298.00', '1、纯啤啤酒20瓶 或 冰纯啤酒15瓶 或 雪花啤酒12瓶\n2、小吃4份（蚕豆、瓜子、锅巴、花生），爆米花1包，什锦果盘中拼1个', '1546624819693', null, '0');
INSERT INTO `package` VALUES ('16', '994a79d0-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '3', '12', '1,2,3', '0', '0.00', '1', '298.00', '1、纯啤啤酒20瓶 或 冰纯啤酒15瓶 或 雪花啤酒12瓶\n2、小吃4份（蚕豆、瓜子、锅巴、花生），爆米花1包，什锦果盘中拼1个', '1546624819693', null, '0');
INSERT INTO `package` VALUES ('17', '994a79d0-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '8', '1', '1,2,3', '0', '0.00', '1', '298.00', '1、纯啤啤酒20瓶 或 冰纯啤酒15瓶 或 雪花啤酒12瓶\n2、小吃4份（蚕豆、瓜子、锅巴、花生），爆米花1包，什锦果盘中拼1个', '1546624819693', null, '0');
INSERT INTO `package` VALUES ('18', '994a79d0-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '9', '1', '1,2,3', '0', '0.00', '1', '298.00', '1、纯啤啤酒20瓶 或 冰纯啤酒15瓶 或 雪花啤酒12瓶\n2、小吃4份（蚕豆、瓜子、锅巴、花生），爆米花1包，什锦果盘中拼1个', '1546624819693', null, '0');
INSERT INTO `package` VALUES ('19', '994a79d0-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '10', '1', '1,2,3', '0', '0.00', '1', '298.00', '1、纯啤啤酒20瓶 或 冰纯啤酒15瓶 或 雪花啤酒12瓶\n2、小吃4份（蚕豆、瓜子、锅巴、花生），爆米花1包，什锦果盘中拼1个', '1546624819693', null, '0');
INSERT INTO `package` VALUES ('20', '994a79d0-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '11', '1', '1,2,3', '0', '0.00', '1', '298.00', '1、纯啤啤酒20瓶 或 冰纯啤酒15瓶 或 雪花啤酒12瓶\n2、小吃4份（蚕豆、瓜子、锅巴、花生），爆米花1包，什锦果盘中拼1个', '1546624819693', null, '0');
INSERT INTO `package` VALUES ('21', '994a79d0-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '7', '1', '1,2,3', '0', '0.00', '1', '298.00', '1、纯啤啤酒20瓶 或 冰纯啤酒15瓶 或 雪花啤酒12瓶\n2、小吃4份（蚕豆、瓜子、锅巴、花生），爆米花1包，什锦果盘中拼1个', '1546624819693', null, '0');
INSERT INTO `package` VALUES ('22', '994a79d0-104a-11e9-a1db-0d5fe7aa5fe3', '啤酒套餐', '15', '1', '1,2,3', '0', '0.00', '1', '298.00', '1、纯啤啤酒20瓶 或 冰纯啤酒15瓶 或 雪花啤酒12瓶\n2、小吃4份（蚕豆、瓜子、锅巴、花生），爆米花1包，什锦果盘中拼1个', '1546624819693', null, '0');
INSERT INTO `package` VALUES ('23', '0c62e470-104b-11e9-a1db-0d5fe7aa5fe3', '不要吃的', null, null, null, '1', '50.00', '1', '100.00', '我就爱音乐', '1546625012791', null, '0');

-- ----------------------------
-- Table structure for rechargerecord
-- ----------------------------
DROP TABLE IF EXISTS `rechargerecord`;
CREATE TABLE `rechargerecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `money` decimal(10,2) NOT NULL,
  `time` bigint(20) NOT NULL,
  `off` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of rechargerecord
-- ----------------------------
INSERT INTO `rechargerecord` VALUES ('1', '15920055057', '500.00', '1546495924925', '0');
INSERT INTO `rechargerecord` VALUES ('2', '15920055057', '350.00', '1546495946976', '0');
INSERT INTO `rechargerecord` VALUES ('3', '13888888888', '150.00', '1546495991224', '0');
INSERT INTO `rechargerecord` VALUES ('4', '15920055057', '66.00', '1546505550352', '0');
INSERT INTO `rechargerecord` VALUES ('5', '15920055057', '89.00', '1546505732081', '0');
INSERT INTO `rechargerecord` VALUES ('6', '15920055057', '66.00', '1546505739449', '0');
INSERT INTO `rechargerecord` VALUES ('7', '15920055057', '300.00', '1546505742950', '0');
INSERT INTO `rechargerecord` VALUES ('8', '15920055057', '1000.00', '1546505747784', '0');
INSERT INTO `rechargerecord` VALUES ('9', '15920055057', '58.00', '1546505774797', '0');
INSERT INTO `rechargerecord` VALUES ('10', '15920055057', '888.00', '1546505778472', '0');
INSERT INTO `rechargerecord` VALUES ('11', '15920055057', '990.00', '1546505781402', '0');
INSERT INTO `rechargerecord` VALUES ('12', '15920055057', '50.00', '1546505785616', '0');
INSERT INTO `rechargerecord` VALUES ('13', '15920055057', '200.00', '1546505788936', '0');
INSERT INTO `rechargerecord` VALUES ('14', '15920055057', '100.00', '1546505792998', '0');
INSERT INTO `rechargerecord` VALUES ('15', '15920055057', '600.00', '1546505806763', '0');

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(50) NOT NULL,
  `roomType` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `no` varchar(50) NOT NULL,
  `package` varchar(50) NOT NULL,
  `descr` varchar(255) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES ('1', '901039f0-084c-11e9-a567-470a0f92e677', '3', '南天门', '6666', '5e2d9260-104a-11e9-a1db-0d5fe7aa5fe3', '', '1_1', '1545730760693', '1546624957660', '0', '0');
INSERT INTO `room` VALUES ('2', 'f4999250-0828-11e9-8b7c-f90e6ffd643f', '1', '慈宁宫', '8011', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '来了，老弟', '1_2', '1545746053903', '1546624974155', '0', '0');
INSERT INTO `room` VALUES ('3', '901039f0-084c-11e9-a567-470a0f92e677', '3', '南天门', '6666', '994a79d0-104a-11e9-a1db-0d5fe7aa5fe3', '', '1_1', '1545746053903', '1546624974155', '0', '0');
INSERT INTO `room` VALUES ('4', '074c3690-084d-11e9-a567-470a0f92e677', '2', '月仙殿', '8012', '0c62e470-104b-11e9-a1db-0d5fe7aa5fe3', '', '1_3', '1545746253945', '1546625027889', '0', '0');
INSERT INTO `room` VALUES ('5', '11803670-084d-11e9-a567-470a0f92e677', '2', '景阳宫', '8013', '994a79d0-104a-11e9-a1db-0d5fe7aa5fe3', '', '1_4', '1545746271063', '1546625038040', '0', '0');
INSERT INTO `room` VALUES ('6', '11803670-084d-11e9-a567-470a0f92e677', '2', '景阳宫', '8013', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '', '1_4', '1545746271063', '1546625038040', '0', '0');
INSERT INTO `room` VALUES ('7', '1f69c440-084d-11e9-a567-470a0f92e677', '1', '景殿宫', '8015', '', '', '1_5', '1545746294404', '1546625051846', '0', '0');
INSERT INTO `room` VALUES ('8', '3575d710-084d-11e9-a567-470a0f92e677', '1', '雪舞宫', '8016', '', '', '1_6', '1545746331393', '1546625058808', '0', '0');
INSERT INTO `room` VALUES ('9', 'bc31d570-084c-11e9-a567-470a0f92e677', '3', '金箍棒', '9999', '5e2d9260-104a-11e9-a1db-0d5fe7aa5fe3', '', '2_1', '1545746480000', '1546624987650', '0', '0');
INSERT INTO `room` VALUES ('10', '927b2a00-084d-11e9-a567-470a0f92e677', '1', '天赐宫', '8017', '', '', '2_2', '1545746487456', '1546625070580', '0', '0');
INSERT INTO `room` VALUES ('11', 'a280ba00-084d-11e9-a567-470a0f92e677', '1', '玉华宫', '8019', '', '', '2_3', '1545746514336', '1546625078745', '0', '0');
INSERT INTO `room` VALUES ('12', 'b1c962a0-084d-11e9-a567-470a0f92e677', '2', '善岚宫', '8020', '', '', '2_4', '1545746539978', '1546625084681', '0', '0');
INSERT INTO `room` VALUES ('13', 'c063c9e0-084d-11e9-a567-470a0f92e677', '1', '凌妍阁', '8021', '', '', '2_5', '1545746564478', '1546625090513', '0', '0');
INSERT INTO `room` VALUES ('14', 'cc421e60-084d-11e9-a567-470a0f92e677', '1', '昭阳宫', '8022', '', '', '2_6', '1545746584390', '1546625094969', '0', '0');
INSERT INTO `room` VALUES ('15', 'fb867db0-084d-11e9-a567-470a0f92e677', '2', '薰梦宫', '8023', '', '', '2_7', '1545746663691', '1546625099224', '0', '0');

-- ----------------------------
-- Table structure for roomorder
-- ----------------------------
DROP TABLE IF EXISTS `roomorder`;
CREATE TABLE `roomorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room` varchar(50) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `package` varchar(50) DEFAULT NULL,
  `goods` varchar(255) DEFAULT NULL,
  `qty` varchar(255) DEFAULT NULL,
  `startTime` bigint(20) DEFAULT NULL,
  `cust` varchar(50) DEFAULT NULL,
  `createTime` bigint(20) NOT NULL,
  `off` int(11) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of roomorder
-- ----------------------------

-- ----------------------------
-- Table structure for roomtype
-- ----------------------------
DROP TABLE IF EXISTS `roomtype`;
CREATE TABLE `roomtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of roomtype
-- ----------------------------
INSERT INTO `roomtype` VALUES ('1', '标准包', '1545730484185', null, '0');
INSERT INTO `roomtype` VALUES ('2', 'Party大包', '1545730496991', null, '0');
INSERT INTO `roomtype` VALUES ('3', '至尊包厢', '1545730504991', null, '0');

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sign` varchar(50) DEFAULT NULL,
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of unit
-- ----------------------------
INSERT INTO `unit` VALUES ('1', '瓶', 'P', '1545710760720', null, '0');
INSERT INTO `unit` VALUES ('2', '份', 'F', '1545710777580', null, '0');
INSERT INTO `unit` VALUES ('3', '支', 'Z', '1545710784784', null, '0');
INSERT INTO `unit` VALUES ('4', '包', 'B', '1545710795928', null, '0');
INSERT INTO `unit` VALUES ('5', '个', 'G', '1545710803805', null, '0');
INSERT INTO `unit` VALUES ('6', '罐', 'GU', '1545710820680', null, '0');
INSERT INTO `unit` VALUES ('7', '壶', 'H', '1545710834061', null, '0');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `account` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '类型 0：收银；1：管理',
  `root` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '是否已登录（收银）',
  `createTime` bigint(20) NOT NULL,
  `off` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('3', '陈亮', '236338364', 'f889134a41063043803618b18908b6bd6d57b027', '1', '1', '0', '1546532515378', '0');
INSERT INTO `user` VALUES ('4', '收银员1', '111', '1c6637a8f2e1f75e06ff9984894d6bd16a3a36a9', '0', '0', '0', '1546532547214', '0');

-- ----------------------------
-- Table structure for vip
-- ----------------------------
DROP TABLE IF EXISTS `vip`;
CREATE TABLE `vip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `recentConsumeTime` bigint(20) DEFAULT NULL COMMENT '最近消费时间',
  `recentConsumeMoney` decimal(10,2) DEFAULT NULL COMMENT '最近消费金额',
  `totalTime` int(11) DEFAULT NULL COMMENT '累计消费次数',
  `totalMoney` decimal(10,2) DEFAULT NULL COMMENT '累计消费金额',
  `createTime` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '是否已登录，正在包间中',
  `record` int(11) NOT NULL DEFAULT '0' COMMENT '充值次数',
  `off` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of vip
-- ----------------------------
INSERT INTO `vip` VALUES ('1', '15920055057', '5257.00', null, null, null, null, '1546431572199', null, '14', '0');
INSERT INTO `vip` VALUES ('2', '13888888888', '150.00', null, null, null, null, '1546495981560', null, '1', '0');
