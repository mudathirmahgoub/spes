-- The same tables as schemas/calcite.sql, written the way mysqldump writes them.
--   mvn exec:exec -Dschema=schemas/mysql_example.sql -Ddialect=mysql ...
--
-- What this file is here to show: back-quoted identifiers keep their case and are matched
-- ignoring it, so emp, EMP and Emp all reach the same table; display widths such as int(11)
-- are read and discarded, because the solver has no fixed-width integers; and the dump's own
-- noise -- /*!40101 ... */ blocks, DROP TABLE, ENGINE and CHARSET trailers, non-unique KEY
-- lines -- is skipped. UNIQUE KEY is not skipped: like PRIMARY KEY it states a key.

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;

DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept` (
  `deptno` int(11) NOT NULL,
  `name`   varchar(10) DEFAULT NULL,
  PRIMARY KEY (`deptno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp` (
  `empno`    int(11) NOT NULL AUTO_INCREMENT,
  `ename`    varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `job`      varchar(10) DEFAULT NULL,
  `mgr`      int(11) DEFAULT NULL,
  `hiredate` int(11) DEFAULT NULL,
  `comm`     int(11) DEFAULT NULL,
  `sal`      int(11) DEFAULT NULL,
  `deptno`   int(11) DEFAULT NULL,
  `slacker`  tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`empno`),
  KEY `emp_deptno_idx` (`deptno`),
  CONSTRAINT `emp_deptno_fk` FOREIGN KEY (`deptno`) REFERENCES `dept` (`deptno`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `bonus`;
CREATE TABLE `bonus` (
  `ename` varchar(20) NOT NULL,
  `job`   varchar(10) NOT NULL,
  `sal`   int(11) DEFAULT NULL,
  `comm`  int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `acctno`  int(11) NOT NULL,
  `type`    varchar(20) DEFAULT NULL,
  `balance` varchar(20) DEFAULT NULL,
  UNIQUE KEY `account_acctno_uq` (`acctno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `t`;
CREATE TABLE `t` (
  `k0`    varchar(20) NOT NULL,
  `c1`    varchar(20) DEFAULT NULL,
  `f1_a0` int(11) NOT NULL,
  `f2_a0` tinyint(4) NOT NULL,
  `f0_c0` int(11) NOT NULL,
  `f1_c0` int(11) DEFAULT NULL,
  `f0_c1` int(11) NOT NULL,
  `f1_c2` int(11) NOT NULL,
  `f2_c3` int(11) NOT NULL,
  PRIMARY KEY (`k0`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `anon`;
CREATE TABLE `anon` (
  `c` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
