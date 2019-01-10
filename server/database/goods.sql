/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : ktv

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2019-01-11 00:41:23
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
INSERT INTO `goods` VALUES ('2', '七堡1516啤酒', null, '10.00', '1', '畅饮', '130', '1', '0', null, '1545710972654', '1546824080031', '0');
INSERT INTO `goods` VALUES ('3', '雪花啤酒', null, '10.00', '1', '真的有雪花哦', '70', '1', '0', null, '1545711013154', null, '0');
INSERT INTO `goods` VALUES ('4', '华夏干红', null, '118.00', '1', '', '30', '1', '0', null, '1545711043902', '1546824183625', '0');
INSERT INTO `goods` VALUES ('5', '雪碧', null, '6.00', '6', '透心凉', '0', '0', '0', null, '1545711071418', '1546824199463', '0');
INSERT INTO `goods` VALUES ('6', '冰红茶', null, '6.00', '1', '', '0', '0', '0', null, '1545711147913', '1546824219695', '0');
INSERT INTO `goods` VALUES ('7', '爆米花', null, '10.00', '4', '爆！爆！爆！', '0', '0', '0', null, '1545711196951', null, '0');
INSERT INTO `goods` VALUES ('8', '小吃1份', null, '10.00', '2', '', '0', '0', '0', null, '1545711308809', '1546860479266', '1');
INSERT INTO `goods` VALUES ('9', '小吃2份', null, '10.00', '2', '', '0', '0', '0', null, '1545711339119', '1546860483789', '1');
INSERT INTO `goods` VALUES ('10', '小吃3份', null, '10.00', '2', '小吃', '0', '0', '0', null, '1545711366170', '1546860487317', '1');
INSERT INTO `goods` VALUES ('11', '小吃4份', null, '10.00', '2', '小吃', '0', '0', '0', null, '1545711380608', '1546860491998', '1');
INSERT INTO `goods` VALUES ('12', '小吃5份', null, '10.00', '2', '小吃', '0', '0', '0', null, '1545711409836', '1546860498579', '1');
INSERT INTO `goods` VALUES ('13', '小吃6份', null, '10.00', '2', '小吃', '0', '0', '0', null, '1545711427555', '1546860495524', '1');
INSERT INTO `goods` VALUES ('14', '什锦果盘小拼', null, '38.00', '2', '', '0', '0', '0', null, '1545711468435', '1546860574860', '0');
INSERT INTO `goods` VALUES ('15', '什锦果盘中拼', null, '50.00', '2', '', '0', '0', '0', null, '1545711489771', '1546860565082', '1');
INSERT INTO `goods` VALUES ('16', '什锦果盘大拼', null, '58.00', '2', '', '0', '0', '0', null, '1545711509813', '1546860583315', '0');
INSERT INTO `goods` VALUES ('17', '红牛', null, '10.00', '1', '', '0', '0', '0', null, '1546824237361', null, '0');
INSERT INTO `goods` VALUES ('18', '加多宝', null, '10.00', '1', '', '0', '0', '0', null, '1546824270755', null, '0');
INSERT INTO `goods` VALUES ('19', '百事可乐', null, '6.00', '1', '', '0', '0', '0', null, '1546824295268', null, '0');
INSERT INTO `goods` VALUES ('20', '可口可乐', null, '6.00', '1', '', '0', '0', '0', null, '1546824313853', null, '0');
INSERT INTO `goods` VALUES ('21', '茗茶一壶', null, '38.00', '7', '', '0', '0', '0', null, '1546828193707', '1546828287041', '0');
INSERT INTO `goods` VALUES ('22', '小吃拼盘', null, '38.00', '2', '', '0', '0', '0', null, '1546860553466', null, '0');
INSERT INTO `goods` VALUES ('23', '燕京啤酒', null, '10.00', '1', '', '0', '0', '0', null, '1546860622231', null, '0');
