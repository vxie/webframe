/*
Navicat MySQL Data Transfer

Source Server         : 194
Source Server Version : 50530
Source Host           : 192.168.0.194:3306
Source Database       : HealthyE

Target Server Type    : MYSQL
Target Server Version : 50530
File Encoding         : 65001

Date: 2014-07-10 19:04:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_admin`
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `areaId` int(255) DEFAULT NULL COMMENT '地区Id',
  `role` int(11) DEFAULT '1' COMMENT '0=超管,1=地区管理员',
  `number` varchar(255) DEFAULT NULL COMMENT '手机号码',
  `password` varchar(255) DEFAULT NULL COMMENT '登录密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_admin
-- ----------------------------

-- ----------------------------
-- Table structure for `t_area`
-- ----------------------------
DROP TABLE IF EXISTS `t_area`;
CREATE TABLE `t_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '地区的名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_area
-- ----------------------------
INSERT INTO `t_area` VALUES ('1', '广东');
INSERT INTO `t_area` VALUES ('2', '湖南');
INSERT INTO `t_area` VALUES ('3', '北京');

-- ----------------------------
-- Table structure for `t_assessment`
-- ----------------------------
DROP TABLE IF EXISTS `t_assessment`;
CREATE TABLE `t_assessment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '考核时间',
  `level` int(10) NOT NULL DEFAULT '1' COMMENT '评分级别,0=优,1=良,2=差',
  `adminId` int(11) DEFAULT NULL COMMENT '被考核人的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_assessment
-- ----------------------------

-- ----------------------------
-- Table structure for `t_branch`
-- ----------------------------
DROP TABLE IF EXISTS `t_branch`;
CREATE TABLE `t_branch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL COMMENT '分店名称',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `longitude` varchar(200) DEFAULT NULL COMMENT '地理位置上的经度',
  `latitude` varchar(200) DEFAULT NULL COMMENT '地理位置上的纬度',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_branch
-- ----------------------------

-- ----------------------------
-- Table structure for `t_feedback`
-- ----------------------------
DROP TABLE IF EXISTS `t_feedback`;
CREATE TABLE `t_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL COMMENT '作出反馈的会员的id',
  `planId` int(11) DEFAULT NULL COMMENT '被反馈的搭配计划的id',
  `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '反馈时间',
  `content` varchar(500) DEFAULT NULL COMMENT '反馈的内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for `t_group`
-- ----------------------------
DROP TABLE IF EXISTS `t_group`;
CREATE TABLE `t_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '分组名称',
  `headId` int(11) DEFAULT NULL COMMENT '负责该会员组饮食搭配的负责人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_group
-- ----------------------------

-- ----------------------------
-- Table structure for `t_layout`
-- ----------------------------
DROP TABLE IF EXISTS `t_layout`;
CREATE TABLE `t_layout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `textContent` varchar(500) DEFAULT NULL COMMENT '文字内容',
  `picName` varchar(100) DEFAULT NULL COMMENT '图片名称',
  `order` int(11) DEFAULT NULL COMMENT '显示的序号',
  `useing` int(11) DEFAULT '1' COMMENT '是否显示,0=显示,1=不显示',
  `updatetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '图片上传时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_layout
-- ----------------------------

-- ----------------------------
-- Table structure for `t_medicalRecord`
-- ----------------------------
DROP TABLE IF EXISTS `t_medicalRecord`;
CREATE TABLE `t_medicalRecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `annexName` varchar(255) DEFAULT NULL COMMENT '附件名称',
  `useId` int(11) DEFAULT NULL COMMENT '会员id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_medicalRecord
-- ----------------------------

-- ----------------------------
-- Table structure for `t_plan`
-- ----------------------------
DROP TABLE IF EXISTS `t_plan`;
CREATE TABLE `t_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '对应的会员Id',
  `breakfast` varchar(500) DEFAULT NULL COMMENT '早餐的搭配方案',
  `lunch` varchar(500) DEFAULT NULL COMMENT '午餐的搭配方案',
  `dinner` varchar(500) DEFAULT NULL COMMENT '晚餐的搭配方案',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注',
  `sendTime` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '设置预定的发送给会员的时间',
  `groupId` int(11) DEFAULT NULL COMMENT '会员组Id',
  `makeTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '方案制定(修改)的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_plan
-- ----------------------------

-- ----------------------------
-- Table structure for `t_pushInfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_pushInfo`;
CREATE TABLE `t_pushInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text COMMENT '推送信息的内容',
  `time` timestamp NULL DEFAULT NULL COMMENT '发布的时间',
  `adminId` int(11) DEFAULT NULL COMMENT '发布人的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_pushInfo
-- ----------------------------

-- ----------------------------
-- Table structure for `t_pushInfoState`
-- ----------------------------
DROP TABLE IF EXISTS `t_pushInfoState`;
CREATE TABLE `t_pushInfoState` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL COMMENT '会员id',
  `pushInfoId` int(11) DEFAULT NULL COMMENT '推送信息的ID',
  `state` int(11) DEFAULT '1' COMMENT '接收状态,0=已接收到,1=未接收到',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_pushInfoState
-- ----------------------------

-- ----------------------------
-- Table structure for `t_score`
-- ----------------------------
DROP TABLE IF EXISTS `t_score`;
CREATE TABLE `t_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL COMMENT '作出评分的会员的id',
  `planId` int(11) DEFAULT NULL COMMENT '被评分的饮食搭配计划Id',
  `score` int(11) DEFAULT NULL COMMENT '分数,0=优,1=良,2=差',
  `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '评分时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_score
-- ----------------------------

-- ----------------------------
-- Table structure for `t_space`
-- ----------------------------
DROP TABLE IF EXISTS `t_space`;
CREATE TABLE `t_space` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text COMMENT '发表的文字内容.',
  `picName` varchar(100) DEFAULT NULL COMMENT '会员发表文章包含的图片名称',
  `userId` int(11) DEFAULT NULL COMMENT '作者ID',
  `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '发布的时间',
  `state` int(11) DEFAULT '0' COMMENT '审核状态,0=未审核,1=审核通过,2=审核不通过',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_space
-- ----------------------------
INSERT INTO `t_space` VALUES ('1', '测试测试测试测试', 'xxxx.jpg', '1', '2014-07-08 12:33:26', '0');
INSERT INTO `t_space` VALUES ('2', '@E5@85@B7@E4@BD@93', '1.jpg', '1', '2014-07-09 11:26:38', '0');
INSERT INTO `t_space` VALUES ('3', '@E6@99@AE@E9@80@9A', 'Picture 24082048.jpg', '1', '2014-07-09 11:30:15', '0');
INSERT INTO `t_space` VALUES ('4', '测试题', 'Picture 24082048.jpg', '1', '2014-07-09 11:33:54', '0');
INSERT INTO `t_space` VALUES ('5', '个哈', 'Picture 24082048.jpg', '1', '2014-07-09 11:46:42', '0');
INSERT INTO `t_space` VALUES ('6', '近距离', '1404878022271.jpg', '1', '2014-07-09 11:49:58', '0');
INSERT INTO `t_space` VALUES ('7', '近距离', '1404878479450.jpg', '1', '2014-07-09 11:58:35', '0');
INSERT INTO `t_space` VALUES ('8', '近距离', '1404878500027.jpg', '1', '2014-07-09 11:58:41', '0');
INSERT INTO `t_space` VALUES ('9', '近距离', '1404878500027.jpg', '1', '2014-07-09 11:58:59', '0');
INSERT INTO `t_space` VALUES ('10', 'gbhh', '1404887357129.jpg', '1', '2014-07-09 14:25:17', '0');
INSERT INTO `t_space` VALUES ('11', 'hhhh', '1404887541975.jpg', '1', '2014-07-09 14:28:25', '0');
INSERT INTO `t_space` VALUES ('12', 'bbh', '1404887665146.jpg', '1', '2014-07-09 14:30:31', '0');
INSERT INTO `t_space` VALUES ('13', 'hhnhh', '1404887814466.jpg', '1', '2014-07-09 14:33:54', '0');
INSERT INTO `t_space` VALUES ('14', 'hhnhh', '1404887814466.jpg', '1', '2014-07-09 14:34:59', '0');
INSERT INTO `t_space` VALUES ('15', 'hhh', '1404888802331.jpg', '1', '2014-07-09 14:49:29', '0');
INSERT INTO `t_space` VALUES ('16', 'hhh', '1404889017676.jpg', '1', '2014-07-09 14:54:18', '0');
INSERT INTO `t_space` VALUES ('17', 'hhh', '1404889120639.jpg', '1', '2014-07-09 14:54:40', '0');
INSERT INTO `t_space` VALUES ('18', 'vbbb', '1404889789978.jpg', '1', '2014-07-09 15:05:52', '0');
INSERT INTO `t_space` VALUES ('19', 'vbbb', '1404889789978.jpg', '1', '2014-07-09 15:06:47', '0');
INSERT INTO `t_space` VALUES ('20', 'vbbb', '1404889789978.jpg', '1', '2014-07-09 15:07:01', '0');
INSERT INTO `t_space` VALUES ('21', 'nbbh', '1404890236434.jpg', '1', '2014-07-09 15:13:51', '0');
INSERT INTO `t_space` VALUES ('22', 'nbbh', '1404890236434.jpg', '1', '2014-07-09 15:14:53', '0');
INSERT INTO `t_space` VALUES ('23', ' bghhh', '1404890504786.jpg', '1', '2014-07-09 15:17:38', '0');
INSERT INTO `t_space` VALUES ('24', 'ghvghh', '1404890865412.jpg', '1', '2014-07-09 15:23:42', '0');
INSERT INTO `t_space` VALUES ('25', 'ghvghh', '1404890865412.jpg', '1', '2014-07-09 15:32:39', '0');
INSERT INTO `t_space` VALUES ('26', 'ghvghh', '1404890865412.jpg', '1', '2014-07-09 15:34:43', '0');
INSERT INTO `t_space` VALUES ('27', 'ghvghh', '1404890865412.jpg', '1', '2014-07-09 15:35:29', '0');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `phoneNumber` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `medicalRecordId` int(20) DEFAULT NULL COMMENT '病历ID',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  ` groupId` int(11) DEFAULT NULL COMMENT '分组id',
  `age` int(11) DEFAULT NULL COMMENT '会员的年龄',
  `password` varchar(50) DEFAULT '123456' COMMENT '密码',
  `time` timestamp NULL DEFAULT NULL COMMENT '注册时间',
  `brithday` varchar(50) DEFAULT NULL COMMENT '生日',
  `areaId` varchar(50) DEFAULT NULL COMMENT '用户的区域',
  `filename` varchar(50) DEFAULT NULL COMMENT '为病历附件的名称,如果将来客户要求有多张图片,该字段要改用另一张表来关联',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'ggg', '5555', null, 'fghhgf', null, '2588', 'qqqqqq', '2014-07-07 00:00:00', '2014-07-07', '1', '');
