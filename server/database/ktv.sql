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

 Date: 04/01/2019 18:43:28
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
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `goods` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品，多个',
  `qty` varbinary(50) DEFAULT NULL,
  `group` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '多选一',
  `type` int(11) DEFAULT NULL COMMENT '价格档 1：阳光档 2：黄金档',
  `price1` decimal(10, 2) DEFAULT NULL COMMENT '阳光档价格',
  `price2` decimal(10, 2) DEFAULT NULL COMMENT '黄金档价格',
  `descr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of package
-- ----------------------------
INSERT INTO `package` VALUES (1, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '啤酒套餐', '1', 0x3132, NULL, 1, NULL, NULL, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (2, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '啤酒套餐', '2', 0x3130, NULL, 1, NULL, NULL, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (3, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '啤酒套餐', '3', 0x38, NULL, 1, NULL, NULL, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (4, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '啤酒套餐', '8', 0x31, NULL, 1, NULL, NULL, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (5, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '啤酒套餐', '9', 0x31, NULL, 1, NULL, NULL, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (6, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '啤酒套餐', '7', 0x31, NULL, 1, NULL, NULL, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (7, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '啤酒套餐', '14', 0x31, NULL, 1, NULL, NULL, '1、纯啤啤酒12瓶\n2、冰纯啤酒10瓶\n3、雪花啤酒8瓶\n4、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545730682423, NULL, 0);
INSERT INTO `package` VALUES (8, '0681b010-084c-11e9-a567-470a0f92e677', '红酒套餐', '4', 0x31, NULL, 1, NULL, NULL, '1、华夏干红1支加雪碧2罐\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545745823121, NULL, 0);
INSERT INTO `package` VALUES (9, '0681b010-084c-11e9-a567-470a0f92e677', '红酒套餐', '5', 0x32, NULL, 1, NULL, NULL, '1、华夏干红1支加雪碧2罐\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545745823121, NULL, 0);
INSERT INTO `package` VALUES (10, '0681b010-084c-11e9-a567-470a0f92e677', '红酒套餐', '8', 0x31, NULL, 1, NULL, NULL, '1、华夏干红1支加雪碧2罐\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545745823121, NULL, 0);
INSERT INTO `package` VALUES (11, '0681b010-084c-11e9-a567-470a0f92e677', '红酒套餐', '9', 0x31, NULL, 1, NULL, NULL, '1、华夏干红1支加雪碧2罐\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545745823121, NULL, 0);
INSERT INTO `package` VALUES (12, '0681b010-084c-11e9-a567-470a0f92e677', '红酒套餐', '7', 0x31, NULL, 1, NULL, NULL, '1、华夏干红1支加雪碧2罐\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545745823121, NULL, 0);
INSERT INTO `package` VALUES (13, '0681b010-084c-11e9-a567-470a0f92e677', '红酒套餐', '14', 0x31, NULL, 1, NULL, NULL, '1、华夏干红1支加雪碧2罐\n2、小吃2份（蚕豆、瓜子），爆米花1包，什锦果盘小拼1个', 1545745823121, NULL, 0);
INSERT INTO `package` VALUES (14, 'a233b920-0916-11e9-a23c-619a8e35a34d', '小吃套餐', '13', 0x31, NULL, 1, NULL, NULL, '1、小吃6份\n2、茶一壶', 1545832842673, NULL, 0);
INSERT INTO `package` VALUES (15, 'a233b920-0916-11e9-a23c-619a8e35a34d', '小吃套餐', '10', 0x31, NULL, 1, NULL, NULL, '1、小吃6份\n2、茶一壶', 1545832842673, NULL, 0);
INSERT INTO `package` VALUES (16, 'a233b920-0916-11e9-a23c-619a8e35a34d', '小吃套餐', '11', 0x31, NULL, 1, NULL, NULL, '1、小吃6份\n2、茶一壶', 1545832842673, NULL, 0);
INSERT INTO `package` VALUES (17, 'a233b920-0916-11e9-a23c-619a8e35a34d', '小吃套餐', '8', 0x31, NULL, 1, NULL, NULL, '1、小吃6份\n2、茶一壶', 1545832842673, NULL, 0);
INSERT INTO `package` VALUES (18, 'a233b920-0916-11e9-a23c-619a8e35a34d', '小吃套餐', '9', 0x31, NULL, 1, NULL, NULL, '1、小吃6份\n2、茶一壶', 1545832842673, NULL, 0);
INSERT INTO `package` VALUES (19, 'a233b920-0916-11e9-a23c-619a8e35a34d', '小吃套餐', '12', 0x31, NULL, 1, NULL, NULL, '1、小吃6份\n2、茶一壶', 1545832842673, NULL, 0);
INSERT INTO `package` VALUES (20, 'a233b920-0916-11e9-a23c-619a8e35a34d', '小吃套餐', '6', 0x31, NULL, 1, NULL, NULL, '1、小吃6份\n2、茶一壶', 1545832842673, NULL, 0);
INSERT INTO `package` VALUES (21, 'db02e000-0916-11e9-a23c-619a8e35a34d', '水果套餐', '16', 0x35, NULL, 2, NULL, NULL, '什锦果盘大拼5盘', 1545832937984, NULL, 0);

-- ----------------------------
-- Table structure for rechargerecord
-- ----------------------------
DROP TABLE IF EXISTS `rechargerecord`;
CREATE TABLE `rechargerecord`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `money` decimal(10, 2) NOT NULL,
  `time` bigint(20) NOT NULL,
  `off` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rechargerecord
-- ----------------------------
INSERT INTO `rechargerecord` VALUES (1, '15920055057', 500.00, 1546495924925, 0);
INSERT INTO `rechargerecord` VALUES (2, '15920055057', 350.00, 1546495946976, 0);
INSERT INTO `rechargerecord` VALUES (3, '13888888888', 150.00, 1546495991224, 0);
INSERT INTO `rechargerecord` VALUES (4, '15920055057', 66.00, 1546505550352, 0);
INSERT INTO `rechargerecord` VALUES (5, '15920055057', 89.00, 1546505732081, 0);
INSERT INTO `rechargerecord` VALUES (6, '15920055057', 66.00, 1546505739449, 0);
INSERT INTO `rechargerecord` VALUES (7, '15920055057', 300.00, 1546505742950, 0);
INSERT INTO `rechargerecord` VALUES (8, '15920055057', 1000.00, 1546505747784, 0);
INSERT INTO `rechargerecord` VALUES (9, '15920055057', 58.00, 1546505774797, 0);
INSERT INTO `rechargerecord` VALUES (10, '15920055057', 888.00, 1546505778472, 0);
INSERT INTO `rechargerecord` VALUES (11, '15920055057', 990.00, 1546505781402, 0);
INSERT INTO `rechargerecord` VALUES (12, '15920055057', 50.00, 1546505785616, 0);
INSERT INTO `rechargerecord` VALUES (13, '15920055057', 200.00, 1546505788936, 0);
INSERT INTO `rechargerecord` VALUES (14, '15920055057', 100.00, 1546505792998, 0);
INSERT INTO `rechargerecord` VALUES (15, '15920055057', 600.00, 1546505806763, 0);

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
  `status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (3, '901039f0-084c-11e9-a567-470a0f92e677', 3, '南天门', '6666', 99.00, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '', 1545746053903, NULL, 0, 0);
