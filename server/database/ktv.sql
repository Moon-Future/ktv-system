/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost:3306
 Source Schema         : ktv

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 25/12/2018 17:57:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `price` decimal(10, 2) NOT NULL,
  `unit` int(11) NOT NULL,
  `descr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `vipDiscount` int(11) NOT NULL DEFAULT 0 COMMENT '开启会员折扣',
  `discount` decimal(10, 2) DEFAULT NULL COMMENT '会员折扣',
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '纯啤啤酒', NULL, 20.00, 1, '', 0, NULL, 1545710870689, NULL, 0);
INSERT INTO `goods` VALUES (2, '冰纯啤酒', NULL, 30.00, 1, '冰火两重天！', 0, NULL, 1545710972654, NULL, 0);
INSERT INTO `goods` VALUES (3, '雪花啤酒', NULL, 10.00, 1, '真的有雪花哦', 0, NULL, 1545711013154, NULL, 0);
INSERT INTO `goods` VALUES (4, '华夏干红', NULL, 88.00, 1, '', 0, NULL, 1545711043902, NULL, 0);
INSERT INTO `goods` VALUES (5, '雪碧', NULL, 5.00, 6, '透心凉', 0, NULL, 1545711071418, NULL, 0);
INSERT INTO `goods` VALUES (6, '茶', NULL, 15.00, 7, '', 0, NULL, 1545711147913, NULL, 0);
INSERT INTO `goods` VALUES (7, '爆米花', NULL, 10.00, 4, '爆！爆！爆！', 0, NULL, 1545711196951, NULL, 0);
INSERT INTO `goods` VALUES (8, '蚕豆', NULL, 10.00, 2, '', 0, NULL, 1545711308809, NULL, 0);
INSERT INTO `goods` VALUES (9, '瓜子', NULL, 10.00, 2, '', 0, NULL, 1545711339119, NULL, 0);
INSERT INTO `goods` VALUES (10, '锅巴', NULL, 10.00, 2, '小吃', 0, NULL, 1545711366170, NULL, 0);
INSERT INTO `goods` VALUES (11, '花生', NULL, 10.00, 2, '小吃', 0, NULL, 1545711380608, NULL, 0);
INSERT INTO `goods` VALUES (12, '开心果', NULL, 10.00, 2, '小吃', 0, NULL, 1545711409836, NULL, 0);
INSERT INTO `goods` VALUES (13, '杏仁', NULL, 10.00, 2, '小吃', 0, NULL, 1545711427555, NULL, 0);
INSERT INTO `goods` VALUES (14, '什锦果盘小拼', NULL, 20.00, 2, '', 0, NULL, 1545711468435, NULL, 0);
INSERT INTO `goods` VALUES (15, '什锦果盘中拼', NULL, 50.00, 2, '', 0, NULL, 1545711489771, NULL, 0);
INSERT INTO `goods` VALUES (16, '什锦果盘大拼', NULL, 80.00, 2, '', 0, NULL, 1545711509813, NULL, 0);

-- ----------------------------
-- Table structure for package
-- ----------------------------
DROP TABLE IF EXISTS `package`;
CREATE TABLE `package`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int(11) DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `goods` int(11) DEFAULT NULL COMMENT '商品，多个',
  `qty` int(11) DEFAULT NULL,
  `room` int(11) NOT NULL DEFAULT 0 COMMENT '是否含包间',
  `roomType` int(11) DEFAULT NULL,
  `price` decimal(10, 2) NOT NULL,
  `descr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of package
-- ----------------------------
INSERT INTO `package` VALUES (1, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', 1, '啤酒套餐', 1, 12, 1, 1, 198.00, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (2, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', 1, '啤酒套餐', 2, 10, 1, 1, 198.00, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (3, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', 1, '啤酒套餐', 3, 8, 1, 1, 198.00, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (4, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', 1, '啤酒套餐', 8, 1, 1, 1, 198.00, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (5, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', 1, '啤酒套餐', 9, 1, 1, 1, 198.00, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (6, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', 1, '啤酒套餐', 7, 1, 1, 1, 198.00, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (7, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', 1, '啤酒套餐', 14, 1, 1, 1, 198.00, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `roomType` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `package` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `descr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (2, 'f4999250-0828-11e9-8b7c-f90e6ffd643f', 1, '慈宁宫', '8888', 66.00, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '来了，老弟', 1545730760693, 1545731371582, 0);

-- ----------------------------
-- Table structure for roomtype
-- ----------------------------
DROP TABLE IF EXISTS `roomtype`;
CREATE TABLE `roomtype`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomtype
-- ----------------------------
INSERT INTO `roomtype` VALUES (1, '标准包', 1545730484185, NULL, 0);
INSERT INTO `roomtype` VALUES (2, 'Party大包', 1545730496991, NULL, 0);
INSERT INTO `roomtype` VALUES (3, '至尊包厢', 1545730504991, NULL, 0);

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sign` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of unit
-- ----------------------------
INSERT INTO `unit` VALUES (1, '瓶', 'P', 1545710760720, NULL, 0);
INSERT INTO `unit` VALUES (2, '份', 'F', 1545710777580, NULL, 0);
INSERT INTO `unit` VALUES (3, '支', 'Z', 1545710784784, NULL, 0);
INSERT INTO `unit` VALUES (4, '包', 'B', 1545710795928, NULL, 0);
INSERT INTO `unit` VALUES (5, '个', 'G', 1545710803805, NULL, 0);
INSERT INTO `unit` VALUES (6, '罐', 'GU', 1545710820680, NULL, 0);
INSERT INTO `unit` VALUES (7, '壶', 'H', 1545710834061, NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
