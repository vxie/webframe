/*
Navicat MySQL Data Transfer

Source Server         : 194
Source Server Version : 50530
Source Host           : 192.168.0.194:3306
Source Database       : HealthyE

Target Server Type    : MYSQL
Target Server Version : 50530
File Encoding         : 65001

Date: 2014-07-07 15:52:30
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
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_area
-- ----------------------------

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_space
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of t_user
-- ----------------------------
