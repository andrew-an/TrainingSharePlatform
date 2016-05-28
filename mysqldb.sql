/*
SQLyog Ultimate v12.08 (32 bit)
MySQL - 5.6.24-log : Database - trainsharetest
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`trainsharetest` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `trainsharetest`;

/*Table structure for table `activity` */

DROP TABLE IF EXISTS `activity`;

CREATE TABLE `activity` (
  `Id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) DEFAULT NULL,
  `Details` varchar(200) DEFAULT NULL,
  `MembersId` int(10) DEFAULT NULL,
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `CompleteFlag` varchar(2) DEFAULT '0',
  `Remark` varchar(20) DEFAULT NULL,
  `RecordTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `activity` */

/*Table structure for table `activitycontent` */

DROP TABLE IF EXISTS `activitycontent`;

CREATE TABLE `activitycontent` (
  `Id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `MembersId` int(2) DEFAULT NULL,
  `MemberId` int(2) DEFAULT NULL,
  `Title` varchar(1000) DEFAULT NULL,
  `MeetingRoomId` int(2) DEFAULT NULL,
  `StartTime` datetime DEFAULT NULL,
  `FilePath` varchar(100) DEFAULT NULL,
  `UploadFlag` varchar(1) DEFAULT '0',
  `DeleteFlag` varchar(1) DEFAULT '0',
  `Remark` varchar(20) DEFAULT NULL,
  `RecordTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `activitycontent` */

/*Table structure for table `meetingroom` */

DROP TABLE IF EXISTS `meetingroom`;

CREATE TABLE `meetingroom` (
  `Id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `RoomName` varchar(20) DEFAULT NULL,
  `Location` varchar(20) DEFAULT NULL,
  `Remark` varchar(20) DEFAULT NULL,
  `RecordTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `meetingroom` */

insert  into `meetingroom`(`Id`,`RoomName`,`Location`,`Remark`,`RecordTime`) values (1,'A21','sixth floor',NULL,'2016-05-12 08:58:21'),(2,'A22','sixth floor',NULL,'2016-05-12 08:58:16'),(3,'A23','sixth floor',NULL,'2016-05-12 08:57:29'),(4,'A31','seventh floor',NULL,'2016-05-13 15:47:16'),(5,'A32','seventh floor',NULL,'2016-05-13 15:47:18'),(6,'A33','seventh floor',NULL,'2016-05-13 15:47:20'),(7,'小会议室','small',NULL,'2016-05-13 15:49:19'),(8,'待定','Pending',NULL,'2016-05-26 08:50:39');

/*Table structure for table `members` */

DROP TABLE IF EXISTS `members`;

CREATE TABLE `members` (
  `Id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `MemberList` varchar(200) DEFAULT NULL,
  `Remark` varchar(20) DEFAULT NULL,
  `RecordTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `members` */

/*Table structure for table `userinfo` */

DROP TABLE IF EXISTS `userinfo`;

CREATE TABLE `userinfo` (
  `Id` int(4) NOT NULL AUTO_INCREMENT,
  `WorkNumber` varchar(20) DEFAULT NULL,
  `UserName` varchar(20) DEFAULT NULL,
  `RealName` varchar(20) DEFAULT NULL,
  `PassWord` varchar(32) DEFAULT NULL,
  `Sex` varchar(20) DEFAULT NULL,
  `Email` varchar(40) DEFAULT NULL,
  `AdministratorFlag` varchar(2) DEFAULT '0',
  `Remark` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*Data for the table `userinfo` */

insert  into `userinfo`(`Id`,`WorkNumber`,`UserName`,`RealName`,`PassWord`,`Sex`,`Email`,`AdministratorFlag`,`Remark`) values (1,NULL,'andrew.an','安健逞','E10ADC3949BA59ABBE56E057F20F883E','mail','andrew.an@goertek.com','1',''),(2,NULL,'Carl.gong','巩元鹏','E10ADC3949BA59ABBE56E057F20F883E','mail','carl.gong@goertek.com','0',NULL),(3,NULL,'vigoss.wang','王永胜','E10ADC3949BA59ABBE56E057F20F883E','mail','vigoss.wang@goertek.com','1',NULL),(4,NULL,'snowy.wang','王雪梅','E10ADC3949BA59ABBE56E057F20F883E','femail','snowy.wang@goertek.com','0',NULL),(5,NULL,'nora.zhang','张金金','E10ADC3949BA59ABBE56E057F20F883E','femail',NULL,'0',NULL),(6,NULL,'sasa.yao','姚艳红','E10ADC3949BA59ABBE56E057F20F883E','femail',NULL,'0',NULL),(7,NULL,'wheeler.hu','胡明辉','E10ADC3949BA59ABBE56E057F20F883E','mail',NULL,'0',NULL),(8,NULL,'bruce.yin','尹光明','E10ADC3949BA59ABBE56E057F20F883E','mail',NULL,'0',NULL),(9,NULL,'ryan.wu','武少城','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(10,NULL,'devon.liu','刘明月','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(11,NULL,'wilson.qin','秦振华','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(12,NULL,'tiger.yue','岳公和','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(13,NULL,'reya.jiang','江耿红','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(14,NULL,'donna.zang','藏英','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(15,NULL,'kent.han','韩振鹏','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(16,NULL,'suise.su','苏春玲','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(17,NULL,'larenia.zhang','张璐伟','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(18,NULL,'reuben.liu','刘恒','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(19,NULL,'samuel.li','李小康','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(20,NULL,'riva.xuan','宣月倩','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(21,NULL,'orange.xue','薛俊晓','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(22,NULL,'evin.wang','王琳琳','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(23,NULL,'alan.wang','王林新','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(24,NULL,'lambert.liu','刘言','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(25,NULL,'christ.zhang','张欣欣','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(26,NULL,'lynn.li','李亮','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(27,NULL,'nate.fu','付辉','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL),(28,NULL,'auron.yang','杨岐龙','E10ADC3949BA59ABBE56E057F20F883E',NULL,NULL,'0',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
