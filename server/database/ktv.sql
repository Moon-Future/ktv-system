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

 Date: 22/12/2018 17:50:16
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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '雪花啤酒', NULL, 10.00, 6, '', 0, NULL, 1545357074894, 1545357113111, 0);
INSERT INTO `goods` VALUES (2, '花生', NULL, 10.00, 3, '', 0, NULL, 1545357087188, NULL, 0);
INSERT INTO `goods` VALUES (3, '小蜜蜂', NULL, 888.00, 5, '', 0, NULL, 1545357130892, NULL, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 134 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of package
-- ----------------------------
INSERT INTO `package` VALUES (117, 'f97fed40-04f5-11e9-bed3-f33b5b7838f0', 2, '红酒套餐', 2, 30, 1, 3, 588.00, '至尊包厢，豪华套餐', 1545379011091, NULL, 0);
INSERT INTO `package` VALUES (118, 'f97fed40-04f5-11e9-bed3-f33b5b7838f0', 2, '红酒套餐', 3, 3, 1, 3, 588.00, '至尊包厢，豪华套餐', 1545379011091, NULL, 0);
INSERT INTO `package` VALUES (124, 'dde9c250-04ef-11e9-8f7b-2ded32e8ac26', 1, '啤酒套餐', 1, 20, 1, 2, 300.00, '啤酒套餐666', 1545376387829, 1545381924664, 0);
INSERT INTO `package` VALUES (125, 'dde9c250-04ef-11e9-8f7b-2ded32e8ac26', 1, '啤酒套餐', 2, 10, 1, 2, 300.00, '啤酒套餐666', 1545376387829, 1545381924664, 0);
INSERT INTO `package` VALUES (126, 'dde9c250-04ef-11e9-8f7b-2ded32e8ac26', 1, '啤酒套餐', 3, 1, 1, 2, 300.00, '啤酒套餐666', 1545376387829, 1545381924664, 0);
INSERT INTO `package` VALUES (130, '0d802650-04fd-11e9-b8a8-7beaaf9d1385', 1, '玉米', 1, 1, 0, NULL, 50.00, '玉米', 1545382051125, NULL, 0);
INSERT INTO `package` VALUES (131, '5750a250-04fd-11e9-ac09-4b564784a111', 1, '豪华套餐', 1, 1, 0, NULL, 300.00, '1、雪花啤酒20瓶\n2、小吃（花生1份，水果拼盘10盘）', 1545382174965, NULL, 0);
INSERT INTO `package` VALUES (132, '5750a250-04fd-11e9-ac09-4b564784a111', 1, '豪华套餐', 2, 1, 0, NULL, 300.00, '1、雪花啤酒20瓶\n2、小吃（花生1份，水果拼盘10盘）', 1545382174965, NULL, 0);
INSERT INTO `package` VALUES (133, '5750a250-04fd-11e9-ac09-4b564784a111', 1, '豪华套餐', 3, 1, 0, NULL, 300.00, '1、雪花啤酒20瓶\n2、小吃（花生1份，水果拼盘10盘）', 1545382174965, NULL, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (4, '2faefe80-059e-11e9-8180-8f5344447a18', 2, '半导体和', '8888', 666.00, 'dde9c250-04ef-11e9-8f7b-2ded32e8ac26', '', 1545451257447, NULL, 0);
INSERT INTO `room` VALUES (5, '2faefe80-059e-11e9-8180-8f5344447a18', 2, '半导体和', '8888', 666.00, 'f97fed40-04f5-11e9-bed3-f33b5b7838f0', '', 1545451257447, NULL, 0);

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
INSERT INTO `roomtype` VALUES (1, '标准包', 1545357012721, NULL, 0);
INSERT INTO `roomtype` VALUES (2, 'Party大包', 1545357023341, NULL, 0);
INSERT INTO `roomtype` VALUES (3, '至尊包厢', 1545357036212, NULL, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of unit
-- ----------------------------
INSERT INTO `unit` VALUES (1, '间', 'J', 1545356965475, NULL, 0);
INSERT INTO `unit` VALUES (2, '包', 'B', 1545356975012, NULL, 0);
INSERT INTO `unit` VALUES (3, '份', 'F', 1545356981164, NULL, 0);
INSERT INTO `unit` VALUES (4, '盘', 'P', 1545356991279, NULL, 0);
INSERT INTO `unit` VALUES (5, '个', 'G', 1545356999529, NULL, 0);
INSERT INTO `unit` VALUES (6, '瓶', '', 1545357105069, NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
