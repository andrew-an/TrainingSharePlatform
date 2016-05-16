/*
SQLyog Ultimate v12.08 (32 bit)
MySQL - 5.6.24-log : Database - trainshare
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`trainshare` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `trainshare`;

/*Table structure for table `activity` */

DROP TABLE IF EXISTS `activity`;

CREATE TABLE `activity` (
  `Id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) DEFAULT NULL,
  `Details` varchar(200) DEFAULT NULL,
  `MembersId` int(10) DEFAULT NULL,
  `MeetingRoomId` varchar(10) DEFAULT NULL,
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `CompleteFlag` varchar(2) DEFAULT '0',
  `Remark` varchar(20) DEFAULT NULL,
  `RecordTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `activity` */

insert  into `activity`(`Id`,`Title`,`Details`,`MembersId`,`MeetingRoomId`,`StartTime`,`EndTime`,`CompleteFlag`,`Remark`,`RecordTime`) values (1,'Wearable 第一季度内部培训分享会','123',1,'1','2016-05-12 08:44:49','2016-05-12 12:44:55','1',NULL,'2016-05-12 08:45:14'),(2,'Wearable 第二季度内部培训分享会','456',1,'1','2016-05-12 08:44:49','2016-05-12 12:44:55','0',NULL,'2016-05-13 10:16:25'),(3,'123','123',1,'4','2016-05-14 00:00:00','2016-05-24 00:00:00','0','','2016-05-14 09:33:38'),(4,'456','456',1,'4','2016-05-14 00:00:00','2016-05-24 00:00:00','0','','2016-05-14 09:56:15');

/*Table structure for table `activitycontent` */

DROP TABLE IF EXISTS `activitycontent`;

CREATE TABLE `activitycontent` (
  `Id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `ActivityId` int(2) DEFAULT NULL,
  `MemberId` int(2) DEFAULT NULL,
  `Title` varchar(100) DEFAULT NULL,
  `FilePath` varchar(100) DEFAULT NULL,
  `UploadFlag` varchar(1) DEFAULT NULL,
  `Remark` varchar(20) DEFAULT NULL,
  `RecordTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `activitycontent` */

insert  into `activitycontent`(`Id`,`ActivityId`,`MemberId`,`Title`,`FilePath`,`UploadFlag`,`Remark`,`RecordTime`) values (1,1,1,'数据加解密',NULL,NULL,NULL,'2016-05-14 17:27:56'),(2,1,2,'NFC 智能支付',NULL,NULL,NULL,'2016-05-14 17:27:56'),(3,1,3,'123',NULL,NULL,NULL,'2016-05-14 17:28:02'),(4,1,4,'456',NULL,NULL,NULL,'2016-05-14 17:28:03');

/*Table structure for table `meetingroom` */

DROP TABLE IF EXISTS `meetingroom`;

CREATE TABLE `meetingroom` (
  `Id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `RoomName` varchar(20) DEFAULT NULL,
  `Location` varchar(20) DEFAULT NULL,
  `Remark` varchar(20) DEFAULT NULL,
  `RecordTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `meetingroom` */

insert  into `meetingroom`(`Id`,`RoomName`,`Location`,`Remark`,`RecordTime`) values (1,'A21','sixth floor',NULL,'2016-05-12 08:58:21'),(2,'A22','sixth floor',NULL,'2016-05-12 08:58:16'),(3,'A23','sixth floor',NULL,'2016-05-12 08:57:29'),(4,'A31','seventh floor',NULL,'2016-05-13 15:47:16'),(5,'A32','seventh floor',NULL,'2016-05-13 15:47:18'),(6,'A33','seventh floor',NULL,'2016-05-13 15:47:20'),(7,'Pending','Pending',NULL,'2016-05-13 15:49:19');

/*Table structure for table `members` */

DROP TABLE IF EXISTS `members`;

CREATE TABLE `members` (
  `Id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `MemberList` varchar(40) DEFAULT NULL,
  `Remark` varchar(20) DEFAULT NULL,
  `RecordTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `members` */

insert  into `members`(`Id`,`MemberList`,`Remark`,`RecordTime`) values (1,'1,2,3,4',NULL,'2016-05-14 11:11:55');

/*Table structure for table `userinfo` */

DROP TABLE IF EXISTS `userinfo`;

CREATE TABLE `userinfo` (
  `Id` int(4) NOT NULL AUTO_INCREMENT,
  `WorkNumber` varchar(20) DEFAULT NULL,
  `UserName` varchar(20) DEFAULT NULL,
  `RealName` varchar(20) DEFAULT NULL,
  `PassWord` varchar(20) DEFAULT NULL,
  `Sex` varchar(20) DEFAULT NULL,
  `Email` varchar(40) DEFAULT NULL,
  `Remark` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `userinfo` */

insert  into `userinfo`(`Id`,`WorkNumber`,`UserName`,`RealName`,`PassWord`,`Sex`,`Email`,`Remark`) values (1,'0320879','andrew','安健逞','123456','mail','andrew.an@goertek.com',''),(2,'0320878','Carl','巩元鹏','123456','mail','carl.gong@goertek.com',NULL),(3,'0320870','vigoss','王永胜','123456','mail','vigoss.wang@goertek.com',NULL),(4,'0320871','snowy','王雪梅','123456','femail','snowy.wang@goertek.com',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;