/*
 Navicat Premium Data Transfer

 Source Server         : aliyun
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : ktv

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 07/01/2019 16:47:56
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
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '纯啤啤酒', NULL, 20.00, 1, '', 0, NULL, 1545710870689, 1546824044487, 1);
INSERT INTO `goods` VALUES (2, '七堡1516啤酒', NULL, 10.00, 1, '畅饮', 0, NULL, 1545710972654, 1546824080031, 0);
INSERT INTO `goods` VALUES (3, '雪花啤酒', NULL, 10.00, 1, '真的有雪花哦', 0, NULL, 1545711013154, NULL, 0);
INSERT INTO `goods` VALUES (4, '华夏干红', NULL, 118.00, 1, '', 0, NULL, 1545711043902, 1546824183625, 0);
INSERT INTO `goods` VALUES (5, '雪碧', NULL, 6.00, 6, '透心凉', 0, NULL, 1545711071418, 1546824199463, 0);
INSERT INTO `goods` VALUES (6, '冰红茶', NULL, 6.00, 1, '', 0, NULL, 1545711147913, 1546824219695, 0);
INSERT INTO `goods` VALUES (7, '爆米花', NULL, 10.00, 4, '爆！爆！爆！', 0, NULL, 1545711196951, NULL, 0);
INSERT INTO `goods` VALUES (8, '小吃1份', NULL, 10.00, 2, '', 0, NULL, 1545711308809, 1546824108256, 0);
INSERT INTO `goods` VALUES (9, '小吃2份', NULL, 10.00, 2, '', 0, NULL, 1545711339119, 1546824122599, 0);
INSERT INTO `goods` VALUES (10, '小吃3份', NULL, 10.00, 2, '小吃', 0, NULL, 1545711366170, 1546824132577, 0);
INSERT INTO `goods` VALUES (11, '小吃4份', NULL, 10.00, 2, '小吃', 0, NULL, 1545711380608, 1546824141899, 0);
INSERT INTO `goods` VALUES (12, '小吃5份', NULL, 10.00, 2, '小吃', 0, NULL, 1545711409836, 1546824152920, 0);
INSERT INTO `goods` VALUES (13, '小吃6份', NULL, 10.00, 2, '小吃', 0, NULL, 1545711427555, 1546824164334, 0);
INSERT INTO `goods` VALUES (14, '什锦果盘小拼', NULL, 20.00, 2, '', 0, NULL, 1545711468435, NULL, 0);
INSERT INTO `goods` VALUES (15, '什锦果盘中拼', NULL, 50.00, 2, '', 0, NULL, 1545711489771, NULL, 0);
INSERT INTO `goods` VALUES (16, '什锦果盘大拼', NULL, 80.00, 2, '', 0, NULL, 1545711509813, NULL, 0);
INSERT INTO `goods` VALUES (17, '红牛', NULL, 10.00, 1, '', 0, NULL, 1546824237361, NULL, 0);
INSERT INTO `goods` VALUES (18, '加多宝', NULL, 10.00, 1, '', 0, NULL, 1546824270755, NULL, 0);
INSERT INTO `goods` VALUES (19, '百事可乐', NULL, 6.00, 1, '', 0, NULL, 1546824295268, NULL, 0);
INSERT INTO `goods` VALUES (20, '可口可乐', NULL, 6.00, 1, '', 0, NULL, 1546824313853, NULL, 0);
INSERT INTO `goods` VALUES (21, '茗茶一壶', NULL, 38.00, 7, '', 0, NULL, 1546828193707, 1546828287041, 0);

-- ----------------------------
-- Table structure for package
-- ----------------------------
DROP TABLE IF EXISTS `package`;
CREATE TABLE `package`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `goods` int(11) DEFAULT NULL COMMENT '商品',
  `qty` int(11) DEFAULT NULL,
  `grp` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `type1` int(11) DEFAULT NULL COMMENT '价格档 1：阳光档 2：黄金档',
  `price1` decimal(10, 2) DEFAULT NULL COMMENT '阳光档价格',
  `type2` int(11) DEFAULT NULL COMMENT '2：黄金档',
  `price2` decimal(10, 2) DEFAULT NULL COMMENT '黄金档价格',
  `descr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 140 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of package
-- ----------------------------
INSERT INTO `package` VALUES (140, 'd939fe90-1224-11e9-9989-d75a6f62cec3', '大包阳光档红酒套餐', 15, 1, '', 1, 168.00, 0, 0.00, '1、华夏干红一支加雪碧2罐；\n2、小吃4分；\n3、爆米花1包；\n4、什锦果盘中拼1份；\n5、茗茶一壶', 1546828508409, 1546829630800, 0);
INSERT INTO `package` VALUES (141, 'd939fe90-1224-11e9-9989-d75a6f62cec3', '大包阳光档红酒套餐', 21, 1, '', 1, 168.00, 0, 0.00, '1、华夏干红一支加雪碧2罐；\n2、小吃4分；\n3、爆米花1包；\n4、什锦果盘中拼1份；\n5、茗茶一壶', 1546828508409, 1546829630800, 0);
INSERT INTO `package` VALUES (142, 'd939fe90-1224-11e9-9989-d75a6f62cec3', '大包阳光档红酒套餐', 4, 1, '', 1, 168.00, 0, 0.00, '1、华夏干红一支加雪碧2罐；\n2、小吃4分；\n3、爆米花1包；\n4、什锦果盘中拼1份；\n5、茗茶一壶', 1546828508409, 1546829630800, 0);
INSERT INTO `package` VALUES (143, 'd939fe90-1224-11e9-9989-d75a6f62cec3', '大包阳光档红酒套餐', 5, 2, '', 1, 168.00, 0, 0.00, '1、华夏干红一支加雪碧2罐；\n2、小吃4分；\n3、爆米花1包；\n4、什锦果盘中拼1份；\n5、茗茶一壶', 1546828508409, 1546829630800, 0);
INSERT INTO `package` VALUES (144, 'd939fe90-1224-11e9-9989-d75a6f62cec3', '大包阳光档红酒套餐', 7, 1, '', 1, 168.00, 0, 0.00, '1、华夏干红一支加雪碧2罐；\n2、小吃4分；\n3、爆米花1包；\n4、什锦果盘中拼1份；\n5、茗茶一壶', 1546828508409, 1546829630800, 0);
INSERT INTO `package` VALUES (145, 'd939fe90-1224-11e9-9989-d75a6f62cec3', '大包阳光档红酒套餐', 11, 1, '', 1, 168.00, 0, 0.00, '1、华夏干红一支加雪碧2罐；\n2、小吃4分；\n3、爆米花1包；\n4、什锦果盘中拼1份；\n5、茗茶一壶', 1546828508409, 1546829630800, 0);
INSERT INTO `package` VALUES (147, '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '标准包黄金档啤酒套餐', 10, 1, '2,3', 0, 0.00, 1, 198.00, '1、七堡1516啤酒10瓶或雪花啤酒8瓶\n2、小吃3分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546624646261, 1546829683539, 0);
INSERT INTO `package` VALUES (148, '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '标准包黄金档啤酒套餐', 2, 10, '2,3', 0, 0.00, 1, 198.00, '1、七堡1516啤酒10瓶或雪花啤酒8瓶\n2、小吃3分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546624646261, 1546829683539, 0);
INSERT INTO `package` VALUES (149, '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '标准包黄金档啤酒套餐', 3, 8, '2,3', 0, 0.00, 1, 198.00, '1、七堡1516啤酒10瓶或雪花啤酒8瓶\n2、小吃3分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546624646261, 1546829683539, 0);
INSERT INTO `package` VALUES (150, '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '标准包黄金档啤酒套餐', 7, 1, '2,3', 0, 0.00, 1, 198.00, '1、七堡1516啤酒10瓶或雪花啤酒8瓶\n2、小吃3分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546624646261, 1546829683539, 0);
INSERT INTO `package` VALUES (151, '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '标准包黄金档啤酒套餐', 14, 1, '2,3', 0, 0.00, 1, 198.00, '1、七堡1516啤酒10瓶或雪花啤酒8瓶\n2、小吃3分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546624646261, 1546829683539, 0);
INSERT INTO `package` VALUES (152, 'fa69f080-1219-11e9-9989-d75a6f62cec3', '标准包黄金档红酒套餐', 4, 1, '', 0, 0.00, 1, 198.00, '1、小吃5份\n2、爆米花1份\n3、什锦果盘中拼1份', 1546823839624, 1546829694414, 0);
INSERT INTO `package` VALUES (153, 'fa69f080-1219-11e9-9989-d75a6f62cec3', '标准包黄金档红酒套餐', 5, 2, '', 0, 0.00, 1, 198.00, '1、小吃5份\n2、爆米花1份\n3、什锦果盘中拼1份', 1546823839624, 1546829694414, 0);
INSERT INTO `package` VALUES (154, 'fa69f080-1219-11e9-9989-d75a6f62cec3', '标准包黄金档红酒套餐', 15, 1, '', 0, 0.00, 1, 198.00, '1、小吃5份\n2、爆米花1份\n3、什锦果盘中拼1份', 1546823839624, 1546829694414, 0);
INSERT INTO `package` VALUES (155, '4b53d400-121c-11e9-9989-d75a6f62cec3', '大包黄金档啤酒套餐', 2, 14, '2,3', 0, 0.00, 1, 298.00, '1、七堡啤酒14瓶或雪花啤酒12瓶\n2、小吃5分\n3、爆米花1份\n4、什锦果盘中拼1份', 1546824834368, 1546829709675, 0);
INSERT INTO `package` VALUES (156, '4b53d400-121c-11e9-9989-d75a6f62cec3', '大包黄金档啤酒套餐', 3, 12, '2,3', 0, 0.00, 1, 298.00, '1、七堡啤酒14瓶或雪花啤酒12瓶\n2、小吃5分\n3、爆米花1份\n4、什锦果盘中拼1份', 1546824834368, 1546829709675, 0);
INSERT INTO `package` VALUES (157, '4b53d400-121c-11e9-9989-d75a6f62cec3', '大包黄金档啤酒套餐', 12, 1, '2,3', 0, 0.00, 1, 298.00, '1、七堡啤酒14瓶或雪花啤酒12瓶\n2、小吃5分\n3、爆米花1份\n4、什锦果盘中拼1份', 1546824834368, 1546829709675, 0);
INSERT INTO `package` VALUES (158, '4b53d400-121c-11e9-9989-d75a6f62cec3', '大包黄金档啤酒套餐', 7, 1, '2,3', 0, 0.00, 1, 298.00, '1、七堡啤酒14瓶或雪花啤酒12瓶\n2、小吃5分\n3、爆米花1份\n4、什锦果盘中拼1份', 1546824834368, 1546829709675, 0);
INSERT INTO `package` VALUES (159, '4b53d400-121c-11e9-9989-d75a6f62cec3', '大包黄金档啤酒套餐', 15, 1, '2,3', 0, 0.00, 1, 298.00, '1、七堡啤酒14瓶或雪花啤酒12瓶\n2、小吃5分\n3、爆米花1份\n4、什锦果盘中拼1份', 1546824834368, 1546829709675, 0);
INSERT INTO `package` VALUES (160, 'b9c68450-121c-11e9-9989-d75a6f62cec3', '大包黄金档红酒套餐', 12, 1, '', 0, 0.00, 1, 298.00, '1、华夏干红一支加雪碧2罐\n2、小吃5份\n3、爆米花1份\n4、什锦果盘中拼1份', 1546825019669, 1546829723160, 0);
INSERT INTO `package` VALUES (161, 'b9c68450-121c-11e9-9989-d75a6f62cec3', '大包黄金档红酒套餐', 7, 1, '', 0, 0.00, 1, 298.00, '1、华夏干红一支加雪碧2罐\n2、小吃5份\n3、爆米花1份\n4、什锦果盘中拼1份', 1546825019669, 1546829723160, 0);
INSERT INTO `package` VALUES (162, 'b9c68450-121c-11e9-9989-d75a6f62cec3', '大包黄金档红酒套餐', 15, 1, '', 0, 0.00, 1, 298.00, '1、华夏干红一支加雪碧2罐\n2、小吃5份\n3、爆米花1份\n4、什锦果盘中拼1份', 1546825019669, 1546829723160, 0);
INSERT INTO `package` VALUES (163, 'b9c68450-121c-11e9-9989-d75a6f62cec3', '大包黄金档红酒套餐', 4, 1, '', 0, 0.00, 1, 298.00, '1、华夏干红一支加雪碧2罐\n2、小吃5份\n3、爆米花1份\n4、什锦果盘中拼1份', 1546825019669, 1546829723160, 0);
INSERT INTO `package` VALUES (164, 'b9c68450-121c-11e9-9989-d75a6f62cec3', '大包黄金档红酒套餐', 5, 2, '', 0, 0.00, 1, 298.00, '1、华夏干红一支加雪碧2罐\n2、小吃5份\n3、爆米花1份\n4、什锦果盘中拼1份', 1546825019669, 1546829723160, 0);
INSERT INTO `package` VALUES (165, 'a5f7da30-1223-11e9-9989-d75a6f62cec3', '豪包黄金档红酒套餐', 13, 1, '', 0, 0.00, 1, 598.00, '1、华夏干红一支加雪碧2罐\n2、小吃6份\n3、爆米花1份\n4、什锦果盘中拼2份', 1546827992915, 1546829735555, 0);
INSERT INTO `package` VALUES (166, 'a5f7da30-1223-11e9-9989-d75a6f62cec3', '豪包黄金档红酒套餐', 15, 2, '', 0, 0.00, 1, 598.00, '1、华夏干红一支加雪碧2罐\n2、小吃6份\n3、爆米花1份\n4、什锦果盘中拼2份', 1546827992915, 1546829735555, 0);
INSERT INTO `package` VALUES (167, 'a5f7da30-1223-11e9-9989-d75a6f62cec3', '豪包黄金档红酒套餐', 4, 1, '', 0, 0.00, 1, 598.00, '1、华夏干红一支加雪碧2罐\n2、小吃6份\n3、爆米花1份\n4、什锦果盘中拼2份', 1546827992915, 1546829735555, 0);
INSERT INTO `package` VALUES (168, 'a5f7da30-1223-11e9-9989-d75a6f62cec3', '豪包黄金档红酒套餐', 5, 2, '', 0, 0.00, 1, 598.00, '1、华夏干红一支加雪碧2罐\n2、小吃6份\n3、爆米花1份\n4、什锦果盘中拼2份', 1546827992915, 1546829735555, 0);
INSERT INTO `package` VALUES (169, 'a5f7da30-1223-11e9-9989-d75a6f62cec3', '豪包黄金档红酒套餐', 7, 1, '', 0, 0.00, 1, 598.00, '1、华夏干红一支加雪碧2罐\n2、小吃6份\n3、爆米花1份\n4、什锦果盘中拼2份', 1546827992915, 1546829735555, 0);
INSERT INTO `package` VALUES (170, '7985adb0-1223-11e9-9989-d75a6f62cec3', '豪包黄金档啤酒套餐', 2, 14, '2,3', 0, 0.00, 1, 598.00, '1、七堡啤酒14瓶或雪花啤酒12瓶\n2、小吃6份\n3、爆米花1份\n4、什锦果盘中拼2份', 1546827918347, 1546829748331, 0);
INSERT INTO `package` VALUES (171, '7985adb0-1223-11e9-9989-d75a6f62cec3', '豪包黄金档啤酒套餐', 3, 12, '2,3', 0, 0.00, 1, 598.00, '1、七堡啤酒14瓶或雪花啤酒12瓶\n2、小吃6份\n3、爆米花1份\n4、什锦果盘中拼2份', 1546827918347, 1546829748331, 0);
INSERT INTO `package` VALUES (172, '7985adb0-1223-11e9-9989-d75a6f62cec3', '豪包黄金档啤酒套餐', 13, 1, '2,3', 0, 0.00, 1, 598.00, '1、七堡啤酒14瓶或雪花啤酒12瓶\n2、小吃6份\n3、爆米花1份\n4、什锦果盘中拼2份', 1546827918347, 1546829748331, 0);
INSERT INTO `package` VALUES (173, '7985adb0-1223-11e9-9989-d75a6f62cec3', '豪包黄金档啤酒套餐', 7, 1, '2,3', 0, 0.00, 1, 598.00, '1、七堡啤酒14瓶或雪花啤酒12瓶\n2、小吃6份\n3、爆米花1份\n4、什锦果盘中拼2份', 1546827918347, 1546829748331, 0);
INSERT INTO `package` VALUES (174, '7985adb0-1223-11e9-9989-d75a6f62cec3', '豪包黄金档啤酒套餐', 16, 2, '2,3', 0, 0.00, 1, 598.00, '1、七堡啤酒14瓶或雪花啤酒12瓶\n2、小吃6份\n3、爆米花1份\n4、什锦果盘中拼2份', 1546827918347, 1546829748331, 0);
INSERT INTO `package` VALUES (175, 'de2d8030-1223-11e9-9989-d75a6f62cec3', '标准包阳光档啤酒套餐', 7, 1, '2,3', 1, 98.00, 0, 0.00, '1、七堡1516啤酒6瓶或雪花啤酒5瓶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828087219, 1546829760811, 0);
INSERT INTO `package` VALUES (176, 'de2d8030-1223-11e9-9989-d75a6f62cec3', '标准包阳光档啤酒套餐', 14, 1, '2,3', 1, 98.00, 0, 0.00, '1、七堡1516啤酒6瓶或雪花啤酒5瓶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828087219, 1546829760811, 0);
INSERT INTO `package` VALUES (177, 'de2d8030-1223-11e9-9989-d75a6f62cec3', '标准包阳光档啤酒套餐', 2, 1, '2,3', 1, 98.00, 0, 0.00, '1、七堡1516啤酒6瓶或雪花啤酒5瓶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828087219, 1546829760811, 0);
INSERT INTO `package` VALUES (178, 'de2d8030-1223-11e9-9989-d75a6f62cec3', '标准包阳光档啤酒套餐', 3, 1, '2,3', 1, 98.00, 0, 0.00, '1、七堡1516啤酒6瓶或雪花啤酒5瓶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828087219, 1546829760811, 0);
INSERT INTO `package` VALUES (179, 'de2d8030-1223-11e9-9989-d75a6f62cec3', '标准包阳光档啤酒套餐', 8, 1, '2,3', 1, 98.00, 0, 0.00, '1、七堡1516啤酒6瓶或雪花啤酒5瓶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828087219, 1546829760811, 0);
INSERT INTO `package` VALUES (180, '4d21bc90-1224-11e9-9989-d75a6f62cec3', '标准包阳光档茶水套餐', 21, 1, '', 1, 98.00, 0, 0.00, '1、茗茶一壶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828273369, 1546829772584, 0);
INSERT INTO `package` VALUES (181, '4d21bc90-1224-11e9-9989-d75a6f62cec3', '标准包阳光档茶水套餐', 8, 1, '', 1, 98.00, 0, 0.00, '1、茗茶一壶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828273369, 1546829772584, 0);
INSERT INTO `package` VALUES (182, '4d21bc90-1224-11e9-9989-d75a6f62cec3', '标准包阳光档茶水套餐', 7, 1, '', 1, 98.00, 0, 0.00, '1、茗茶一壶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828273369, 1546829772584, 0);
INSERT INTO `package` VALUES (183, '4d21bc90-1224-11e9-9989-d75a6f62cec3', '标准包阳光档茶水套餐', 14, 1, '', 1, 98.00, 0, 0.00, '1、茗茶一壶\n2、小吃1分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828273369, 1546829772584, 0);
INSERT INTO `package` VALUES (184, '94902cb0-1224-11e9-9989-d75a6f62cec3', '大包阳光档啤酒套餐', 2, 1, '2,3', 1, 168.00, 0, 0.00, '1、七堡1516啤酒10瓶或雪花啤酒8瓶\n2、小吃4分\n3、爆米花1包\n4、什锦果盘中拼1份\n5、茗茶一壶', 1546828393211, 1546829786645, 0);
INSERT INTO `package` VALUES (185, '94902cb0-1224-11e9-9989-d75a6f62cec3', '大包阳光档啤酒套餐', 3, 1, '2,3', 1, 168.00, 0, 0.00, '1、七堡1516啤酒10瓶或雪花啤酒8瓶\n2、小吃4分\n3、爆米花1包\n4、什锦果盘中拼1份\n5、茗茶一壶', 1546828393211, 1546829786645, 0);
INSERT INTO `package` VALUES (186, '94902cb0-1224-11e9-9989-d75a6f62cec3', '大包阳光档啤酒套餐', 7, 1, '2,3', 1, 168.00, 0, 0.00, '1、七堡1516啤酒10瓶或雪花啤酒8瓶\n2、小吃4分\n3、爆米花1包\n4、什锦果盘中拼1份\n5、茗茶一壶', 1546828393211, 1546829786645, 0);
INSERT INTO `package` VALUES (187, '94902cb0-1224-11e9-9989-d75a6f62cec3', '大包阳光档啤酒套餐', 11, 1, '2,3', 1, 168.00, 0, 0.00, '1、七堡1516啤酒10瓶或雪花啤酒8瓶\n2、小吃4分\n3、爆米花1包\n4、什锦果盘中拼1份\n5、茗茶一壶', 1546828393211, 1546829786645, 0);
INSERT INTO `package` VALUES (188, '94902cb0-1224-11e9-9989-d75a6f62cec3', '大包阳光档啤酒套餐', 15, 1, '2,3', 1, 168.00, 0, 0.00, '1、七堡1516啤酒10瓶或雪花啤酒8瓶\n2、小吃4分\n3、爆米花1包\n4、什锦果盘中拼1份\n5、茗茶一壶', 1546828393211, 1546829786645, 0);
INSERT INTO `package` VALUES (189, '94902cb0-1224-11e9-9989-d75a6f62cec3', '大包阳光档啤酒套餐', 21, 1, '2,3', 1, 168.00, 0, 0.00, '1、七堡1516啤酒10瓶或雪花啤酒8瓶\n2、小吃4分\n3、爆米花1包\n4、什锦果盘中拼1份\n5、茗茶一壶', 1546828393211, 1546829786645, 0);
INSERT INTO `package` VALUES (190, '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '豪包阳光档啤酒套餐', 2, 1, '2,3', 1, 298.00, 0, 0.00, '1、七堡1516啤酒14瓶或雪花啤酒12瓶\n2、小吃5分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828624618, 1546829799822, 0);
INSERT INTO `package` VALUES (191, '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '豪包阳光档啤酒套餐', 3, 1, '2,3', 1, 298.00, 0, 0.00, '1、七堡1516啤酒14瓶或雪花啤酒12瓶\n2、小吃5分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828624618, 1546829799822, 0);
INSERT INTO `package` VALUES (192, '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '豪包阳光档啤酒套餐', 7, 1, '2,3', 1, 298.00, 0, 0.00, '1、七堡1516啤酒14瓶或雪花啤酒12瓶\n2、小吃5分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828624618, 1546829799822, 0);
INSERT INTO `package` VALUES (193, '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '豪包阳光档啤酒套餐', 12, 1, '2,3', 1, 298.00, 0, 0.00, '1、七堡1516啤酒14瓶或雪花啤酒12瓶\n2、小吃5分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828624618, 1546829799822, 0);
INSERT INTO `package` VALUES (194, '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '豪包阳光档啤酒套餐', 15, 1, '2,3', 1, 298.00, 0, 0.00, '1、七堡1516啤酒14瓶或雪花啤酒12瓶\n2、小吃5分\n3、爆米花1包\n4、什锦果盘小拼1份', 1546828624618, 1546829799822, 0);
INSERT INTO `package` VALUES (195, '459abed0-1225-11e9-9989-d75a6f62cec3', '豪华阳光档红酒套餐', 4, 1, '', 1, 298.00, 0, 0.00, '1、华夏干红一支加雪碧2罐\n2、小吃5分\n3、爆米花1包\n4、什锦果盘中拼1份', 1546828690237, 1546829811106, 0);
INSERT INTO `package` VALUES (196, '459abed0-1225-11e9-9989-d75a6f62cec3', '豪华阳光档红酒套餐', 5, 2, '', 1, 298.00, 0, 0.00, '1、华夏干红一支加雪碧2罐\n2、小吃5分\n3、爆米花1包\n4、什锦果盘中拼1份', 1546828690237, 1546829811106, 0);
INSERT INTO `package` VALUES (197, '459abed0-1225-11e9-9989-d75a6f62cec3', '豪华阳光档红酒套餐', 12, 1, '', 1, 298.00, 0, 0.00, '1、华夏干红一支加雪碧2罐\n2、小吃5分\n3、爆米花1包\n4、什锦果盘中拼1份', 1546828690237, 1546829811106, 0);
INSERT INTO `package` VALUES (198, '459abed0-1225-11e9-9989-d75a6f62cec3', '豪华阳光档红酒套餐', 7, 1, '', 1, 298.00, 0, 0.00, '1、华夏干红一支加雪碧2罐\n2、小吃5分\n3、爆米花1包\n4、什锦果盘中拼1份', 1546828690237, 1546829811106, 0);
INSERT INTO `package` VALUES (199, '459abed0-1225-11e9-9989-d75a6f62cec3', '豪华阳光档红酒套餐', 15, 1, '', 1, 298.00, 0, 0.00, '1、华夏干红一支加雪碧2罐\n2、小吃5分\n3、爆米花1包\n4、什锦果盘中拼1份', 1546828690237, 1546829811106, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `rechargerecord` VALUES (16, '13888888888', 50.00, 1546699210400, 0);
INSERT INTO `rechargerecord` VALUES (17, '13888888888', 35.00, 1546699414355, 0);
INSERT INTO `rechargerecord` VALUES (18, '13888888888', 15.00, 1546699437406, 0);
INSERT INTO `rechargerecord` VALUES (19, '13888888888', 60.00, 1546719501237, 0);
INSERT INTO `rechargerecord` VALUES (20, '13888888888', 20.00, 1546758332075, 0);

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
  `package` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `descr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `position` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` bigint(20) NOT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `off` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 134 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (66, 'f4999250-0828-11e9-8b7c-f90e6ffd643f', 1, '慈宁宫', '8011', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_2', 1545746053903, 1546828820603, 0, 1);
INSERT INTO `room` VALUES (67, 'f4999250-0828-11e9-8b7c-f90e6ffd643f', 1, '慈宁宫', '8011', 'b9c68450-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_2', 1545746053903, 1546828820603, 0, 1);
INSERT INTO `room` VALUES (68, 'f4999250-0828-11e9-8b7c-f90e6ffd643f', 1, '慈宁宫', '8011', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_2', 1545746053903, 1546828820603, 0, 1);
INSERT INTO `room` VALUES (69, 'f4999250-0828-11e9-8b7c-f90e6ffd643f', 1, '慈宁宫', '8011', 'd939fe90-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_2', 1545746053903, 1546828820603, 0, 1);
INSERT INTO `room` VALUES (75, '074c3690-084d-11e9-a567-470a0f92e677', 2, '月仙殿', '8012', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_3', 1545746253945, 1546828857745, 0, 1);
INSERT INTO `room` VALUES (76, '074c3690-084d-11e9-a567-470a0f92e677', 2, '月仙殿', '8012', 'b9c68450-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_3', 1545746253945, 1546828857745, 0, 1);
INSERT INTO `room` VALUES (77, '074c3690-084d-11e9-a567-470a0f92e677', 2, '月仙殿', '8012', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_3', 1545746253945, 1546828857745, 0, 1);
INSERT INTO `room` VALUES (78, '074c3690-084d-11e9-a567-470a0f92e677', 2, '月仙殿', '8012', 'd939fe90-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_3', 1545746253945, 1546828857745, 0, 1);
INSERT INTO `room` VALUES (80, '1f69c440-084d-11e9-a567-470a0f92e677', 1, '景殿宫', '8015', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_5', 1545746294404, 1546828869728, 0, 0);
INSERT INTO `room` VALUES (81, '1f69c440-084d-11e9-a567-470a0f92e677', 1, '景殿宫', '8015', 'b9c68450-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_5', 1545746294404, 1546828869728, 0, 0);
INSERT INTO `room` VALUES (82, '1f69c440-084d-11e9-a567-470a0f92e677', 1, '景殿宫', '8015', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_5', 1545746294404, 1546828869728, 0, 0);
INSERT INTO `room` VALUES (83, '1f69c440-084d-11e9-a567-470a0f92e677', 1, '景殿宫', '8015', 'd939fe90-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_5', 1545746294404, 1546828869728, 0, 0);
INSERT INTO `room` VALUES (84, '3575d710-084d-11e9-a567-470a0f92e677', 1, '雪舞宫', '8016', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '', '1_6', 1545746331393, 1546828902361, 0, 0);
INSERT INTO `room` VALUES (85, '3575d710-084d-11e9-a567-470a0f92e677', 1, '雪舞宫', '8016', 'fa69f080-1219-11e9-9989-d75a6f62cec3', '', '1_6', 1545746331393, 1546828902361, 0, 0);
INSERT INTO `room` VALUES (86, '3575d710-084d-11e9-a567-470a0f92e677', 1, '雪舞宫', '8016', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '', '1_6', 1545746331393, 1546828902361, 0, 0);
INSERT INTO `room` VALUES (87, '3575d710-084d-11e9-a567-470a0f92e677', 1, '雪舞宫', '8016', '4d21bc90-1224-11e9-9989-d75a6f62cec3', '', '1_6', 1545746331393, 1546828902361, 0, 0);
INSERT INTO `room` VALUES (89, 'bc31d570-084c-11e9-a567-470a0f92e677', 3, '金箍棒', '9999', '7985adb0-1223-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_1', 1545746480000, 1546828947559, 0, 0);
INSERT INTO `room` VALUES (90, 'bc31d570-084c-11e9-a567-470a0f92e677', 3, '金箍棒', '9999', 'a5f7da30-1223-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_1', 1545746480000, 1546828947559, 0, 0);
INSERT INTO `room` VALUES (91, 'bc31d570-084c-11e9-a567-470a0f92e677', 3, '金箍棒', '9999', '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_1', 1545746480000, 1546828947559, 0, 0);
INSERT INTO `room` VALUES (92, 'bc31d570-084c-11e9-a567-470a0f92e677', 3, '金箍棒', '9999', '459abed0-1225-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_1', 1545746480000, 1546828947559, 0, 0);
INSERT INTO `room` VALUES (93, '927b2a00-084d-11e9-a567-470a0f92e677', 1, '天赐宫', '8017', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '欢乐唱响', '2_2', 1545746487456, 1546828961088, 0, 0);
INSERT INTO `room` VALUES (94, '927b2a00-084d-11e9-a567-470a0f92e677', 1, '天赐宫', '8017', 'fa69f080-1219-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_2', 1545746487456, 1546828961088, 0, 0);
INSERT INTO `room` VALUES (95, '927b2a00-084d-11e9-a567-470a0f92e677', 1, '天赐宫', '8017', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_2', 1545746487456, 1546828961088, 0, 0);
INSERT INTO `room` VALUES (96, '927b2a00-084d-11e9-a567-470a0f92e677', 1, '天赐宫', '8017', '4d21bc90-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_2', 1545746487456, 1546828961088, 0, 0);
INSERT INTO `room` VALUES (97, 'a280ba00-084d-11e9-a567-470a0f92e677', 1, '玉华宫', '8019', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '欢乐唱响', '2_3', 1545746514336, 1546828982158, 0, 0);
INSERT INTO `room` VALUES (98, 'a280ba00-084d-11e9-a567-470a0f92e677', 1, '玉华宫', '8019', 'fa69f080-1219-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_3', 1545746514336, 1546828982158, 0, 0);
INSERT INTO `room` VALUES (99, 'a280ba00-084d-11e9-a567-470a0f92e677', 1, '玉华宫', '8019', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_3', 1545746514336, 1546828982158, 0, 0);
INSERT INTO `room` VALUES (100, 'a280ba00-084d-11e9-a567-470a0f92e677', 1, '玉华宫', '8019', '4d21bc90-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_3', 1545746514336, 1546828982158, 0, 0);
INSERT INTO `room` VALUES (101, 'b1c962a0-084d-11e9-a567-470a0f92e677', 2, '善岚宫', '8020', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_4', 1545746539978, 1546828997101, 0, 0);
INSERT INTO `room` VALUES (102, 'b1c962a0-084d-11e9-a567-470a0f92e677', 2, '善岚宫', '8020', 'b9c68450-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_4', 1545746539978, 1546828997101, 0, 0);
INSERT INTO `room` VALUES (103, 'b1c962a0-084d-11e9-a567-470a0f92e677', 2, '善岚宫', '8020', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_4', 1545746539978, 1546828997101, 0, 0);
INSERT INTO `room` VALUES (104, 'b1c962a0-084d-11e9-a567-470a0f92e677', 2, '善岚宫', '8020', 'd939fe90-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_4', 1545746539978, 1546828997101, 0, 0);
INSERT INTO `room` VALUES (105, 'c063c9e0-084d-11e9-a567-470a0f92e677', 1, '凌妍阁', '8021', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '欢乐唱响', '2_5', 1545746564478, 1546829011936, 0, 0);
INSERT INTO `room` VALUES (106, 'c063c9e0-084d-11e9-a567-470a0f92e677', 1, '凌妍阁', '8021', 'fa69f080-1219-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_5', 1545746564478, 1546829011936, 0, 0);
INSERT INTO `room` VALUES (107, 'c063c9e0-084d-11e9-a567-470a0f92e677', 1, '凌妍阁', '8021', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_5', 1545746564478, 1546829011936, 0, 0);
INSERT INTO `room` VALUES (108, 'c063c9e0-084d-11e9-a567-470a0f92e677', 1, '凌妍阁', '8021', '4d21bc90-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_5', 1545746564478, 1546829011936, 0, 0);
INSERT INTO `room` VALUES (113, 'fb867db0-084d-11e9-a567-470a0f92e677', 2, '薰梦宫', '8023', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_7', 1545746663691, 1546829032421, 0, 0);
INSERT INTO `room` VALUES (114, 'fb867db0-084d-11e9-a567-470a0f92e677', 2, '薰梦宫', '8023', 'b9c68450-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_7', 1545746663691, 1546829032421, 0, 0);
INSERT INTO `room` VALUES (115, 'fb867db0-084d-11e9-a567-470a0f92e677', 2, '薰梦宫', '8023', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_7', 1545746663691, 1546829032421, 0, 0);
INSERT INTO `room` VALUES (116, 'fb867db0-084d-11e9-a567-470a0f92e677', 2, '薰梦宫', '8023', 'd939fe90-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_7', 1545746663691, 1546829032421, 0, 0);
INSERT INTO `room` VALUES (130, '11803670-084d-11e9-a567-470a0f92e677', 2, '景阳宫', '8013', '4b53d400-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_4', 1545746271063, 1546829089594, 0, 0);
INSERT INTO `room` VALUES (131, '11803670-084d-11e9-a567-470a0f92e677', 2, '景阳宫', '8013', 'b9c68450-121c-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_4', 1545746271063, 1546829089594, 0, 0);
INSERT INTO `room` VALUES (132, '11803670-084d-11e9-a567-470a0f92e677', 2, '景阳宫', '8013', 'd939fe90-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_4', 1545746271063, 1546829089594, 0, 0);
INSERT INTO `room` VALUES (133, '11803670-084d-11e9-a567-470a0f92e677', 2, '景阳宫', '8013', '94902cb0-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_4', 1545746271063, 1546829089594, 0, 0);
INSERT INTO `room` VALUES (134, 'cc421e60-084d-11e9-a567-470a0f92e677', 1, '昭阳宫', '8022', '31eada50-104a-11e9-a1db-0d5fe7aa5fe3', '欢乐唱响', '2_6', 1545746584390, 1546829861118, 0, 0);
INSERT INTO `room` VALUES (135, 'cc421e60-084d-11e9-a567-470a0f92e677', 1, '昭阳宫', '8022', 'de2d8030-1223-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_6', 1545746584390, 1546829861118, 0, 0);
INSERT INTO `room` VALUES (136, 'cc421e60-084d-11e9-a567-470a0f92e677', 1, '昭阳宫', '8022', '4d21bc90-1224-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_6', 1545746584390, 1546829861118, 0, 0);
INSERT INTO `room` VALUES (137, 'cc421e60-084d-11e9-a567-470a0f92e677', 1, '昭阳宫', '8022', 'fa69f080-1219-11e9-9989-d75a6f62cec3', '欢乐唱响', '2_6', 1545746584390, 1546829861118, 0, 0);
INSERT INTO `room` VALUES (138, '901039f0-084c-11e9-a567-470a0f92e677', 3, '南天门', '6666', '1e7e14a0-1225-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_1', 1545730760693, 1546839501958, 0, 1);
INSERT INTO `room` VALUES (139, '901039f0-084c-11e9-a567-470a0f92e677', 3, '南天门', '6666', '459abed0-1225-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_1', 1545730760693, 1546839501958, 0, 1);
INSERT INTO `room` VALUES (140, '901039f0-084c-11e9-a567-470a0f92e677', 3, '南天门', '6666', 'a5f7da30-1223-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_1', 1545730760693, 1546839501958, 0, 1);
INSERT INTO `room` VALUES (141, '901039f0-084c-11e9-a567-470a0f92e677', 3, '南天门', '6666', '7985adb0-1223-11e9-9989-d75a6f62cec3', '欢乐唱响', '1_1', 1545730760693, 1546839501958, 0, 1);

-- ----------------------------
-- Table structure for roomorder
-- ----------------------------
DROP TABLE IF EXISTS `roomorder`;
CREATE TABLE `roomorder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nun` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `room` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `package` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `packageType` int(11) DEFAULT NULL,
  `grpSelected` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `goods` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `qty` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `startTime` bigint(20) NOT NULL COMMENT '下单时间',
  `vip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `totalPrice` decimal(10, 2) DEFAULT NULL,
  `discount` decimal(10, 2) DEFAULT NULL,
  `payMethod` int(11) DEFAULT NULL,
  `user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收银员',
  `printTime` bigint(20) DEFAULT NULL COMMENT '打单时间',
  `createTime` bigint(20) NOT NULL,
  `off` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomorder
-- ----------------------------
INSERT INTO `roomorder` VALUES (46, '021546843695156', '8011', 1, 'b9c68450-121c-11e9-9989-d75a6f62cec3', 2, '', '', '', 1546843699480, NULL, 298.00, NULL, NULL, NULL, NULL, 1546843695156, 1);
INSERT INTO `roomorder` VALUES (47, '511546843701798', '8011', 1, 'b9c68450-121c-11e9-9989-d75a6f62cec3', 2, '', '', '', 1546843706117, NULL, 298.00, NULL, NULL, NULL, NULL, 1546843701798, 1);
INSERT INTO `roomorder` VALUES (48, '191546846490096', '6666', 1, '459abed0-1225-11e9-9989-d75a6f62cec3', 1, '', '', '', 1546846495422, NULL, 298.00, NULL, NULL, NULL, NULL, 1546846490096, 1);
INSERT INTO `roomorder` VALUES (49, '611546846514884', '6666', 1, '1e7e14a0-1225-11e9-9989-d75a6f62cec3', 1, '3', '', '', 1546846520399, NULL, 298.00, NULL, NULL, NULL, NULL, 1546846514884, 0);
INSERT INTO `roomorder` VALUES (50, '431546846531412', '8011', 1, '94902cb0-1224-11e9-9989-d75a6f62cec3', 1, '2', '', '', 1546846536925, NULL, 168.00, NULL, NULL, NULL, NULL, 1546846531412, 0);
INSERT INTO `roomorder` VALUES (51, '821546846586412', '8012', 1, 'd939fe90-1224-11e9-9989-d75a6f62cec3', 1, '', '', '', 1546846591928, NULL, 168.00, NULL, NULL, NULL, NULL, 1546846586412, 0);

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
INSERT INTO `roomtype` VALUES (2, '大  包', 1545730496991, 1546823066933, 0);
INSERT INTO `roomtype` VALUES (3, '豪华包', 1545730504991, 1546823079692, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vip
-- ----------------------------
INSERT INTO `vip` VALUES (1, '15920055057', 5257.00, NULL, NULL, NULL, NULL, 1546431572199, NULL, 14, 0);
INSERT INTO `vip` VALUES (2, '13888888888', 198.00, NULL, NULL, NULL, NULL, 1546495981560, 0, 6, 0);
INSERT INTO `vip` VALUES (3, '15855555557', 0.00, NULL, NULL, NULL, NULL, 1546763388701, NULL, 0, 0);

SET FOREIGN_KEY_CHECKS = 1;
