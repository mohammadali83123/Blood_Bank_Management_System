-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 10, 2024 at 09:49 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `AID` int(11) NOT NULL,
  `Name` varchar(225) DEFAULT NULL,
  `Password` varchar(225) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`AID`, `Name`, `Password`) VALUES
(1, 'Ali', 'ali123'),
(2, 'Taqi', 'taqi123'),
(3, 'Saad', 'Saad123'),
(4, 'Shoaib Raza', 'shoaib123');

-- --------------------------------------------------------

--
-- Table structure for table `deleted_donor`
--

CREATE TABLE `deleted_donor` (
  `DD_ID` int(11) NOT NULL,
  `DID` int(11) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Phone` bigint(20) NOT NULL,
  `Age` int(11) NOT NULL,
  `Period` varchar(10) NOT NULL,
  `Ques1` varchar(10) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Disease` varchar(200) NOT NULL,
  `Blood` varchar(10) NOT NULL,
  `Curr_Date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deleted_donor`
--

INSERT INTO `deleted_donor` (`DD_ID`, `DID`, `Name`, `Phone`, `Age`, `Period`, `Ques1`, `Gender`, `Disease`, `Blood`, `Curr_Date`) VALUES
(16, 18, 'Ali', 3055383123, 20, 'no', 'yes', 'Male', 'no', 'A+', '2023-12-07 09:01:00'),
(17, 26, 'Yehya', 3055383123, 18, 'no', 'yes', 'Male', 'no', 'O+', '2023-12-07 09:26:40'),
(18, 23, 'Owais', 3043383648, 22, 'no', 'yes', 'Male', 'no', 'AB-', '2023-12-07 09:24:38'),
(19, 21, 'Hamza', 3043383648, 19, 'no', 'yes', 'Male', 'no', 'A-', '2023-12-07 09:23:47'),
(24, 15, 'Saad', 3055383123, 18, 'no', 'yes', 'Male', 'no', 'A+', '2023-12-07 08:38:04');

--
-- Triggers `deleted_donor`
--
DELIMITER $$
CREATE TRIGGER `insert_deleted_donor_log_trigger` AFTER DELETE ON `deleted_donor` FOR EACH ROW delete from donor_logs where DID = old.DID
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_deleted_donor_trigger` AFTER DELETE ON `deleted_donor` FOR EACH ROW INSERT into donor VALUES(null,old.Name,old.Phone,old.Age,old.Period,old.Ques1,old.Gender,old.Disease,old.Blood,Now())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `deleted_recipient`
--

CREATE TABLE `deleted_recipient` (
  `DR_ID` int(11) NOT NULL,
  `RID` int(11) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Phone` bigint(20) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Reason` varchar(10) NOT NULL,
  `Blood` varchar(10) NOT NULL,
  `Curr_Date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deleted_recipient`
--

INSERT INTO `deleted_recipient` (`DR_ID`, `RID`, `Name`, `Phone`, `Gender`, `Reason`, `Blood`, `Curr_Date`) VALUES
(96, 102, 'Saad', 3055383123, 'Male', 'other', 'A+', '2023-12-07 09:00:16'),
(101, 97, 'taqi', 3055383123, 'Male', 'None', 'A+', '2023-12-07 08:38:16');

--
-- Triggers `deleted_recipient`
--
DELIMITER $$
CREATE TRIGGER `insert_deleted_recipient_log_trigger` AFTER DELETE ON `deleted_recipient` FOR EACH ROW delete from recipient_logs where RID = old.RID
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_deleted_recipient_trigger` AFTER DELETE ON `deleted_recipient` FOR EACH ROW INSERT INTO recipient VALUES(null,old.Name,old.Phone,old.Gender,old.Reason,old.Blood,Now())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `donor`
--

CREATE TABLE `donor` (
  `DID` int(11) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Phone` bigint(20) NOT NULL,
  `Age` int(11) NOT NULL,
  `Period` varchar(10) NOT NULL,
  `Ques1` varchar(10) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Disease` varchar(200) NOT NULL,
  `Blood` varchar(10) NOT NULL,
  `Curr_Date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `donor`
--

INSERT INTO `donor` (`DID`, `Name`, `Phone`, `Age`, `Period`, `Ques1`, `Gender`, `Disease`, `Blood`, `Curr_Date`) VALUES
(16, 'Taqi', 3055383123, 20, 'no', 'yes', 'Male', 'no', 'O+', '2023-12-07 08:39:58'),
(19, 'Talal', 3055383123, 21, 'no', 'no', 'Male', 'no', 'B+', '2023-12-07 09:22:58'),
(20, 'Babar', 3043383648, 22, 'no', 'yes', 'Male', 'no', 'AB+', '2023-12-07 09:23:23'),
(22, 'Bilal', 3043383648, 24, 'no', 'no', 'Male', 'no', 'B-', '2023-12-07 09:24:13'),
(24, 'Umer', 3043383648, 22, 'no', 'yes', 'Male', 'no', 'A-', '2023-12-07 09:25:03'),
(25, 'Sultan', 3055383123, 19, 'no', 'yes', 'Male', 'no', 'AB-', '2023-12-07 09:25:30'),
(28, 'Faraz', 3313410763, 19, 'no', 'yes', 'Male', 'no', 'O+', '2023-12-07 09:37:43'),
(30, 'Ali', 3055383123, 20, 'no', 'no', 'Male', 'no', 'A+', '2023-12-07 09:57:36'),
(32, 'Owais', 3043383648, 21, 'no', 'yes', 'Male', 'no', 'A+', '2023-12-07 10:10:55'),
(34, 'Ahmed', 122123, 18, 'no', 'yes', 'Male', 'no', 'A+', '2023-12-24 16:36:04'),
(35, 'ali', 3055383123, 18, 'no', 'yes', 'Male', 'no', 'A+', '2024-03-04 23:24:47');

--
-- Triggers `donor`
--
DELIMITER $$
CREATE TRIGGER `deleted_donor_logs_trigger` AFTER DELETE ON `donor` FOR EACH ROW INSERT INTO deleted_donor VALUES(null,old.DID,old.Name,old.Phone,old.Age,old.Period,old.Ques1,old.Gender,old.Disease,old.Blood,old.Curr_Date)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `donor_delete_trigger` AFTER DELETE ON `donor` FOR EACH ROW insert into donor_logs values (null,old.DID,'deleted',NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `donor_logs`
--

CREATE TABLE `donor_logs` (
  `DL_ID` int(11) NOT NULL,
  `DID` int(11) NOT NULL,
  `Action` varchar(20) NOT NULL,
  `Curr_Date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `donor_logs`
--

INSERT INTO `donor_logs` (`DL_ID`, `DID`, `Action`, `Curr_Date`) VALUES
(23, 18, 'deleted', '2023-12-07 09:01:49'),
(24, 26, 'deleted', '2023-12-07 09:27:39'),
(25, 23, 'deleted', '2023-12-07 09:27:43'),
(26, 21, 'deleted', '2023-12-07 09:27:52'),
(31, 15, 'deleted', '2024-03-05 00:18:01');

-- --------------------------------------------------------

--
-- Table structure for table `recipient`
--

CREATE TABLE `recipient` (
  `RID` int(11) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Phone` bigint(20) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Reason` varchar(200) NOT NULL,
  `Blood` varchar(10) NOT NULL,
  `Curr_Date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipient`
--

INSERT INTO `recipient` (`RID`, `Name`, `Phone`, `Gender`, `Reason`, `Blood`, `Curr_Date`) VALUES
(98, 'Saad', 3055383123, 'Male', 'other', 'AB+', '2023-12-07 08:40:29'),
(100, 'Zain', 3043383648, 'Male', 'other', 'O-', '2023-12-07 08:53:54'),
(103, 'Saad', 3055383123, 'Male', 'other', 'A+', '2023-12-07 09:37:06'),
(104, 'Anas', 3055383123, 'Male', 'medical re', 'AB+', '2023-12-07 09:38:07'),
(106, 'Saad', 3055383123, 'Male', 'other', 'AB+', '2023-12-07 09:57:53'),
(108, 'Bilal', 3043383648, 'Male', 'other', 'B+', '2023-12-07 10:11:14'),
(110, 'haseeb', 65566, 'Male', 'none', 'A+', '2023-12-24 16:36:18'),
(111, 'Ali', 3055383123, 'Male', 'None', 'A+', '2024-03-05 00:06:56'),
(112, 'Ali', 3055383123, 'Male', 'None', 'A+', '2024-03-05 00:08:06'),
(113, 'Ali', 3055383123, 'Male', 'None', 'A+', '2024-03-05 00:08:49'),
(114, 'Ali', 3055383123, 'Male', 'None', 'A+', '2024-03-05 00:09:50'),
(115, 'taqi', 3055383123, 'Male', 'None', 'A+', '2024-03-05 00:10:04'),
(116, 'Ali', 3055383123, 'Male', 'None', 'A+', '2024-03-05 00:13:35');

--
-- Triggers `recipient`
--
DELIMITER $$
CREATE TRIGGER `deleted_recipient_log_trigger` AFTER DELETE ON `recipient` FOR EACH ROW INSERT INTO deleted_recipient VALUES (null,old.RID,old.Name,old.Phone,old.Gender,old.Reason,old.Blood,old.Curr_Date)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `recipient_delete_trigger` AFTER DELETE ON `recipient` FOR EACH ROW INSERT INTO recipient_logs VALUES (null,old.RID,'deleted',NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `recipient_logs`
--

CREATE TABLE `recipient_logs` (
  `RL_ID` int(11) NOT NULL,
  `RID` int(11) NOT NULL,
  `Action` varchar(20) NOT NULL,
  `Curr_Date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipient_logs`
--

INSERT INTO `recipient_logs` (`RL_ID`, `RID`, `Action`, `Curr_Date`) VALUES
(144, 102, 'deleted', '2023-12-07 09:01:53'),
(149, 97, 'deleted', '2024-03-05 00:18:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AID`);

--
-- Indexes for table `deleted_donor`
--
ALTER TABLE `deleted_donor`
  ADD PRIMARY KEY (`DD_ID`);

--
-- Indexes for table `deleted_recipient`
--
ALTER TABLE `deleted_recipient`
  ADD PRIMARY KEY (`DR_ID`);

--
-- Indexes for table `donor`
--
ALTER TABLE `donor`
  ADD PRIMARY KEY (`DID`);

--
-- Indexes for table `donor_logs`
--
ALTER TABLE `donor_logs`
  ADD PRIMARY KEY (`DL_ID`);

--
-- Indexes for table `recipient`
--
ALTER TABLE `recipient`
  ADD PRIMARY KEY (`RID`);

--
-- Indexes for table `recipient_logs`
--
ALTER TABLE `recipient_logs`
  ADD PRIMARY KEY (`RL_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `AID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `deleted_donor`
--
ALTER TABLE `deleted_donor`
  MODIFY `DD_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `deleted_recipient`
--
ALTER TABLE `deleted_recipient`
  MODIFY `DR_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `donor`
--
ALTER TABLE `donor`
  MODIFY `DID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `donor_logs`
--
ALTER TABLE `donor_logs`
  MODIFY `DL_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `recipient`
--
ALTER TABLE `recipient`
  MODIFY `RID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `recipient_logs`
--
ALTER TABLE `recipient_logs`
  MODIFY `RL_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
