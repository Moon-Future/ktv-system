/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : ktv

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2019-01-16 01:17:30
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
  `qty` int(11) NOT NULL DEFAULT '0',
  `record` int(11) NOT NULL DEFAULT '0',
  `vipDiscount` int(11) NOT NULL DEFAULT '0' COMMENT '开启会员折扣',
  `discount` decimal(10,2) DEFAULT NULL COMMENT '会员折扣',
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1', '纯啤啤酒', null, '20.00', '1', '', '0', '0', '0', null, '1545710870689', '1546824044487', '1');
INSERT INTO `goods` VALUES ('2', '七堡1516啤酒', null, '10.00', '1', '畅饮', '0', '0', '0', null, '1545710972654', '1546824080031', '0');
INSERT INTO `goods` VALUES ('3', '雪花啤酒', null, '10.00', '1', '真的有雪花哦', '-12', '0', '0', null, '1545711013154', null, '0');
INSERT INTO `goods` VALUES ('4', '华夏干红', null, '118.00', '1', '', '0', '0', '0', null, '1545711043902', '1546824183625', '0');
INSERT INTO `goods` VALUES ('5', '雪碧', null, '6.00', '6', '透心凉', '0', '0', '0', null, '1545711071418', '1546824199463', '0');
INSERT INTO `goods` VALUES ('6', '冰红茶', null, '6.00', '1', '', '0', '0', '0', null, '1545711147913', '1546824219695', '0');
INSERT INTO `goods` VALUES ('7', '爆米花', null, '10.00', '4', '爆！爆！爆！', '-2', '0', '0', null, '1545711196951', null, '0');
INSERT INTO `goods` VALUES ('8', '小吃1份', null, '10.00', '2', '', '0', '0', '0', null, '1545711308809', '1546860479266', '1');
INSERT INTO `goods` VALUES ('9', '小吃2份', null, '10.00', '2', '', '0', '0', '0', null, '1545711339119', '1546860483789', '1');
INSERT INTO `goods` VALUES ('10', '小吃3份', null, '10.00', '2', '小吃', '0', '0', '0', null, '1545711366170', '1546860487317', '1');
INSERT INTO `goods` VALUES ('11', '小吃4份', null, '10.00', '2', '小吃', '0', '0', '0', null, '1545711380608', '1546860491998', '1');
INSERT INTO `goods` VALUES ('12', '小吃5份', null, '10.00', '2', '小吃', '0', '0', '0', null, '1545711409836', '1546860498579', '1');
INSERT INTO `goods` VALUES ('13', '小吃6份', null, '10.00', '2', '小吃', '0', '0', '0', null, '1545711427555', '1546860495524', '1');
INSERT INTO `goods` VALUES ('14', '什锦果盘小拼', null, '38.00', '2', '', '0', '0', '0', null, '1545711468435', '1546860574860', '0');
INSERT INTO `goods` VALUES ('15', '什锦果盘中拼', null, '50.00', '2', '', '0', '0', '0', null, '1545711489771', '1546860565082', '1');
INSERT INTO `goods` VALUES ('16', '什锦果盘大拼', null, '58.00', '2', '', '-4', '0', '0', null, '1545711509813', '1546860583315', '0');
INSERT INTO `goods` VALUES ('17', '红牛', null, '10.00', '1', '', '0', '0', '0', null, '1546824237361', null, '0');
INSERT INTO `goods` VALUES ('18', '加多宝', null, '10.00', '1', '', '0', '0', '0', null, '1546824270755', null, '0');
INSERT INTO `goods` VALUES ('19', '百事可乐', null, '6.00', '1', '', '0', '0', '0', null, '1546824295268', null, '0');
INSERT INTO `goods` VALUES ('20', '可口可乐', null, '6.00', '1', '', '0', '0', '0', null, '1546824313853', null, '0');
INSERT INTO `goods` VALUES ('21', '茗茶一壶', null, '38.00', '7', '', '0', '0', '0', null, '1546828193707', '1546828287041', '0');
INSERT INTO `goods` VALUES ('22', '小吃拼盘', null, '38.00', '2', '', '-2', '0', '0', null, '1546860553466', null, '0');
INSERT INTO `goods` VALUES ('23', '燕京啤酒', null, '10.00', '1', '', '-14', '0', '0', null, '1546860622231', null, '0');

