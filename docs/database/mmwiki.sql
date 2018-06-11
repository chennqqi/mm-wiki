-- --------------------------------
-- database: mm_wiki
-- author: phachon
-- --------------------------------

-- --------------------------------
-- 用户表
-- --------------------------------
DROP TABLE IF EXISTS `mw_user`;
CREATE TABLE `mw_user` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户 id',
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `given_name` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `mobile` char(13) NOT NULL DEFAULT '' COMMENT '手机号',
  `phone` char(13) NOT NULL DEFAULT '' COMMENT '电话',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `department` char(50) NOT NULL DEFAULT '' COMMENT '部门',
  `position` char(50) NOT NULL DEFAULT '' COMMENT '职位',
  `location` char(50) NOT NULL DEFAULT '' COMMENT '位置',
  `im` char(50) NOT NULL DEFAULT '' COMMENT '即时聊天工具',
  `last_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `role` tinyint(3) NOT NULL DEFAULT '0' COMMENT '1 普通用户 2 管理员;3超级管理员',
  `is_delete` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否删除，0 否 1 是',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

INSERT INTO `mw_user` (`username`, `password`, `email`,  `mobile`, `role`, `is_delete`, `create_time`, `update_time`)
VALUES ('root', 'e10adc3949ba59abbe56e057f20f883e', 'root@123456.com', '1102222', '2', '0', '1500825600', '1500825600');

-- --------------------------------
-- 空间表
-- --------------------------------
DROP TABLE IF EXISTS `mw_space`;
CREATE TABLE `mw_space` (
  `space_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '空间 id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '描述',
  `visit_level` enum('private','internal','public') NOT NULL DEFAULT 'internal' COMMENT '访问级别：private,internal,public',
  `is_delete` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`space_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='空间表';

-- --------------------------------
-- 空间标签表
-- --------------------------------
DROP TABLE IF EXISTS `mw_space_tag`;
CREATE TABLE `mw_space_tag` (
  `space_tag_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '空间标签关系 id',
  `space_id` int(11) unsigned NOT NULL  COMMENT '空间 id',
  `tag` char(10) NOT NULL DEFAULT '' COMMENT '标签名称',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`space_tag_id`),
  KEY (`space_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='空间标签表';

-- --------------------------------
-- 文档表
-- --------------------------------
DROP TABLE IF EXISTS `mw_page`;
CREATE TABLE `mw_page` (
  `page_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '文档 id',
  `parent_id` int(10) NOT NULL DEFAULT '0' COMMENT '文档父 id',
  `space_id` int(10) NOT NULL DEFAULT '0' COMMENT '空间id',
  `title` varchar(150) NOT NULL DEFAULT '' COMMENT '文档标题',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '文档类型 1 页面 2 目录',
  `path` varchar(100) NOT NULL DEFAULT '' COMMENT 'markdown 文件路径',
  `create_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '创建用户 id',
  `edit_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '最后修改用户 id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`page_id`),
  KEY (`parent_id`),
  KEY (`space_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文档表';

-- --------------------------------
-- 用户空间关系表
-- --------------------------------
DROP TABLE IF EXISTS `mw_user_space`;
CREATE TABLE `mw_user_space` (
  `user_space_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户空间关系 id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `space_id` int(10) NOT NULL DEFAULT '0' COMMENT '项目 id',
  `privilege` tinyint(3) NOT NULL DEFAULT '0' COMMENT '用户空间访问权限 0 浏览者 1 编辑者 2 管理员',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`user_space_id`),
  UNIQUE KEY (`user_id`, `space_id`),
  KEY (`user_id`),
  KEY (`space_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户空间关系表';

-- --------------------------------
-- 用户收藏表
-- --------------------------------
DROP TABLE IF EXISTS `mw_collection`;
CREATE TABLE `mw_collection` (
  `collection_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户收藏关系 id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '收藏类型 1 文档 2 空间',
  `resource_id` int(10) NOT NULL DEFAULT '0' COMMENT '收藏资源 id ',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`collection_id`),
  KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- --------------------------------
-- 用户关注表
-- --------------------------------
DROP TABLE IF EXISTS `mw_follow`;
CREATE TABLE `mw_follow` (
  `follow_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '关注 id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `follow_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '被关注用户 id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`follow_id`),
  KEY (`user_id`),
  KEY (`follow_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户关注表';

-- --------------------------------
-- 文档日志表
-- --------------------------------
DROP TABLE IF EXISTS `mw_log_page`;
CREATE TABLE `mw_log_page` (
  `log_page_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '文档日志 id',
  `page_id` int(10) NOT NULL DEFAULT '0' COMMENT '文档id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `action` tinyint(3) NOT NULL DEFAULT '1' COMMENT '动作 1 增加 2 修改 3 删除',
  `comment` varchar(255) NOT NULL DEFAULT '' COMMENT '备注信息',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`log_page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文档日志表';

-- --------------------------------
-- 系统操作日志表
-- --------------------------------
DROP TABLE IF EXISTS `mw_log`;
CREATE TABLE `mw_log` (
  `log_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '系统操作日志 id',
  `level` tinyint(3) NOT NULL DEFAULT '6' COMMENT '日志级别',
  `controller` char(100) NOT NULL DEFAULT '' COMMENT '控制器',
  `action` char(100) NOT NULL DEFAULT '' COMMENT '动作',
  `get` text NOT NULL COMMENT 'get参数',
  `post` text NOT NULL COMMENT 'post参数',
  `message` varchar(255) NOT NULL DEFAULT '' COMMENT '信息',
  `ip` char(100) NOT NULL DEFAULT '' COMMENT 'ip地址',
  `user_agent` char(200) NOT NULL DEFAULT '' COMMENT '用户代理',
  `referer` char(100) NOT NULL DEFAULT '' COMMENT 'referer',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `username` char(100) NOT NULL DEFAULT '' COMMENT '用户名',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统操作日志表';

-- --------------------------------
-- 系统联系人表
-- --------------------------------
DROP TABLE IF EXISTS `mw_contact`;
CREATE TABLE `mw_contact` (
  `contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '联系人 id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '联系人名称',
  `telephone` char(13) NOT NULL DEFAULT '' COMMENT '联系人座机电话',
  `mobile` char(13) NOT NULL DEFAULT '' COMMENT '联系人手机',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `position` varchar(100) NOT NULL DEFAULT '' COMMENT '联系人职位',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='联系人表';