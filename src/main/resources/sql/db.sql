/**组织机构**/
CREATE TABLE `org_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL COMMENT '组织机构编码，根结点为1，其余为UUID',
  `name` varchar(50) NOT NULL COMMENT '组织机构名称',
  `parent_code` varchar(50) NOT NULL COMMENT '上层编码',
  `remark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `is_del` tinyint  NOT NULL DEFAULT 0 COMMENT '是否已删除',
  `create_time` timestamp NOT NULL DEFAULT '1980-00-00 00:00:00' COMMENT '创建时间',
  `last_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uiq_code` (`code`),
  KEY `idx_name` (`name`,`is_del`),
  KEY `idx_parent_code` (`parent_code`,`is_del`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**菜单**/
CREATE TABLE `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL COMMENT '菜单编码为UUID',
  `name` varchar(50) NOT NULL COMMENT '菜单名称',
  `path` varchar(100) NOT NULL COMMENT '菜单路径',
  `menu_type` varchar(20) NOT NULL DEFAULT 'MENU' COMMENT '菜单类型:MENU,FUNCTION',
  `parent_code` varchar(50) NOT NULL COMMENT '上层编码',
  `remark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `is_del` tinyint  NOT NULL DEFAULT 0 COMMENT '是否已删除',
  `create_time` timestamp NOT NULL DEFAULT '1980-00-00 00:00:00' COMMENT '创建时间',
  `last_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uiq_code` (`code`),
  KEY `idx_name` (`name`,`is_del`),
  KEY `idx_parent_code` (`parent_code`,`is_del`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**角色**/
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL COMMENT '角色编码为UUID',
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `priority` int NOT NULL DEFAULT 100 COMMENT '权限优先级',
  `remark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `is_del` tinyint  NOT NULL DEFAULT 0 COMMENT '是否已删除',
  `create_time` timestamp NOT NULL DEFAULT '1980-00-00 00:00:00' COMMENT '创建时间',
  `last_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uiq_code` (`code`),
  KEY `idx_name` (`name`,`is_del`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**用户**/
CREATE TABLE `user_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL COMMENT '用户编码为UUID',
  `org_code` varchar(50) NOT NULL COMMENT '组织机构编码',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `user_name` varchar(50) NOT NULL COMMENT '用户名',
  `pwd` varchar(50) NOT NULL COMMENT '密码',
  `salt` varchar(50) NOT NULL COMMENT '密码加密盐值UUID',
  `phone` varchar(50) NOT NULL COMMENT '手机号码',
  `sex` varchar(10) NOT NULL DEFAULT 'UNKNOW' COMMENT '性别:MALE,FEMALE,UNKNOW',
  `mail` varchar(50) NOT NULL COMMENT '邮箱',
  `birthday` varchar(50) NOT NULL COMMENT '生日',
  `role_code` varchar(50) NOT NULL COMMENT '角色编码',
  `role_priority` int NOT NULL DEFAULT 100 COMMENT '权限优先级',
  `remark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `is_del` tinyint  NOT NULL DEFAULT 0 COMMENT '是否已删除',
  `create_time` timestamp NOT NULL DEFAULT '1980-00-00 00:00:00' COMMENT '创建时间',
  `last_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uiq_code` (`code`),
  KEY `idx_name` (`name`,`is_del`),
  KEY `idx_user_name` (`user_name`,`is_del`),
  KEY `idx_org_code` (`org_code`,`is_del`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/**角色-菜单**/
CREATE TABLE `role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_code` varchar(50) NOT NULL COMMENT '角色编码',
  `menu_code` varchar(50) NOT NULL COMMENT '菜单编码',
  `remark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT '1980-00-00 00:00:00' COMMENT '创建时间',
  `last_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uiq_role_code` (`role_code`,`menu_code`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


insert into org_info(code,name,parent_code,remark,create_time) values ('1', '广州睿哲科技有限公司', '', '根结点', now());

