/*
Navicat MySQL Data Transfer

Source Server         : 虚拟机
Source Server Version : 50729
Source Host           : 192.168.1.100:3306
Source Database       : guangzhou_scenic

Target Server Type    : MYSQL
Target Server Version : 50729
File Encoding         : 65001

Date: 2020-02-17 01:46:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '用户名',
  `number` varchar(16) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '电话',
  `password` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '密码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', '管理员', 'admin@qq.com', 'e10adc3949ba59abbe56e057f20f883e', '2019-12-11 12:05:16');

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `scenic_id` int(11) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL COMMENT '内容简介',
  `content` text COMMENT '内容',
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', '啊啊啊', '11', '5', '啊啊', '啊啊', '2020-02-16 13:21:54');
INSERT INTO `article` VALUES ('2', 'cessa', '11', '5', '', '<img src=\"/static/upload/2020Feb162231334098.jpeg\" alt=\"2020Feb162231334098.jpeg\">', '2020-02-16 15:15:39');
INSERT INTO `article` VALUES ('3', 'nnnnn', '11', '5', 'hhhhhh', 'hhhhhh', '2020-02-16 15:15:37');
INSERT INTO `article` VALUES ('4', 'sdasdasda', '11', '5', 'asasdasda', 'asasdasda', '2020-02-16 15:15:40');
INSERT INTO `article` VALUES ('5', '1111', '11', '5', '1111', '1111', '2020-02-16 15:15:36');
INSERT INTO `article` VALUES ('6', '1111', '11', '5', '1111111', '1111111', '2020-02-16 22:43:31');

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can view log entry', '1', 'view_logentry');
INSERT INTO `auth_permission` VALUES ('5', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can view permission', '2', 'view_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('11', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('12', 'Can view group', '3', 'view_group');
INSERT INTO `auth_permission` VALUES ('13', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('14', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('16', 'Can view user', '4', 'view_user');
INSERT INTO `auth_permission` VALUES ('17', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('18', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('19', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('20', 'Can view content type', '5', 'view_contenttype');
INSERT INTO `auth_permission` VALUES ('21', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('22', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('23', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('24', 'Can view session', '6', 'view_session');
INSERT INTO `auth_permission` VALUES ('25', 'Can add admin', '7', 'add_admin');
INSERT INTO `auth_permission` VALUES ('26', 'Can change admin', '7', 'change_admin');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete admin', '7', 'delete_admin');
INSERT INTO `auth_permission` VALUES ('28', 'Can view admin', '7', 'view_admin');
INSERT INTO `auth_permission` VALUES ('29', 'Can add user', '8', 'add_user');
INSERT INTO `auth_permission` VALUES ('30', 'Can change user', '8', 'change_user');
INSERT INTO `auth_permission` VALUES ('31', 'Can delete user', '8', 'delete_user');
INSERT INTO `auth_permission` VALUES ('32', 'Can view user', '8', 'view_user');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('7', 'manage', 'admin');
INSERT INTO `django_content_type` VALUES ('8', 'manage', 'user');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2020-02-14 21:01:59.529255');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2020-02-14 21:01:59.863524');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2020-02-14 21:02:00.881392');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2020-02-14 21:02:01.061308');
INSERT INTO `django_migrations` VALUES ('5', 'admin', '0003_logentry_add_action_flag_choices', '2020-02-14 21:02:01.069120');
INSERT INTO `django_migrations` VALUES ('6', 'contenttypes', '0002_remove_content_type_name', '2020-02-14 21:02:01.240079');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0002_alter_permission_name_max_length', '2020-02-14 21:02:01.368015');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0003_alter_user_email_max_length', '2020-02-14 21:02:01.391453');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0004_alter_user_username_opts', '2020-02-14 21:02:01.404148');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0005_alter_user_last_login_null', '2020-02-14 21:02:01.485461');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0006_require_contenttypes_0002', '2020-02-14 21:02:01.487415');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0007_alter_validators_add_error_messages', '2020-02-14 21:02:01.495227');
INSERT INTO `django_migrations` VALUES ('13', 'auth', '0008_alter_user_username_max_length', '2020-02-14 21:02:01.609996');
INSERT INTO `django_migrations` VALUES ('14', 'auth', '0009_alter_user_last_name_max_length', '2020-02-14 21:02:01.698866');
INSERT INTO `django_migrations` VALUES ('15', 'auth', '0010_alter_group_name_max_length', '2020-02-14 21:02:01.716444');
INSERT INTO `django_migrations` VALUES ('16', 'auth', '0011_update_proxy_permissions', '2020-02-14 21:02:01.733046');
INSERT INTO `django_migrations` VALUES ('17', 'sessions', '0001_initial', '2020-02-14 21:02:01.775040');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('v5i4g8q5gjehaqd4vhpgkts4ptdus2b4', 'MTg0MzYwNGIwM2QyMjJhYTU0ZDQyOGJiYWUyMTUyM2QwOWVhZWRkNjqABJVGAQAAAAAAAH2UjAR1c2VylIwVZGphbmdvLmRiLm1vZGVscy5iYXNllIwObW9kZWxfdW5waWNrbGWUk5SMBm1hbmFnZZSMBFVzZXKUhpSFlFKUfZQojAZfc3RhdGWUaAKMCk1vZGVsU3RhdGWUk5QpgZR9lCiMBmFkZGluZ5SJjAJkYpSMB2RlZmF1bHSUdWKMAmlklEsLjARuYW1llIwI55So5oi3MDGUjAZudW1iZXKUjAMxMDCUjAhwYXNzd29yZJSMIGUxMGFkYzM5NDliYTU5YWJiZTU2ZTA1N2YyMGY4ODNllIwLY3JlYXRlX3RpbWWUjAhkYXRldGltZZSMCGRhdGV0aW1llJOUQwoH5AIQARE6AAAAlIwEcHl0epSMBF9VVEOUk5QpUpSGlFKUjA9fZGphbmdvX3ZlcnNpb26UjAUzLjAuM5R1YnMu', '2020-03-01 14:31:04.175716');
INSERT INTO `django_session` VALUES ('z03jk5efyn8d7asf1dae57wt6lzqk4a4', 'MWVkOGY2NWNiODcyYzkyNTUwMmIxNDlkMjU4OTRmMTRkMDg2YTcwOTqABJUoAgAAAAAAAH2UKIwFYWRtaW6UjBVkamFuZ28uZGIubW9kZWxzLmJhc2WUjA5tb2RlbF91bnBpY2tsZZSTlIwGbWFuYWdllIwFQWRtaW6UhpSFlFKUfZQojAZfc3RhdGWUaAKMCk1vZGVsU3RhdGWUk5QpgZR9lCiMBmFkZGluZ5SJjAJkYpSMB2RlZmF1bHSUdWKMAmlklEsBjARuYW1llIwJ566h55CG5ZGYlIwGbnVtYmVylIwMYWRtaW5AcXEuY29tlIwIcGFzc3dvcmSUjCBlMTBhZGMzOTQ5YmE1OWFiYmU1NmUwNTdmMjBmODgzZZSMC2NyZWF0ZV90aW1llIwIZGF0ZXRpbWWUjAhkYXRldGltZZSTlEMKB+MMCwwFEAAAAJSMBHB5dHqUjARfVVRDlJOUKVKUhpRSlIwPX2RqYW5nb192ZXJzaW9ulIwFMy4wLjOUdWKMBHVzZXKUaARoBYwEVXNlcpSGlIWUUpR9lCiMBl9zdGF0ZZRoDSmBlH2UKGgQiWgRjAdkZWZhdWx0lHVijAJpZJRLC4wEbmFtZZSMC+eUqOaItzAwMDIylIwGbnVtYmVylIwDMTAwlIwIcGFzc3dvcmSUjCAyMDJjYjk2MmFjNTkwNzViOTY0YjA3MTUyZDIzNGI3MJSMC2NyZWF0ZV90aW1llGgdQwoH5AIQARE6AAAAlGgihpRSlIwPX2RqYW5nb192ZXJzaW9ulIwFMy4wLjOUdWJ1Lg==', '2020-03-01 17:13:45.083262');

-- ----------------------------
-- Table structure for scenic
-- ----------------------------
DROP TABLE IF EXISTS `scenic`;
CREATE TABLE `scenic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `img` varchar(255) DEFAULT '/static/images/default.jpeg',
  `intro` varchar(255) DEFAULT NULL COMMENT '介绍',
  `content` text,
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `ticket_price` varchar(100) DEFAULT NULL COMMENT '门票价格',
  `open_time` varchar(100) DEFAULT NULL,
  `is_hot` varchar(1) DEFAULT NULL COMMENT '是否是热门景点',
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of scenic
-- ----------------------------
INSERT INTO `scenic` VALUES ('5', '沙面岛', 'http://p1-q.mafengwo.net/s12/M00/F2/5C/wKgED1u9Q_mAfRCTABILOHc5EPc99.jpeg?imageMogr2%2Fthumbnail%2F%21690x370r%2Fgravity%2FCenter%2Fcrop%2F%21690x370%2Fquality%2F100', '广州租界最后的“世外桃源”', '<div class=\"row row-picture row-bg\"><div class=\"wrapper\"><a class=\"photo\" data-cs-p=\"相册\" href=\"http://www.mafengwo.cn/photo/poi/443.html\" target=\"_blank\"><div class=\"bd\"><div class=\"pic-big\"><img src=\"http://p1-q.mafengwo.net/s12/M00/F2/5C/wKgED1u9Q_mAfRCTABILOHc5EPc99.jpeg?imageMogr2%2Fthumbnail%2F%21690x370r%2Fgravity%2FCenter%2Fcrop%2F%21690x370%2Fquality%2F100\" width=\"690\" height=\"370\"></div><div class=\"pic-small\"><br></div></div></a></div></div><div class=\"mod mod-detail\" data-cs-p=\"概况\"><div class=\"summary\">·沙面是广州重要商埠，历经百年，在宋元明清时期为国内外通商要津，鸦片战争后沦为英、法租界。<br>·我国近代史与租界史的缩影，岛上欧陆风情建筑形成了独特的露天建筑“博物馆”。<br>·露德天主教圣母堂、沙面基督堂、海关馆舍、英国雪厂、汇丰银行等建筑都独具特色。<br>·岛上有如欧洲小镇，咖啡馆、教堂、餐厅以及酒吧出片率都很高，到这里拍照是个不错的选</div></div>', '可在广州火车站总站坐823路（坐11站）到市中医院站下，走约110米到沙面岛。', '免费', '全天', '', '2020-02-16 11:03:04');
INSERT INTO `scenic` VALUES ('6', '广州塔', 'http://p1-q.mafengwo.net/s12/M00/F2/5C/wKgED1u9Q_mAfRCTABILOHc5EPc99.jpeg?imageMogr2%2Fthumbnail%2F%21690x370r%2Fgravity%2FCenter%2Fcrop%2F%21690x370%2Fquality%2F100', '中国国内第一高塔，不仅有着变换的色彩，还可展现出动人的空中交响乐', '<div class=\"row row-picture row-bg\"><div class=\"wrapper\"><a class=\"photo\" data-cs-p=\"相册\" href=\"http://www.mafengwo.cn/photo/poi/443.html\" target=\"_blank\"><div class=\"bd\"><div class=\"pic-big\"><img src=\"http://p1-q.mafengwo.net/s12/M00/F2/5C/wKgED1u9Q_mAfRCTABILOHc5EPc99.jpeg?imageMogr2%2Fthumbnail%2F%21690x370r%2Fgravity%2FCenter%2Fcrop%2F%21690x370%2Fquality%2F100\" width=\"690\" height=\"370\"></div><div class=\"pic-small\"><br></div></div></a></div></div><div class=\"mod mod-detail\" data-cs-p=\"概况\"><div class=\"summary\">·沙面是广州重要商埠，历经百年，在宋元明清时期为国内外通商要津，鸦片战争后沦为英、法租界。<br>·我国近代史与租界史的缩影，岛上欧陆风情建筑形成了独特的露天建筑“博物馆”。<br>·露德天主教圣母堂、沙面基督堂、海关馆舍、英国雪厂、汇丰银行等建筑都独具特色。<br>·岛上有如欧洲小镇，咖啡馆、教堂、餐厅以及酒吧出片率都很高，到这里拍照是个不错的选</div></div>', '地铁:乘坐APM线或者3号线至广州塔地铁站，步行即可到达；', '433米白云星空观光票:成人150人民币；', '09:30-22:30', '', '2020-02-16 11:03:05');
INSERT INTO `scenic` VALUES ('7', '陈家祠', '/static/images/default.jpeg', '在此能感受建筑的精美，家族的兴衰，感受历史的传承', '<div class=\"row row-picture row-bg\"><div class=\"wrapper\"><div class=\"bd\"><p><a class=\"photo\" data-cs-p=\"相册\" href=\"http://www.mafengwo.cn/photo/poi/443.html\" target=\"_blank\">1</a>11111</p><div class=\"item clearfix\"><div class=\"info\"><div class=\"middle\"><p>粤名山之一，广州有名的踏青胜地</p><div class=\"links\">这里还包含景点：&nbsp;<a href=\"http://www.mafengwo.cn/poi/5176874.html\" target=\"_blank\">麓湖公园</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/25082.html\" target=\"_blank\">摩星岭</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/5145291.html\" target=\"_blank\">云溪生态公园</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/25137.html\" target=\"_blank\">桃花涧</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/25081.html\" target=\"_blank\">山顶公园</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/77855.html\" target=\"_blank\">云台花园</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/8291485.html\" target=\"_blank\">能仁寺</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/5185890.html\" target=\"_blank\">天南第一峰</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/33590612.html\" target=\"_blank\">广州碑林</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/33590616.html\" target=\"_blank\">鸣春谷</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/29749454.html\" target=\"_blank\">明珠楼</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/5185901.html\" target=\"_blank\">九龙泉</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34859392.html\" target=\"_blank\">祈福亭</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34859400.html\" target=\"_blank\">连理亭</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34859408.html\" target=\"_blank\">三人舞姬雕像</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34859416.html\" target=\"_blank\">跃云</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34859424.html\" target=\"_blank\">六祖殿</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34859440.html\" target=\"_blank\">赏蝶轩</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34859444.html\" target=\"_blank\">叠水园</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34859452.html\" target=\"_blank\">生态木栈道</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34859456.html\" target=\"_blank\">天王殿(云山南路)</a></div></div></div><div class=\"pic\"><a href=\"http://www.mafengwo.cn/poi/466.html\" target=\"_blank\" title=\"白云山\"><div class=\"large\"><img src=\"http://n1-q.mafengwo.net/s9/M00/5C/74/wKgBs1fdS6mAfFqfABMX8ozIyrs82.jpeg?imageMogr2%2Fthumbnail%2F%21380x270r%2Fgravity%2FCenter%2Fcrop%2F%21380x270%2Fquality%2F100\" width=\"380\" height=\"270\"></div><div><img src=\"http://p1-q.mafengwo.net/s10/M00/69/83/wKgBZ1nXdhuAYxjAAAu_dfzu4oI78.jpeg?imageMogr2%2Fthumbnail%2F%21185x130r%2Fgravity%2FCenter%2Fcrop%2F%21185x130%2Fquality%2F100\" width=\"185\" height=\"130\"></div><div><img src=\"http://p1-q.mafengwo.net/s12/M00/C0/24/wKgED1utsfiAFugAAC6A9ug-v1g78.jpeg?imageMogr2%2Fthumbnail%2F%21185x130r%2Fgravity%2FCenter%2Fcrop%2F%21185x130%2Fquality%2F100\" width=\"185\" height=\"130\"></div></a></div></div><div class=\"item clearfix\"><div class=\"info\"><div class=\"middle\"><h3><span class=\"num\" style=\"text-align: center;\">5</span><a href=\"http://www.mafengwo.cn/poi/441.html\" target=\"_blank\" title=\"越秀公园\">越秀公园</a><a href=\"http://www.mafengwo.cn/poi/441.html\" target=\"_blank\" title=\"越秀公园\"><span class=\"rev-total\">1907&nbsp;条点评</span></a></h3><p>羊城八景之一，内有“五羊石雕”</p><div class=\"links\">这里还包含景点：&nbsp;<a href=\"http://www.mafengwo.cn/poi/28333.html\" target=\"_blank\">五羊石像</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/26425.html\" target=\"_blank\">孙中山纪念碑</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/33591540.html\" target=\"_blank\">四方炮台遗址</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/28335.html\" target=\"_blank\">广州博物馆</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/442.html\" target=\"_blank\">镇海楼</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/33589816.html\" target=\"_blank\">明代古城墙</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/5433700.html\" target=\"_blank\">广州美术馆</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860352.html\" target=\"_blank\">明绍武君臣冢</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860368.html\" target=\"_blank\">伍廷芳墓</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860376.html\" target=\"_blank\">观音山战斗遗址</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860384.html\" target=\"_blank\">西汉南越国人字顶分室大墓</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860404.html\" target=\"_blank\">夕阳红广场</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860412.html\" target=\"_blank\">海东京畿园</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860424.html\" target=\"_blank\">毓秀灵瀑</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860444.html\" target=\"_blank\">成语寓言园</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860448.html\" target=\"_blank\">越秀公园-光复纪念亭</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860456.html\" target=\"_blank\">南秀湖</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/33591648.html\" target=\"_blank\">海员亭</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860468.html\" target=\"_blank\">小鹿广场</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860472.html\" target=\"_blank\">古之楚庭石牌坊</a>&nbsp;<a href=\"http://www.mafengwo.cn/poi/34860480.html\" target=\"_blank\">竹林景区</a></div></div></div></div></div></div></div>', '地铁1号线在陈家祠站下车即到', '普通票:10人民币 (1月1日-12月31日 周一-周日)', '08:30-17:30 (1月1日-12月31日 周一-周日)', '', '2020-02-16 11:03:06');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '用户名',
  `number` varchar(16) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '电话',
  `password` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '密码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('11', '用户00022', '100', '202cb962ac59075b964b07152d234b70', '2020-02-16 01:17:58');
INSERT INTO `user` VALUES ('12', '测试001', '200', 'e10adc3949ba59abbe56e057f20f883e', '2020-02-17 00:52:44');