INSERT INTO `room` VALUES (4, 'bc31d570-084c-11e9-a567-470a0f92e677', 3, '金箍棒', '9999', 99.00, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '', 1545746127943, NULL, 0, 1);
INSERT INTO `room` VALUES (6, '074c3690-084d-11e9-a567-470a0f92e677', 2, '月仙殿', '8012', 66.00, '0681b010-084c-11e9-a567-470a0f92e677', '', 1545746253945, NULL, 0, 0);
INSERT INTO `room` VALUES (7, '11803670-084d-11e9-a567-470a0f92e677', 2, '景阳宫', '8013', 77.00, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '', 1545746271063, NULL, 0, 0);
INSERT INTO `room` VALUES (8, '1f69c440-084d-11e9-a567-470a0f92e677', 1, '景殿宫', '8015', 55.00, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '', 1545746294404, NULL, 0, 0);
INSERT INTO `room` VALUES (9, '3575d710-084d-11e9-a567-470a0f92e677', 1, '雪舞宫', '8016', 77.00, '0681b010-084c-11e9-a567-470a0f92e677', '', 1545746331393, NULL, 0, 0);
INSERT INTO `room` VALUES (10, '927b2a00-084d-11e9-a567-470a0f92e677', 1, '天赐宫', '8017', 77.00, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '', 1545746487456, NULL, 0, 0);
INSERT INTO `room` VALUES (11, 'a280ba00-084d-11e9-a567-470a0f92e677', 1, '玉华宫', '8019', 77.00, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '', 1545746514336, NULL, 0, 0);
INSERT INTO `room` VALUES (12, 'b1c962a0-084d-11e9-a567-470a0f92e677', 2, '善岚宫', '8020', 88.00, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '', 1545746539978, NULL, 0, 0);
INSERT INTO `room` VALUES (13, 'c063c9e0-084d-11e9-a567-470a0f92e677', 1, '凌妍阁', '8021', 99.00, '0681b010-084c-11e9-a567-470a0f92e677', '', 1545746564478, NULL, 0, 0);
INSERT INTO `room` VALUES (14, 'cc421e60-084d-11e9-a567-470a0f92e677', 1, '昭阳宫', '8022', 55.00, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '', 1545746584390, NULL, 0, 0);
INSERT INTO `room` VALUES (15, 'fb867db0-084d-11e9-a567-470a0f92e677', 2, '薰梦宫', '8023', 88.00, '0681b010-084c-11e9-a567-470a0f92e677', '', 1545746663691, NULL, 0, 0);
INSERT INTO `room` VALUES (21, 'f4999250-0828-11e9-8b7c-f90e6ffd643f', 1, '慈宁宫', '8011', 66.00, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '来了，老弟', 1545730760693, 1545832949021, 0, 1);
INSERT INTO `room` VALUES (22, 'f4999250-0828-11e9-8b7c-f90e6ffd643f', 1, '慈宁宫', '8011', 66.00, '0681b010-084c-11e9-a567-470a0f92e677', '来了，老弟', 1545730760693, 1545832949021, 0, 1);
INSERT INTO `room` VALUES (23, 'f4999250-0828-11e9-8b7c-f90e6ffd643f', 1, '慈宁宫', '8011', 66.00, 'a233b920-0916-11e9-a23c-619a8e35a34d', '来了，老弟', 1545730760693, 1545832949021, 0, 1);
INSERT INTO `room` VALUES (24, 'f4999250-0828-11e9-8b7c-f90e6ffd643f', 1, '慈宁宫', '8011', 66.00, 'db02e000-0916-11e9-a23c-619a8e35a34d', '来了，老弟', 1545730760693, 1545832949021, 0, 1);

