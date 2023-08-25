/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : swzl

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 04/06/2023 10:36:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL COMMENT '贴子ID',
  `uname` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '评论人',
  `content` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '内容',
  `ctime` datetime NULL DEFAULT NULL COMMENT '评论时间',
  `parent` bigint NULL DEFAULT NULL COMMENT '是否有父评论',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comment_ibfk_1`(`post_id`) USING BTREE,
  INDEX `comment_ibfk_2`(`uname`) USING BTREE,
  INDEX `parent_comment`(`parent`) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`uname`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parent_comment` FOREIGN KEY (`parent`) REFERENCES `comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (31, 35, '张三', '', '2023-06-04 04:19:13', NULL);
INSERT INTO `comment` VALUES (32, 35, '李四', '啊啊啊，这是我丢的，太感谢啦', '2023-06-04 04:20:33', NULL);
INSERT INTO `comment` VALUES (33, 35, '张三', '那你下午联系下我哈，电话17733333333。', '2023-06-04 04:22:53', NULL);
INSERT INTO `comment` VALUES (34, 37, '张三', '同学你好，方便的话来找我拿哈', '2023-06-04 09:18:12', NULL);

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uname` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈用户',
  `title` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈标题',
  `content` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '反馈内容',
  `ctime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uname`(`uname`) USING BTREE,
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`uname`) REFERENCES `user` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (10, 'root', '类别增加', '建议管理员大大增加个图书类，这样书本丢失就可以放在该类目下啦', '2023-06-04 04:30:12');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cuser` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '创建人',
  `content` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '内容',
  `ctime` datetime NOT NULL COMMENT '创建时间',
  `title` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '通知标题',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_fk`(`cuser`) USING BTREE,
  CONSTRAINT `admin_fk` FOREIGN KEY (`cuser`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (8, 'admin', '宝宝们，请填写好时间地点以及遗失的物品特征描述，希望大家早点寻回遗失物品。', '2023-06-04 03:47:01', '失物招领公告');

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uname` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '发帖人',
  `type_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '分类',
  `title` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '标题',
  `content` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '内容',
  `picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图片',
  `address` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '地址',
  `ctime` datetime NOT NULL COMMENT '创建时间',
  `status` int NOT NULL COMMENT '状态：1为进行中，0为结束',
  `flag` int NOT NULL COMMENT '标记：1为失物招领，0为寻物启事',
  `view_count` int(10) UNSIGNED ZEROFILL NOT NULL COMMENT '查看次数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `post_ibfk_1`(`uname`) USING BTREE,
  INDEX `psot_fk`(`type_name`) USING BTREE,
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`uname`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `psot_fk` FOREIGN KEY (`type_name`) REFERENCES `type` (`type_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (33, 'admin', '电子产品', '在食堂不慎遗失手机，若有拾到者，必有重谢。', '今天中午12点左右在食堂吃饭时，忘记了放在椅子上的黑色华为Mate手机，若有拾到者请联系15699999999。', '/images/b6942f51e94f4f63b70696fc51cf40bf_33.jpg', '北区食堂', '2023-06-04 04:05:02', 1, 0, 0000000003);
INSERT INTO `post` VALUES (34, 'root', '卡片类', '校园卡丢了', '今天下午3点左右，在操场跑步时不慎掉落校园卡，请捡到的同学联系1781233333。谢谢~', '/images/3562e58015904d3793652d90af27db75_44.jpg', '操场', '2023-06-04 04:08:47', 1, 0, 0000000002);
INSERT INTO `post` VALUES (35, '张三', '电子产品', '捡到耳机一副', '本人在东教101教室捡到苹果耳机一副，遗失者请通过后台联系本人。', '/images/341eacfcdbbc43ecb045b5e4520d7d37_66.jpeg', '东教101教室', '2023-06-04 04:17:20', 0, 1, 0000000012);
INSERT INTO `post` VALUES (36, 'root', '电子产品', '捡到安卓充电器一个', '今早在图书馆12楼捡到安卓充电器一个，请遗失的同学联系我哈。', '/images/46eca04817d24cb58997ab18ca1b5f9e_99.jpeg', '图书馆12楼', '2023-06-04 04:42:10', 1, 1, 0000000003);
INSERT INTO `post` VALUES (37, '李四', '书籍类', '马克思主义课本丢了', '今天下午上完课忘记拿走了放在抽屉里的马克思课本，有哪个同学看到了，帮忙归还下，谢谢啦~', '/images/038eb0fd679b4679863fd30c287678dd_13.jpeg', '西教201', '2023-06-04 09:16:44', 0, 0, 0000000004);

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type_name`(`type_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES (9, '书籍类');
INSERT INTO `type` VALUES (8, '卡片类');
INSERT INTO `type` VALUES (7, '电子产品');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `admin` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户名',
  `password` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'email',
  `sex` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '性别',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `photo` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头像',
  `reward_code` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '打赏码',
  `personal_say` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '个性签名',
  `last_time` datetime NULL DEFAULT NULL COMMENT '上一次登录',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (23, 'false', 'root', '63a9f0ea7bb98050796b649e85481845', '2222@qq.com', '男', 23, '/images/7c4e15f4c73d42a1b305d861aa990f04_22.jpg', NULL, '哈哈哈', '2023-06-04 14:05:13');
INSERT INTO `user` VALUES (24, 'true', 'admin', '21232f297a57a5a743894a0e4a801fc3', '11111@qq.com', '男', 25, '/images/81d5b94e5532487e898d9d0fd588cdcf_11.jpg', NULL, '欢迎光临', '2023-06-04 02:27:47');
INSERT INTO `user` VALUES (25, 'false', '张三', '81dc9bdb52d04dc20036dbd8313ed055', '55555@qq.com', '男', 0, '/images/554bd169e5e0418ea01b76074f90a98f_77.jpeg', NULL, NULL, '2023-06-04 14:05:48');
INSERT INTO `user` VALUES (26, 'false', '李四', '81dc9bdb52d04dc20036dbd8313ed055', '99999@qq.com', '男', 0, '/images/ce4712baa2c6458288f7f91195ed74df_88.jpeg', NULL, NULL, '2023-06-04 09:09:52');

SET FOREIGN_KEY_CHECKS = 1;