-- ----------------------------
-- Table structure for goodsqty
-- ----------------------------
DROP TABLE IF EXISTS `goodsqty`;
CREATE TABLE `goodsqty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `user` varchar(50) NOT NULL,
  `time` bigint(20) NOT NULL,
  `createTime` bigint(20) NOT NULL,
  `off` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of goodsqty
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=482 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of package
-- ----------------------------
INSERT INTO `package` VALUES ('275', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '标准包黄金档啤酒套餐', '22', '1', '23,2,3', '0', '0.00', '1', '198.00', '1、七堡1516啤酒8瓶或燕京啤酒8瓶或雪花啤酒6瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘小拼1份', '1546624646261', '1546861465321', '0');
INSERT INTO `package` VALUES ('276', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '标准包黄金档啤酒套餐', '2', '8', '23,2,3', '0', '0.00', '1', '198.00', '1、七堡1516啤酒8瓶或燕京啤酒8瓶或雪花啤酒6瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘小拼1份', '1546624646261', '1546861465321', '0');
INSERT INTO `package` VALUES ('277', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '标准包黄金档啤酒套餐', '23', '8', '23,2,3', '0', '0.00', '1', '198.00', '1、七堡1516啤酒8瓶或燕京啤酒8瓶或雪花啤酒6瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘小拼1份', '1546624646261', '1546861465321', '0');
INSERT INTO `package` VALUES ('278', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '标准包黄金档啤酒套餐', '3', '6', '23,2,3', '0', '0.00', '1', '198.00', '1、七堡1516啤酒8瓶或燕京啤酒8瓶或雪花啤酒6瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘小拼1份', '1546624646261', '1546861465321', '0');
INSERT INTO `package` VALUES ('279', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '标准包黄金档啤酒套餐', '7', '1', '23,2,3', '0', '0.00', '1', '198.00', '1、七堡1516啤酒8瓶或燕京啤酒8瓶或雪花啤酒6瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘小拼1份', '1546624646261', '1546861465321', '0');
INSERT INTO `package` VALUES ('280', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '标准包黄金档啤酒套餐', '14', '1', '23,2,3', '0', '0.00', '1', '198.00', '1、七堡1516啤酒8瓶或燕京啤酒8瓶或雪花啤酒6瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘小拼1份', '1546624646261', '1546861465321', '0');
INSERT INTO `package` VALUES ('344', '4b53d400-121c-11e9-9989-d75a6f62cec3', '大包黄金档啤酒套餐', '22', '1', '3,23,2', '0', '0.00', '1', '298.00', '1、七堡啤酒12瓶或燕京啤酒12瓶或雪花啤酒10瓶\n2、小吃拼盘1份\n3、爆米花1份\n4、什锦果盘大拼1份', '1546824834368', '1546861746389', '0');
INSERT INTO `package` VALUES ('345', '4b53d400-121c-11e9-9989-d75a6f62cec3', '大包黄金档啤酒套餐', '2', '12', '3,23,2', '0', '0.00', '1', '298.00', '1、七堡啤酒12瓶或燕京啤酒12瓶或雪花啤酒10瓶\n2、小吃拼盘1份\n3、爆米花1份\n4、什锦果盘大拼1份', '1546824834368', '1546861746389', '0');
INSERT INTO `package` VALUES ('346', '4b53d400-121c-11e9-9989-d75a6f62cec3', '大包黄金档啤酒套餐', '3', '10', '3,23,2', '0', '0.00', '1', '298.00', '1、七堡啤酒12瓶或燕京啤酒12瓶或雪花啤酒10瓶\n2、小吃拼盘1份\n3、爆米花1份\n4、什锦果盘大拼1份', '1546824834368', '1546861746389', '0');
INSERT INTO `package` VALUES ('347', '4b53d400-121c-11e9-9989-d75a6f62cec3', '大包黄金档啤酒套餐', '23', '12', '3,23,2', '0', '0.00', '1', '298.00', '1、七堡啤酒12瓶或燕京啤酒12瓶或雪花啤酒10瓶\n2、小吃拼盘1份\n3、爆米花1份\n4、什锦果盘大拼1份', '1546824834368', '1546861746389', '0');
INSERT INTO `package` VALUES ('349', '4b53d400-121c-11e9-9989-d75a6f62cec3', '大包黄金档啤酒套餐', '7', '1', '3,23,2', '0', '0.00', '1', '298.00', '1、七堡啤酒12瓶或燕京啤酒12瓶或雪花啤酒10瓶\n2、小吃拼盘1份\n3、爆米花1份\n4、什锦果盘大拼1份', '1546824834368', '1546861746389', '0');
INSERT INTO `package` VALUES ('383', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '标准包阳光档啤酒套餐', '7', '1', '23,2,3', '1', '98.00', '0', '0.00', '1、七堡1516啤酒6瓶或燕京啤酒6瓶或雪花啤酒5瓶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', '1546828087219', '1546861905664', '0');
INSERT INTO `package` VALUES ('384', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '标准包阳光档啤酒套餐', '14', '1', '23,2,3', '1', '98.00', '0', '0.00', '1、七堡1516啤酒6瓶或燕京啤酒6瓶或雪花啤酒5瓶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', '1546828087219', '1546861905664', '0');
INSERT INTO `package` VALUES ('385', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '标准包阳光档啤酒套餐', '2', '6', '23,2,3', '1', '98.00', '0', '0.00', '1、七堡1516啤酒6瓶或燕京啤酒6瓶或雪花啤酒5瓶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', '1546828087219', '1546861905664', '0');
INSERT INTO `package` VALUES ('386', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '标准包阳光档啤酒套餐', '3', '5', '23,2,3', '1', '98.00', '0', '0.00', '1、七堡1516啤酒6瓶或燕京啤酒6瓶或雪花啤酒5瓶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', '1546828087219', '1546861905664', '0');
INSERT INTO `package` VALUES ('388', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '标准包阳光档啤酒套餐', '23', '6', '23,2,3', '1', '98.00', '0', '0.00', '1、七堡1516啤酒6瓶或燕京啤酒6瓶或雪花啤酒5瓶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', '1546828087219', '1546861905664', '0');
INSERT INTO `package` VALUES ('389', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '标准包阳光档啤酒套餐', '22', '1', '23,2,3', '1', '98.00', '0', '0.00', '1、七堡1516啤酒6瓶或燕京啤酒6瓶或雪花啤酒5瓶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', '1546828087219', '1546861905664', '0');
INSERT INTO `package` VALUES ('442', '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '豪包阳光档啤酒套餐', '23', '14', '23,2,3', '1', '298.00', '0', '0.00', '1、七堡1516啤酒14瓶或燕京啤酒14瓶或雪花啤酒12瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘大拼1份', '1546828624618', '1546862107184', '0');
INSERT INTO `package` VALUES ('443', '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '豪包阳光档啤酒套餐', '16', '2', '23,2,3', '1', '298.00', '0', '0.00', '1、七堡1516啤酒14瓶或燕京啤酒14瓶或雪花啤酒12瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘大拼1份', '1546828624618', '1546862107184', '0');
INSERT INTO `package` VALUES ('444', '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '豪包阳光档啤酒套餐', '22', '1', '23,2,3', '1', '298.00', '0', '0.00', '1、七堡1516啤酒14瓶或燕京啤酒14瓶或雪花啤酒12瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘大拼1份', '1546828624618', '1546862107184', '0');
INSERT INTO `package` VALUES ('445', '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '豪包阳光档啤酒套餐', '2', '14', '23,2,3', '1', '298.00', '0', '0.00', '1、七堡1516啤酒14瓶或燕京啤酒14瓶或雪花啤酒12瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘大拼1份', '1546828624618', '1546862107184', '0');
INSERT INTO `package` VALUES ('446', '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '豪包阳光档啤酒套餐', '3', '12', '23,2,3', '1', '298.00', '0', '0.00', '1、七堡1516啤酒14瓶或燕京啤酒14瓶或雪花啤酒12瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘大拼1份', '1546828624618', '1546862107184', '0');
INSERT INTO `package` VALUES ('447', '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '豪包阳光档啤酒套餐', '7', '1', '23,2,3', '1', '298.00', '0', '0.00', '1、七堡1516啤酒14瓶或燕京啤酒14瓶或雪花啤酒12瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘大拼1份', '1546828624618', '1546862107184', '0');
INSERT INTO `package` VALUES ('448', '7985adb0-1223-11e9-9989-d75a6f62cec3', '豪包黄金档啤酒套餐', '23', '14', '23,2,3', '0', '0.00', '1', '598.00', '1、七堡啤酒14瓶或燕京啤酒14瓶或雪花啤酒12瓶\n2、小吃拼盘1份\n3、爆米花1份\n4、什锦果盘大拼2份', '1546827918347', '1546862200555', '0');
INSERT INTO `package` VALUES ('449', '7985adb0-1223-11e9-9989-d75a6f62cec3', '豪包黄金档啤酒套餐', '22', '1', '23,2,3', '0', '0.00', '1', '598.00', '1、七堡啤酒14瓶或燕京啤酒14瓶或雪花啤酒12瓶\n2、小吃拼盘1份\n3、爆米花1份\n4、什锦果盘大拼2份', '1546827918347', '1546862200555', '0');
INSERT INTO `package` VALUES ('451', '7985adb0-1223-11e9-9989-d75a6f62cec3', '豪包黄金档啤酒套餐', '7', '1', '23,2,3', '0', '0.00', '1', '598.00', '1、七堡啤酒14瓶或燕京啤酒14瓶或雪花啤酒12瓶\n2、小吃拼盘1份\n3、爆米花1份\n4、什锦果盘大拼2份', '1546827918347', '1546862200555', '0');
INSERT INTO `package` VALUES ('452', '7985adb0-1223-11e9-9989-d75a6f62cec3', '豪包黄金档啤酒套餐', '3', '12', '23,2,3', '0', '0.00', '1', '598.00', '1、七堡啤酒14瓶或燕京啤酒14瓶或雪花啤酒12瓶\n2、小吃拼盘1份\n3、爆米花1份\n4、什锦果盘大拼2份', '1546827918347', '1546862200555', '0');
INSERT INTO `package` VALUES ('453', '7985adb0-1223-11e9-9989-d75a6f62cec3', '豪包黄金档啤酒套餐', '16', '2', '23,2,3', '0', '0.00', '1', '598.00', '1、七堡啤酒14瓶或燕京啤酒14瓶或雪花啤酒12瓶\n2、小吃拼盘1份\n3、爆米花1份\n4、什锦果盘大拼2份', '1546827918347', '1546862200555', '0');
INSERT INTO `package` VALUES ('454', '7985adb0-1223-11e9-9989-d75a6f62cec3', '豪包黄金档啤酒套餐', '2', '14', '23,2,3', '0', '0.00', '1', '598.00', '1、七堡啤酒14瓶或燕京啤酒14瓶或雪花啤酒12瓶\n2、小吃拼盘1份\n3、爆米花1份\n4、什锦果盘大拼2份', '1546827918347', '1546862200555', '0');
INSERT INTO `package` VALUES ('463', '94902cb0-1224-11e9-9989-d75a6f62cec3', '大包阳光档啤酒套餐', '2', '10', '23,2,3', '1', '168.00', '0', '0.00', '1、七堡1516啤酒10瓶或燕京啤酒10瓶或雪花啤酒8瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘大拼1份', '1546828393211', '1546862256383', '0');
INSERT INTO `package` VALUES ('464', '94902cb0-1224-11e9-9989-d75a6f62cec3', '大包阳光档啤酒套餐', '3', '8', '23,2,3', '1', '168.00', '0', '0.00', '1、七堡1516啤酒10瓶或燕京啤酒10瓶或雪花啤酒8瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘大拼1份', '1546828393211', '1546862256383', '0');
INSERT INTO `package` VALUES ('465', '94902cb0-1224-11e9-9989-d75a6f62cec3', '大包阳光档啤酒套餐', '7', '1', '23,2,3', '1', '168.00', '0', '0.00', '1、七堡1516啤酒10瓶或燕京啤酒10瓶或雪花啤酒8瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘大拼1份', '1546828393211', '1546862256383', '0');
INSERT INTO `package` VALUES ('466', '94902cb0-1224-11e9-9989-d75a6f62cec3', '大包阳光档啤酒套餐', '22', '1', '23,2,3', '1', '168.00', '0', '0.00', '1、七堡1516啤酒10瓶或燕京啤酒10瓶或雪花啤酒8瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘大拼1份', '1546828393211', '1546862256383', '0');
INSERT INTO `package` VALUES ('469', '94902cb0-1224-11e9-9989-d75a6f62cec3', '大包阳光档啤酒套餐', '23', '10', '23,2,3', '1', '168.00', '0', '0.00', '1、七堡1516啤酒10瓶或燕京啤酒10瓶或雪花啤酒8瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘大拼1份', '1546828393211', '1546862256383', '0');
INSERT INTO `package` VALUES ('470', '94902cb0-1224-11e9-9989-d75a6f62cec3', '大包阳光档啤酒套餐', '16', '1', '23,2,3', '1', '168.00', '0', '0.00', '1、七堡1516啤酒10瓶或燕京啤酒10瓶或雪花啤酒8瓶\n2、小吃拼盘1份\n3、爆米花1包\n4、什锦果盘大拼1份', '1546828393211', '1546862256383', '0');
INSERT INTO `package` VALUES ('476', '9d1432e0-13f6-11e9-86ad-915cb8e24559', '豪包阳光档干唱套餐', null, null, null, '1', '100.00', '0', '0.00', '不要酒水、小吃套餐', '1547028552974', '1547376365985', '0');
INSERT INTO `package` VALUES ('477', 'b67f0200-1720-11e9-b5e7-cd0a8c11a7bb', '豪包黄金档干唱套餐', null, null, null, '0', '0.00', '1', '150.00', '不要酒水、小吃套餐', '1547376487968', null, '0');
INSERT INTO `package` VALUES ('478', 'dae7fde0-1720-11e9-b5e7-cd0a8c11a7bb', '大包阳光档干唱套餐', null, null, null, '1', '50.00', '0', '0.00', '不要酒水、小吃套餐', '1547376549054', null, '0');
INSERT INTO `package` VALUES ('479', 'f0664fa0-1720-11e9-b5e7-cd0a8c11a7bb', '大包黄金档干唱套餐', null, null, null, '0', '0.00', '1', '80.00', '不要酒水、小吃套餐', '1547376585114', null, '0');
INSERT INTO `package` VALUES ('480', '0503b740-1721-11e9-b5e7-cd0a8c11a7bb', '标准包阳光档干唱套餐', null, null, null, '1', '40.00', '0', '0.00', '不要酒水、小吃套餐', '1547376619700', null, '0');
INSERT INTO `package` VALUES ('481', '15e48c10-1721-11e9-b5e7-cd0a8c11a7bb', '标准包黄金档干唱套餐', null, null, null, '0', '0.00', '1', '60.00', '不要酒水、小吃套餐', '1547376648017', null, '0');

-- ----------------------------
-- Table structure for rechargerecord
-- ----------------------------
DROP TABLE IF EXISTS `rechargerecord`;
CREATE TABLE `rechargerecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `money` decimal(10,2) NOT NULL,
  `recharge` decimal(10,2) NOT NULL,
  `give` decimal(10,2) NOT NULL DEFAULT '0.00',
  `user` varchar(50) NOT NULL,
  `time` bigint(20) NOT NULL,
  `off` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of rechargerecord
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES ('171', '901039f0-084c-11e9-a567-470a0f92e677', '3', '南天门', '6666', '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_1', '1545730760693', '1547376717358', '0', '0');
INSERT INTO `room` VALUES ('172', '901039f0-084c-11e9-a567-470a0f92e677', '3', '南天门', '6666', '7985adb0-1223-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_1', '1545730760693', '1547376717358', '0', '0');
INSERT INTO `room` VALUES ('173', '901039f0-084c-11e9-a567-470a0f92e677', '3', '南天门', '6666', '9d1432e0-13f6-11e9-86ad-915cb8e24559', '欢乐唱响', '1_1', '1545730760693', '1547376717358', '0', '0');
INSERT INTO `room` VALUES ('174', '901039f0-084c-11e9-a567-470a0f92e677', '3', '南天门', '6666', 'b67f0200-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '1_1', '1545730760693', '1547376717358', '0', '0');
INSERT INTO `room` VALUES ('175', 'f4999250-0828-11e9-8b7c-f90e6ffd643f', '2', '慈宁宫', '8011', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_2', '1545746053903', '1547376744683', '0', '0');
INSERT INTO `room` VALUES ('176', 'f4999250-0828-11e9-8b7c-f90e6ffd643f', '2', '慈宁宫', '8011', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_2', '1545746053903', '1547376744683', '0', '0');
INSERT INTO `room` VALUES ('177', 'f4999250-0828-11e9-8b7c-f90e6ffd643f', '2', '慈宁宫', '8011', 'f0664fa0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '1_2', '1545746053903', '1547376744683', '0', '0');
INSERT INTO `room` VALUES ('178', 'f4999250-0828-11e9-8b7c-f90e6ffd643f', '2', '慈宁宫', '8011', 'dae7fde0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '1_2', '1545746053903', '1547376744683', '0', '0');
INSERT INTO `room` VALUES ('179', '074c3690-084d-11e9-a567-470a0f92e677', '2', '月仙殿', '8012', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_3', '1545746253945', '1547376757992', '0', '0');
INSERT INTO `room` VALUES ('180', '074c3690-084d-11e9-a567-470a0f92e677', '2', '月仙殿', '8012', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_3', '1545746253945', '1547376757992', '0', '0');
INSERT INTO `room` VALUES ('181', '074c3690-084d-11e9-a567-470a0f92e677', '2', '月仙殿', '8012', 'dae7fde0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '1_3', '1545746253945', '1547376757992', '0', '0');
INSERT INTO `room` VALUES ('182', '074c3690-084d-11e9-a567-470a0f92e677', '2', '月仙殿', '8012', 'f0664fa0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '1_3', '1545746253945', '1547376757992', '0', '0');
INSERT INTO `room` VALUES ('183', '11803670-084d-11e9-a567-470a0f92e677', '2', '景阳宫', '8013', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_4', '1545746271063', '1547376767856', '0', '0');
INSERT INTO `room` VALUES ('184', '11803670-084d-11e9-a567-470a0f92e677', '2', '景阳宫', '8013', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_4', '1545746271063', '1547376767856', '0', '0');
INSERT INTO `room` VALUES ('185', '11803670-084d-11e9-a567-470a0f92e677', '2', '景阳宫', '8013', 'dae7fde0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '1_4', '1545746271063', '1547376767856', '0', '0');
INSERT INTO `room` VALUES ('186', '11803670-084d-11e9-a567-470a0f92e677', '2', '景阳宫', '8013', 'f0664fa0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '1_4', '1545746271063', '1547376767856', '0', '0');
INSERT INTO `room` VALUES ('187', '1f69c440-084d-11e9-a567-470a0f92e677', '2', '景殿宫', '8015', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_5', '1545746294404', '1547376780724', '0', '0');
INSERT INTO `room` VALUES ('188', '1f69c440-084d-11e9-a567-470a0f92e677', '2', '景殿宫', '8015', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_5', '1545746294404', '1547376780724', '0', '0');
INSERT INTO `room` VALUES ('189', '1f69c440-084d-11e9-a567-470a0f92e677', '2', '景殿宫', '8015', 'dae7fde0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '1_5', '1545746294404', '1547376780724', '0', '0');
INSERT INTO `room` VALUES ('190', '1f69c440-084d-11e9-a567-470a0f92e677', '2', '景殿宫', '8015', 'f0664fa0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '1_5', '1545746294404', '1547376780724', '0', '0');
INSERT INTO `room` VALUES ('191', '3575d710-084d-11e9-a567-470a0f92e677', '1', '雪舞宫', '8016', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '', '1_6', '1545746331393', '1547376799298', '0', '0');
INSERT INTO `room` VALUES ('192', '3575d710-084d-11e9-a567-470a0f92e677', '1', '雪舞宫', '8016', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '', '1_6', '1545746331393', '1547376799298', '0', '0');
INSERT INTO `room` VALUES ('193', '3575d710-084d-11e9-a567-470a0f92e677', '1', '雪舞宫', '8016', '0503b740-1721-11e9-b5e7-cd0a8c11a7bb', '', '1_6', '1545746331393', '1547376799298', '0', '0');
INSERT INTO `room` VALUES ('194', '3575d710-084d-11e9-a567-470a0f92e677', '1', '雪舞宫', '8016', '15e48c10-1721-11e9-b5e7-cd0a8c11a7bb', '', '1_6', '1545746331393', '1547376799298', '0', '0');
INSERT INTO `room` VALUES ('195', 'bc31d570-084c-11e9-a567-470a0f92e677', '3', '金箍棒', '9999', '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_1', '1545746480000', '1547376815050', '0', '0');
INSERT INTO `room` VALUES ('196', 'bc31d570-084c-11e9-a567-470a0f92e677', '3', '金箍棒', '9999', '7985adb0-1223-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_1', '1545746480000', '1547376815050', '0', '0');
INSERT INTO `room` VALUES ('197', 'bc31d570-084c-11e9-a567-470a0f92e677', '3', '金箍棒', '9999', '9d1432e0-13f6-11e9-86ad-915cb8e24559', '欢乐唱响', '2_1', '1545746480000', '1547376815050', '0', '0');
INSERT INTO `room` VALUES ('198', 'bc31d570-084c-11e9-a567-470a0f92e677', '3', '金箍棒', '9999', 'b67f0200-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_1', '1545746480000', '1547376815050', '0', '0');
INSERT INTO `room` VALUES ('199', '927b2a00-084d-11e9-a567-470a0f92e677', '2', '天赐宫', '8017', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_2', '1545746487456', '1547376824390', '0', '0');
INSERT INTO `room` VALUES ('200', '927b2a00-084d-11e9-a567-470a0f92e677', '2', '天赐宫', '8017', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_2', '1545746487456', '1547376824390', '0', '0');
INSERT INTO `room` VALUES ('201', '927b2a00-084d-11e9-a567-470a0f92e677', '2', '天赐宫', '8017', 'dae7fde0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_2', '1545746487456', '1547376824390', '0', '0');
INSERT INTO `room` VALUES ('202', '927b2a00-084d-11e9-a567-470a0f92e677', '2', '天赐宫', '8017', 'f0664fa0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_2', '1545746487456', '1547376824390', '0', '0');
INSERT INTO `room` VALUES ('203', 'a280ba00-084d-11e9-a567-470a0f92e677', '2', '玉华宫', '8019', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_3', '1545746514336', '1547376833578', '0', '0');
INSERT INTO `room` VALUES ('204', 'a280ba00-084d-11e9-a567-470a0f92e677', '2', '玉华宫', '8019', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_3', '1545746514336', '1547376833578', '0', '0');
INSERT INTO `room` VALUES ('205', 'a280ba00-084d-11e9-a567-470a0f92e677', '2', '玉华宫', '8019', 'dae7fde0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_3', '1545746514336', '1547376833578', '0', '0');
INSERT INTO `room` VALUES ('206', 'a280ba00-084d-11e9-a567-470a0f92e677', '2', '玉华宫', '8019', 'f0664fa0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_3', '1545746514336', '1547376833578', '0', '0');
INSERT INTO `room` VALUES ('207', 'b1c962a0-084d-11e9-a567-470a0f92e677', '2', '善岚宫', '8020', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_4', '1545746539978', '1547376842326', '0', '0');
INSERT INTO `room` VALUES ('208', 'b1c962a0-084d-11e9-a567-470a0f92e677', '2', '善岚宫', '8020', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_4', '1545746539978', '1547376842326', '0', '0');
INSERT INTO `room` VALUES ('209', 'b1c962a0-084d-11e9-a567-470a0f92e677', '2', '善岚宫', '8020', 'f0664fa0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_4', '1545746539978', '1547376842326', '0', '0');
INSERT INTO `room` VALUES ('210', 'b1c962a0-084d-11e9-a567-470a0f92e677', '2', '善岚宫', '8020', 'dae7fde0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_4', '1545746539978', '1547376842326', '0', '0');
INSERT INTO `room` VALUES ('215', 'cc421e60-084d-11e9-a567-470a0f92e677', '2', '昭阳宫', '8022', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_6', '1545746584390', '1547376898941', '0', '0');
INSERT INTO `room` VALUES ('216', 'cc421e60-084d-11e9-a567-470a0f92e677', '2', '昭阳宫', '8022', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_6', '1545746584390', '1547376898941', '0', '0');
INSERT INTO `room` VALUES ('217', 'cc421e60-084d-11e9-a567-470a0f92e677', '2', '昭阳宫', '8022', 'f0664fa0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_6', '1545746584390', '1547376898941', '0', '0');
INSERT INTO `room` VALUES ('218', 'cc421e60-084d-11e9-a567-470a0f92e677', '2', '昭阳宫', '8022', 'dae7fde0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_6', '1545746584390', '1547376898941', '0', '0');
INSERT INTO `room` VALUES ('219', 'fb867db0-084d-11e9-a567-470a0f92e677', '2', '薰梦宫', '8023', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_7', '1545746663691', '1547376908307', '0', '0');
INSERT INTO `room` VALUES ('220', 'fb867db0-084d-11e9-a567-470a0f92e677', '2', '薰梦宫', '8023', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_7', '1545746663691', '1547376908307', '0', '0');
INSERT INTO `room` VALUES ('221', 'fb867db0-084d-11e9-a567-470a0f92e677', '2', '薰梦宫', '8023', 'dae7fde0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_7', '1545746663691', '1547376908307', '0', '0');
INSERT INTO `room` VALUES ('222', 'fb867db0-084d-11e9-a567-470a0f92e677', '2', '薰梦宫', '8023', 'f0664fa0-1720-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_7', '1545746663691', '1547376908307', '0', '0');
INSERT INTO `room` VALUES ('231', 'c063c9e0-084d-11e9-a567-470a0f92e677', '1', '凌妍阁', '8021', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_5', '1545746564478', '1547377158376', '0', '0');
INSERT INTO `room` VALUES ('232', 'c063c9e0-084d-11e9-a567-470a0f92e677', '1', '凌妍阁', '8021', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '欢乐唱响', '2_5', '1545746564478', '1547377158376', '0', '0');
INSERT INTO `room` VALUES ('233', 'c063c9e0-084d-11e9-a567-470a0f92e677', '1', '凌妍阁', '8021', '0503b740-1721-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_5', '1545746564478', '1547377158376', '0', '0');
INSERT INTO `room` VALUES ('234', 'c063c9e0-084d-11e9-a567-470a0f92e677', '1', '凌妍阁', '8021', '15e48c10-1721-11e9-b5e7-cd0a8c11a7bb', '欢乐唱响', '2_5', '1545746564478', '1547377158376', '0', '0');

-- ----------------------------
-- Table structure for roomorder
-- ----------------------------
DROP TABLE IF EXISTS `roomorder`;
CREATE TABLE `roomorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nun` varchar(50) DEFAULT NULL,
  `room` varchar(50) NOT NULL,
  `close` int(11) NOT NULL DEFAULT '0' COMMENT '0：使用中，1：关闭',
  `package` varchar(50) DEFAULT NULL,
  `packageType` int(11) DEFAULT NULL,
  `grpSelected` varchar(50) DEFAULT NULL,
  `goods` varchar(255) DEFAULT NULL,
  `qty` varchar(255) DEFAULT NULL,
  `stockGoods` varchar(255) DEFAULT NULL COMMENT '使用寄存中的商品',
  `stockQty` varchar(255) DEFAULT NULL,
  `depositGoods` varchar(255) DEFAULT NULL COMMENT '寄存商品',
  `depositQty` varchar(255) DEFAULT NULL,
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
INSERT INTO `roomtype` VALUES ('2', '大  包', '1545730496991', '1546823066933', '0');
INSERT INTO `roomtype` VALUES ('3', '豪华包', '1545730504991', '1546823079692', '0');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of vip
-- ----------------------------

-- ----------------------------
-- Table structure for vipstock
-- ----------------------------
DROP TABLE IF EXISTS `vipstock`;
CREATE TABLE `vipstock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nun` varchar(50) NOT NULL COMMENT '订单编码',
  `vip` varchar(50) NOT NULL,
  `goods` varchar(50) NOT NULL,
  `qty` varchar(50) NOT NULL,
  `off` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of vipstock
-- ----------------------------