-- ----------------------------
-- Table structure for roomorder
-- ----------------------------
DROP TABLE IF EXISTS `roomorder`;
CREATE TABLE `roomorder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `package` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `goods` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `qty` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `startTime` bigint(20) DEFAULT NULL,
  `cust` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` bigint(20) NOT NULL,
  `off` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomorder
-- ----------------------------
INSERT INTO `roomorder` VALUES (2, '8011', 1, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '1,2,3,5', '10,18,1,1', 1546336692243, '', 1546336692601, 0);
INSERT INTO `roomorder` VALUES (3, '9999', 1, 'c60940c0-0828-11e9-8b7c-f90e6ffd643f', '1', '10', 1546337475610, '', 1546337475921, 0);

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

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0 COMMENT '类型 0：收银；1：管理',
  `root` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '是否已登录（收银）',
  `createTime` bigint(20) NOT NULL,
  `off` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (3, '陈亮', '236338364', 'f889134a41063043803618b18908b6bd6d57b027', 1, 1, 0, 1546532515378, 0);
INSERT INTO `user` VALUES (4, '收银员1', '111', '1c6637a8f2e1f75e06ff9984894d6bd16a3a36a9', 0, 0, 0, 1546532547214, 0);

-- ----------------------------
-- Table structure for vip
-- ----------------------------
DROP TABLE IF EXISTS `vip`;
CREATE TABLE `vip`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `balance` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `recentConsumeTime` bigint(20) DEFAULT NULL COMMENT '最近消费时间',
  `recentConsumeMoney` decimal(10, 2) DEFAULT NULL COMMENT '最近消费金额',
  `totalTime` int(11) DEFAULT NULL COMMENT '累计消费次数',
  `totalMoney` decimal(10, 2) DEFAULT NULL COMMENT '累计消费金额',
  `createTime` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '是否已登录，正在包间中',
  `record` int(11) NOT NULL DEFAULT 0 COMMENT '充值次数',
  `off` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vip
-- ----------------------------
INSERT INTO `vip` VALUES (1, '15920055057', 5257.00, NULL, NULL, NULL, NULL, 1546431572199, NULL, 14, 0);
INSERT INTO `vip` VALUES (2, '13888888888', 150.00, NULL, NULL, NULL, NULL, 1546495981560, NULL, 1, 0);

SET FOREIGN_KEY_CHECKS = 1;
