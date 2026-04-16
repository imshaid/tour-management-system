-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 03, 2026 at 02:43 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tourmanagementsystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `BookingID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `TourID` int(11) DEFAULT NULL,
  `BookingDate` date DEFAULT NULL,
  `BookingStatus` varchar(20) DEFAULT NULL,
  `NoOfPeople` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`BookingID`, `CustomerID`, `TourID`, `BookingDate`, `BookingStatus`, `NoOfPeople`) VALUES
(1, 22, 1, '2025-07-05', 'Confirmed', 3),
(2, 45, 21, '2025-08-25', 'Completed', 2),
(3, 8, 12, '2025-03-20', 'Confirmed', 3),
(4, 67, 2, '2025-09-01', 'Confirmed', 4),
(5, 14, 11, '2025-05-10', 'Pending', 2),
(6, 52, 16, '2025-08-15', 'Confirmed', 1),
(7, 3, 7, '2025-02-15', 'Confirmed', 3),
(8, 74, 9, '2025-10-01', 'Completed', 2),
(9, 19, 6, '2025-06-15', 'Cancelled', 2),
(10, 35, 19, '2025-07-25', 'Completed', 2),
(11, 1, 5, '2025-01-25', 'Confirmed', 2),
(12, 27, 12, '2025-07-20', 'Completed', 2),
(13, 58, 20, '2025-09-05', 'Completed', 3),
(14, 12, 2, '2025-04-18', 'Completed', 3),
(15, 41, 13, '2025-08-22', 'Completed', 2),
(16, 7, 4, '2025-03-15', 'Cancelled', 1),
(17, 80, 11, '2025-09-10', 'Completed', 3),
(18, 48, 8, '2025-08-28', 'Confirmed', 3),
(19, 25, 9, '2025-07-15', 'Pending', 2),
(20, 13, 5, '2025-04-20', 'Confirmed', 4),
(21, 63, 16, '2025-08-22', 'Confirmed', 2),
(22, 2, 3, '2025-02-10', 'Completed', 1),
(23, 39, 16, '2025-07-30', 'Cancelled', 1),
(24, 78, 3, '2025-09-15', 'Completed', 1),
(25, 10, 9, '2025-04-05', 'Confirmed', 1),
(26, 5, 10, '2025-03-05', 'Completed', 4),
(27, 17, 13, '2025-06-10', 'Confirmed', 2),
(28, 43, 25, '2025-08-23', 'Completed', 4),
(29, 71, 12, '2025-09-10', 'Confirmed', 1),
(30, 31, 7, '2025-07-20', 'Confirmed', 2),
(31, 15, 7, '2025-05-12', 'Completed', 2),
(32, 50, 23, '2025-08-30', 'Confirmed', 4),
(33, 24, 20, '2025-07-08', 'Completed', 2),
(34, 6, 8, '2025-03-12', 'Confirmed', 2),
(35, 47, 26, '2025-08-26', 'Completed', 1),
(36, 76, 22, '2025-09-12', 'Completed', 2),
(37, 21, 17, '2025-07-05', 'Completed', 2),
(38, 11, 14, '2025-04-12', 'Confirmed', 2),
(39, 55, 3, '2025-08-30', 'Confirmed', 1),
(40, 33, 10, '2025-07-20', 'Pending', 1),
(41, 69, 8, '2025-09-02', 'Confirmed', 3),
(42, 4, 1, '2025-02-25', 'Pending', 2),
(43, 29, 5, '2025-07-20', 'Confirmed', 1),
(44, 61, 15, '2025-08-20', 'Completed', 2),
(45, 16, 15, '2025-05-20', 'Confirmed', 1),
(46, 40, 2, '2025-08-25', 'Confirmed', 3),
(47, 73, 24, '2025-09-20', 'Confirmed', 2),
(48, 37, 11, '2025-08-01', 'Confirmed', 2),
(49, 23, 3, '2025-07-10', 'Confirmed', 1),
(50, 9, 6, '2025-03-25', 'Completed', 2),
(51, 53, 7, '2025-08-28', 'Confirmed', 2),
(52, 70, 17, '2025-09-08', 'Completed', 2),
(53, 12, 27, '2025-11-01', 'Confirmed', 2),
(54, 34, 18, '2025-07-20', 'Confirmed', 4),
(55, 18, 16, '2025-06-15', 'Completed', 3),
(56, 57, 11, '2025-08-15', 'Completed', 2),
(57, 65, 19, '2025-08-25', 'Confirmed', 1),
(58, 26, 8, '2025-07-15', 'Confirmed', 4),
(59, 49, 12, '2025-08-26', 'Completed', 2),
(60, 79, 5, '2025-09-12', 'Confirmed', 2),
(61, 38, 24, '2025-07-22', 'Completed', 2),
(62, 60, 24, '2025-08-22', 'Confirmed', 1),
(63, 15, 4, '2025-10-15', 'Confirmed', 1),
(64, 42, 6, '2025-08-23', 'Confirmed', 1),
(65, 75, 18, '2025-10-05', 'Confirmed', 4),
(66, 20, 18, '2025-06-25', 'Confirmed', 4),
(67, 51, 5, '2025-08-28', 'Confirmed', 2),
(68, 68, 23, '2025-09-10', 'Completed', 2),
(69, 32, 14, '2025-07-22', 'Completed', 2),
(70, 77, 14, '2025-09-12', 'Confirmed', 3),
(71, 44, 17, '2025-08-25', 'Confirmed', 3),
(72, 24, 28, '2025-12-05', 'Completed', 2),
(73, 64, 21, '2025-08-28', 'Completed', 3),
(74, 22, 8, '2025-11-15', 'Completed', 2),
(75, 36, 15, '2025-07-25', 'Confirmed', 3),
(76, 59, 6, '2025-09-01', 'Completed', 2),
(77, 66, 13, '2025-08-28', 'Completed', 2),
(78, 72, 6, '2025-09-08', 'Completed', 3),
(79, 30, 22, '2025-07-18', 'Completed', 3),
(80, 13, 5, '2025-10-05', 'Confirmed', 2),
(81, 56, 18, '2025-08-30', 'Confirmed', 3),
(82, 41, 21, '2025-11-20', 'Completed', 2),
(83, 27, 12, '2025-12-01', 'Completed', 2),
(84, 54, 20, '2025-08-29', 'Completed', 2),
(85, 63, 7, '2025-10-10', 'Completed', 2),
(86, 36, 29, '2026-01-15', 'Confirmed', 3),
(87, 69, 5, '2025-10-25', 'Confirmed', 1),
(88, 48, 30, '2026-02-10', 'Completed', 2),
(89, 52, 14, '2025-08-10', 'Completed', 3),
(90, 46, 9, '2025-08-25', 'Confirmed', 2),
(91, 10, 9, '2025-04-12', 'Confirmed', 1),
(92, 62, 10, '2025-09-05', 'Confirmed', 3),
(93, 39, 3, '2025-12-15', 'Confirmed', 2),
(94, 33, 17, '2025-11-20', 'Confirmed', 3),
(95, 74, 9, '2025-12-20', 'Confirmed', 3),
(96, 58, 22, '2025-08-31', 'Confirmed', 4),
(97, 15, 25, '2026-03-01', 'Confirmed', 2),
(98, 28, 5, '2025-11-12', 'Confirmed', 2),
(99, 44, 18, '2026-01-20', 'Pending', 1),
(100, 5, 12, '2025-05-18', 'Completed', 2);

-- --------------------------------------------------------

--
-- Table structure for table `bookingdetail`
--

CREATE TABLE `bookingdetail` (
  `BookingID` int(11) NOT NULL,
  `DetailID` int(11) NOT NULL,
  `TravelerFirstName` varchar(50) DEFAULT NULL,
  `TravelerLastName` varchar(50) DEFAULT NULL,
  `TravelerAge` int(11) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `NID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookingdetail`
--

INSERT INTO `bookingdetail` (`BookingID`, `DetailID`, `TravelerFirstName`, `TravelerLastName`, `TravelerAge`, `Gender`, `NID`) VALUES
(1, 1, 'Rahim', 'Uddin', 34, 'Male', '1989012345678'),
(1, 2, 'Selina', 'Begum', 30, 'Female', '1994012345678'),
(2, 1, 'Nusrat', 'Jahan', 29, 'Female', '1995012345678'),
(3, 1, 'Tanvir', 'Hasan', 31, 'Male', '1993012345678'),
(3, 2, 'Sadia', 'Akter', 27, 'Female', '1997012345678'),
(3, 3, 'Yeasin', 'Hasan', 5, 'Male', NULL),
(4, 1, 'Arif', 'Rahman', 33, 'Male', '1990012345678'),
(4, 2, 'Lutfun', 'Nessa', 28, 'Female', '1996012345678'),
(5, 1, 'Karim', 'Ahmed', 40, 'Male', '1984012345678'),
(5, 2, 'Shila', 'Akter', 28, 'Female', '1996012345678'),
(5, 3, 'Jabed', 'Ahmed', 12, 'Male', NULL),
(5, 4, 'Fariha', 'Ahmed', 8, 'Female', NULL),
(6, 1, 'Rafi', 'Khan', 30, 'Male', '1994012345678'),
(6, 2, 'Mim', 'Rahman', 26, 'Female', '1998012345678'),
(7, 1, 'Mahmud', 'Hasan', 35, 'Male', '1988012345678'),
(8, 1, 'Nabila', 'Islam', 25, 'Female', '1999012345678'),
(8, 2, 'Farhan', 'Ahmed', 32, 'Male', '1992012345678'),
(8, 3, 'Kamrul', 'Islam', 60, 'Male', '1964012345678'),
(9, 1, 'Sabbir', 'Hossain', 29, 'Male', '1995012345679'),
(9, 2, 'Tania', 'Islam', 24, 'Female', '2000012345678'),
(10, 1, 'Rashid', 'Karim', 38, 'Male', '1986012345678'),
(11, 1, 'Nusrat', 'Sultana', 27, 'Female', '1997012345679'),
(11, 2, 'Rony', 'Ahmed', 30, 'Male', '1994012345679'),
(12, 1, 'David', 'Smith', 41, 'Male', NULL),
(12, 2, 'Emma', 'Wilson', 33, 'Female', NULL),
(12, 3, 'Noah', 'Smith', 10, 'Male', NULL),
(13, 1, 'Michael', 'Brown', 36, 'Male', NULL),
(13, 2, 'Sophia', 'Taylor', 31, 'Female', NULL),
(13, 3, 'James', 'Brown', 4, 'Male', NULL),
(13, 4, 'Linda', 'Brown', 34, 'Female', NULL),
(14, 1, 'James', 'Anderson', 42, 'Male', NULL),
(14, 2, 'Patricia', 'Anderson', 38, 'Female', NULL),
(15, 1, 'Lucas', 'Martinez', 35, 'Male', NULL),
(15, 2, 'Isabella', 'Garcia', 29, 'Female', NULL),
(16, 1, 'Oliver', 'Clark', 37, 'Male', NULL),
(17, 1, 'Mia', 'Lopez', 28, 'Female', NULL),
(17, 2, 'Ethan', 'Hall', 40, 'Male', NULL),
(18, 1, 'Carlos', 'Fernandez', 38, 'Male', NULL),
(18, 2, 'Julia', 'Roberts', 34, 'Female', NULL),
(18, 3, 'Diego', 'Fernandez', 12, 'Male', NULL),
(19, 1, 'Rakib', 'Mahmud', 31, 'Male', '1993012345680'),
(19, 2, 'Tahmina', 'Chowdhury', 27, 'Female', '1997012345680'),
(20, 1, 'Sadia', 'Akter', 27, 'Female', '1997012345680'),
(20, 2, 'Tanvir', 'Kabir', 32, 'Male', '1992012345680'),
(20, 3, 'Anika', 'Kabir', 5, 'Female', NULL),
(20, 4, 'Zayan', 'Kabir', 2, 'Male', NULL),
(21, 1, 'Fatema', 'Begum', 36, 'Female', '1988012345680'),
(21, 2, 'Abdur', 'Rob', 42, 'Male', '1982012345680'),
(22, 1, 'Noor', 'Islam', 33, 'Male', '1990012345680'),
(22, 2, 'Hassan', 'Ali', 30, 'Male', '1994012345680'),
(22, 3, 'Mitu', 'Khatun', 28, 'Female', '1996012345680'),
(23, 1, 'Ayesha', 'Sultana', 26, 'Female', '1998012345680'),
(24, 1, 'Daniel', 'Scott', 39, 'Male', NULL),
(24, 2, 'Sarah', 'Scott', 35, 'Female', NULL),
(25, 1, 'Mahin', 'Rahman', 24, 'Male', '2000012345680'),
(25, 2, 'Sabrina', 'Akter', 29, 'Female', '1995012345680'),
(26, 1, 'George', 'Adams', 43, 'Male', NULL),
(26, 2, 'Mary', 'Adams', 40, 'Female', NULL),
(26, 3, 'Kate', 'Adams', 15, 'Female', NULL),
(26, 4, 'John', 'Adams', 10, 'Male', NULL),
(27, 1, 'Rasel', 'Ahmed', 31, 'Male', '1993012345681'),
(27, 2, 'Ritu', 'Das', 27, 'Female', '1997012345681'),
(27, 3, 'Siam', 'Ahmed', 4, 'Male', NULL),
(28, 1, 'Jack', 'Turner', 37, 'Male', NULL),
(28, 2, 'Lily', 'Turner', 32, 'Female', NULL),
(29, 1, 'Naim', 'Uddin', 32, 'Male', '1992012345681'),
(30, 1, 'Adam', 'Hughes', 36, 'Male', NULL),
(30, 2, 'Eve', 'Hughes', 33, 'Female', NULL),
(30, 3, 'Cain', 'Hughes', 8, 'Male', NULL),
(31, 1, 'Rony', 'Karim', 33, 'Male', '1991012345681'),
(31, 2, 'Tania', 'Karim', 29, 'Female', '1995012345681'),
(32, 1, 'Faria', 'Jahan', 25, 'Female', '1999012345681'),
(32, 2, 'Sohan', 'Jahan', 28, 'Male', '1996012345681'),
(33, 1, 'Luis', 'Morales', 40, 'Male', NULL),
(34, 1, 'Saif', 'Hasan', 31, 'Male', '1993012345682'),
(34, 2, 'Nadia', 'Islam', 28, 'Female', '1996012345682'),
(34, 3, 'Rafsan', 'Hasan', 6, 'Male', NULL),
(34, 4, 'Sara', 'Hasan', 3, 'Female', NULL),
(35, 1, 'Owen', 'Parker', 35, 'Male', NULL),
(35, 2, 'Alice', 'Parker', 30, 'Female', NULL),
(36, 1, 'Kamrul', 'Hassan', 30, 'Male', '1994012345682'),
(36, 2, 'Sadia', 'Noor', 24, 'Female', '2000012345682'),
(36, 3, 'Labiba', 'Noor', 21, 'Female', '2003012345682'),
(37, 1, 'Mason', 'Carter', 38, 'Male', NULL),
(37, 2, 'Elena', 'Carter', 34, 'Female', NULL),
(38, 1, 'Imtiaz', 'Ahmed', 33, 'Male', '1991012345682'),
(38, 2, 'Munni', 'Ahmed', 28, 'Female', '1996012345682'),
(39, 1, 'Tania', 'Sultana', 27, 'Female', '1997012345682'),
(40, 1, 'Benjamin', 'Reed', 39, 'Male', NULL),
(40, 2, 'Clara', 'Reed', 35, 'Female', NULL),
(40, 3, 'Danny', 'Reed', 9, 'Male', NULL),
(41, 1, 'Ashik', 'Rahman', 29, 'Male', '1995012345682'),
(41, 2, 'Nabila', 'Haque', 26, 'Female', '1998012345682'),
(42, 1, 'Henry', 'Collins', 42, 'Male', NULL),
(42, 2, 'Molly', 'Collins', 38, 'Female', NULL),
(43, 1, 'Rifat', 'Khan', 30, 'Male', '1994012345683'),
(43, 2, 'Jannat', 'Akter', 25, 'Female', '1999012345683'),
(43, 3, 'Abir', 'Khan', 55, 'Male', '1969012345683'),
(43, 4, 'Rehana', 'Khan', 50, 'Female', '1974012345683'),
(44, 1, 'Victor', 'Sanchez', 41, 'Male', NULL),
(44, 2, 'Maria', 'Sanchez', 38, 'Female', NULL),
(44, 3, 'Leo', 'Sanchez', 11, 'Male', NULL),
(45, 1, 'Sami', 'Uddin', 32, 'Male', '1992012345683'),
(45, 2, 'Olivia', 'Morgan', 29, 'Female', NULL),
(46, 1, 'Hasib', 'Rahman', 28, 'Male', '1996012345683'),
(46, 2, 'Keya', 'Rahman', 24, 'Female', '2000012345683'),
(47, 1, 'Salma', 'Begum', 36, 'Female', '1988012345683'),
(48, 1, 'Ryan', 'Foster', 38, 'Male', NULL),
(48, 2, 'Grace', 'Foster', 34, 'Female', NULL),
(48, 3, 'Toby', 'Foster', 7, 'Male', NULL),
(49, 1, 'Adnan', 'Karim', 31, 'Male', '1993012345684'),
(49, 2, 'Lina', 'Karim', 27, 'Female', '1997012345684'),
(50, 1, 'Harun', 'Rashid', 34, 'Male', '1990012345684'),
(50, 2, 'Amena', 'Rashid', 60, 'Female', '1964012345684'),
(50, 3, 'Kashem', 'Rashid', 65, 'Male', '1959012345684'),
(50, 4, 'Zia', 'Rashid', 28, 'Male', '1996012345684'),
(51, 1, 'Farhan', 'Ahmed', 32, 'Male', '1992567890123'),
(51, 2, 'Jahan', 'Ahmed', 28, 'Female', '1996567890123'),
(52, 1, 'Tariq', 'Aziz', 35, 'Male', '1989012345690'),
(52, 2, 'Sumaya', 'Aziz', 30, 'Female', '1994012345690'),
(52, 3, 'Fahim', 'Aziz', 8, 'Male', NULL),
(53, 1, 'Iqbal', 'Khan', 45, 'Male', '1979012345691'),
(53, 2, 'Rina', 'Khan', 38, 'Female', '1986012345691'),
(54, 1, 'Zubair', 'Hasan', 29, 'Male', '1995012345692'),
(54, 2, 'Mona', 'Hasan', 25, 'Female', '1999012345692'),
(55, 1, 'Bilkis', 'Bano', 50, 'Female', '1974012345693'),
(56, 1, 'Sultan', 'Mahmud', 33, 'Male', '1991012345694'),
(56, 2, 'Nasrin', 'Mahmud', 29, 'Female', '1995012345694'),
(56, 3, 'Hridoy', 'Mahmud', 4, 'Male', NULL),
(57, 1, 'Asif', 'Iqbal', 31, 'Male', '1993012345695'),
(57, 2, 'Sonia', 'Iqbal', 27, 'Female', '1997012345695'),
(58, 1, 'Morshed', 'Alam', 40, 'Male', '1984012345696'),
(58, 2, 'Dilara', 'Alam', 34, 'Female', '1990012345696'),
(58, 3, 'Sakib', 'Alam', 10, 'Male', NULL),
(58, 4, 'Nabila', 'Alam', 6, 'Female', NULL),
(59, 1, 'Mustafa', 'Kamal', 36, 'Male', '1988012345697'),
(59, 2, 'Julekha', 'Kamal', 31, 'Female', '1993012345697'),
(60, 1, 'Kabir', 'Hossain', 28, 'Male', '1996012345698'),
(61, 1, 'Rubel', 'Hossain', 32, 'Male', '1993012345699'),
(61, 2, 'Akhi', 'Akter', 26, 'Female', '1999012345699'),
(62, 1, 'Sohail', 'Khan', 34, 'Male', '1991012345700'),
(62, 2, 'Meem', 'Khan', 29, 'Female', '1996012345700'),
(62, 3, 'Rayhan', 'Khan', 5, 'Male', NULL),
(63, 1, 'Bashar', 'Ahmed', 38, 'Male', '1987012345701'),
(63, 2, 'Lipi', 'Ahmed', 33, 'Female', '1992012345701'),
(64, 1, 'Ariful', 'Islam', 29, 'Male', '1996012345702'),
(64, 2, 'Keya', 'Islam', 24, 'Female', '2001012345702'),
(64, 3, 'Jihad', 'Islam', 3, 'Male', NULL),
(65, 1, 'Farid', 'Uddin', 45, 'Male', '1980012345703'),
(68, 2, 'Apu', 'Islam', 28, 'Female', '1997012345706');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CustomerID` int(11) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `NID` varchar(20) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `DoB` date DEFAULT NULL,
  `RegDate` datetime DEFAULT NULL,
  `HouseNo` varchar(20) DEFAULT NULL,
  `Area` varchar(50) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `District` varchar(50) DEFAULT NULL,
  `PostalCode` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustomerID`, `FirstName`, `LastName`, `Email`, `NID`, `Gender`, `DoB`, `RegDate`, `HouseNo`, `Area`, `City`, `District`, `PostalCode`) VALUES
(1, 'Mahmudul', 'Hasan', 'mahmud.hasan@yahoo.com', '1989345678901', 'Male', '1989-03-17', '2025-01-20 00:00:00', '34', 'Sonadanga', 'Khulna', 'Khulna', '9000'),
(2, 'Imran', 'Karim', 'imran.karim@yahoo.com', '1988123456780', 'Male', '1988-02-25', '2025-02-05 00:00:00', '44', 'Boyra', 'Khulna', 'Khulna', '9000'),
(3, 'Arif', 'Rahman', 'arif.rahman@gmail.com', '1990123456789', 'Male', '1990-05-12', '2025-02-11 00:00:00', '12', 'Dhanmondi', 'Dhaka', 'Dhaka', '1209'),
(4, 'Farhan', 'Ahmed', 'farhan.ahmed@gmail.com', '1994567890123', 'Male', '1994-09-14', '2025-02-22 00:00:00', '15', 'Banani', 'Dhaka', 'Dhaka', '1213'),
(5, 'David', 'Smith', 'david.smith@mail.com', NULL, 'Male', '1985-04-11', '2025-03-03 00:00:00', 'Hotel Sea Crown', 'Laboni', 'Coxs Bazar', 'Coxs Bazar', '4700'),
(6, 'Emma', 'Wilson', 'emma.wilson@mail.com', NULL, 'Female', '1991-06-15', '2025-03-06 00:00:00', 'Ocean Paradise', 'Laboni', 'Coxs Bazar', 'Coxs Bazar', '4700'),
(7, 'Michael', 'Brown', 'michael.brown@mail.com', NULL, 'Male', '1987-07-20', '2025-03-10 00:00:00', 'Sea Pearl', 'Inani', 'Coxs Bazar', 'Coxs Bazar', '4700'),
(8, 'Nusrat', 'Jahan', 'nusrat.jahan@yahoo.com', '1995234567890', 'Female', '1995-07-21', '2025-03-15 00:00:00', '45', 'Uttara', 'Dhaka', 'Dhaka', '1230'),
(9, 'Shila', 'Akter', 'shila.akter@gmail.com', '1996123456789', 'Female', '1996-06-11', '2025-03-19 00:00:00', '28', 'Mirpur', 'Dhaka', 'Dhaka', '1216'),
(10, 'Rafi', 'Khan', 'rafi.khan@gmail.com', '1992234567890', 'Male', '1992-08-30', '2025-04-01 00:00:00', '13', 'Nasirabad', 'Chittagong', 'Chattogram', '4000'),
(11, 'Mim', 'Rahman', 'mim.rahman@gmail.com', '1997456789011', 'Female', '1997-12-09', '2025-04-10 00:00:00', '7', 'Uposhohor', 'Sylhet', 'Sylhet', '3100'),
(12, 'Sabbir', 'Hossain', 'sabbir.hossain@gmail.com', '1993123456788', 'Male', '1993-04-10', '2025-04-12 00:00:00', '22', 'Agrabad', 'Chittagong', 'Chattogram', '4100'),
(13, 'Sophia', 'Taylor', 'sophia.taylor@mail.com', NULL, 'Female', '1993-01-28', '2025-04-15 00:00:00', 'Hill Resort', 'Sajek', 'Rangamati', 'Rangamati', '4500'),
(14, 'James', 'Anderson', 'james.anderson@mail.com', NULL, 'Male', '1982-09-14', '2025-05-02 00:00:00', 'Hill Cottage', 'Bandarban', 'Bandarban', 'Bandarban', '4600'),
(15, 'Tanisha', 'Islam', 'tanisha.islam@gmail.com', '1998456789012', 'Female', '1998-11-05', '2025-05-08 00:00:00', '18', 'Zindabazar', 'Sylhet', 'Sylhet', '3100'),
(16, 'Rashid', 'Karim', 'rashid.karim@gmail.com', '1990345678901', 'Male', '1990-12-12', '2025-05-18 00:00:00', '18', 'Rajpara', 'Rajshahi', 'Rajshahi', '6000'),
(17, 'Shuvo', 'Ahmed', 'shuvo.ahmed@gmail.com', '1995234567891', 'Male', '1995-03-09', '2025-06-03 00:00:00', '9', 'Kandirpar', 'Cumilla', 'Cumilla', '3500'),
(18, 'Nabila', 'Islam', 'nabila.islam@gmail.com', '1996789012345', 'Female', '1996-04-27', '2025-06-05 00:00:00', '11', 'Halishahar', 'Chittagong', 'Chattogram', '4216'),
(19, 'Rahat', 'Hossain', 'rahat.hossain@gmail.com', '1994234567890', 'Male', '1994-10-01', '2025-06-10 00:00:00', '30', 'Shahjalal Upashahar', 'Sylhet', 'Sylhet', '3100'),
(20, 'Fahim', 'Rahman', 'fahim.rahman@gmail.com', '1992123456789', 'Male', '1992-02-18', '2025-06-20 00:00:00', '21', 'Shibbari', 'Khulna', 'Khulna', '9100'),
(21, 'Lucas', 'Martinez', 'lucas.martinez@mail.com', NULL, 'Male', '1989-08-13', '2025-07-01 00:00:00', 'Blue Marine', 'Saint Martin', 'Coxs Bazar', 'Coxs Bazar', '4762'),
(22, 'Isabella', 'Garcia', 'isabella.garcia@mail.com', NULL, 'Female', '1994-11-21', '2025-07-02 00:00:00', 'Coral Resort', 'Saint Martin', 'Coxs Bazar', 'Coxs Bazar', '4762'),
(23, 'Oliver', 'Clark', 'oliver.clark@mail.com', NULL, 'Male', '1987-05-30', '2025-07-05 00:00:00', 'Hill View', 'Bandarban', 'Bandarban', 'Bandarban', '4600'),
(24, 'Mia', 'Lopez', 'mia.lopez@mail.com', NULL, 'Female', '1996-09-09', '2025-07-06 00:00:00', 'Tea Resort', 'Srimangal', 'Moulvibazar', 'Moulvibazar', '3210'),
(25, 'Ethan', 'Hall', 'ethan.hall@mail.com', NULL, 'Male', '1984-01-19', '2025-07-10 00:00:00', 'Forest Lodge', 'Sundarbans', 'Satkhira', 'Satkhira', '9400'),
(26, 'Arafat', 'Hossain', 'arafat.hossain@gmail.com', '1993456789012', 'Male', '1993-06-14', '2025-07-12 00:00:00', '17', 'Bashundhara', 'Dhaka', 'Dhaka', '1229'),
(27, 'Emily', 'Johnson', 'emily.johnson@mail.com', NULL, 'Female', '1992-05-17', '2025-07-13 00:00:00', 'Sea Breeze', 'Inani', 'Coxs Bazar', 'Coxs Bazar', '4700'),
(28, 'Rakib', 'Mahmud', 'rakib.mahmud@gmail.com', '1992234567899', 'Male', '1992-08-19', '2025-07-14 00:00:00', '8', 'Uttara', 'Dhaka', 'Dhaka', '1230'),
(29, 'Carlos', 'Fernandez', 'carlos.fernandez@mail.com', NULL, 'Male', '1986-11-02', '2025-07-15 00:00:00', 'Beach Resort', 'Kuakata', 'Patuakhali', 'Patuakhali', '8650'),
(30, 'Sadia', 'Akter', 'sadia.akter@gmail.com', '1997234567812', 'Female', '1997-09-01', '2025-07-16 00:00:00', '19', 'Sholoshahar', 'Chittagong', 'Chattogram', '4202'),
(31, 'Tanvir', 'Kabir', 'tanvir.kabir@gmail.com', '1991456789012', 'Male', '1991-01-23', '2025-07-17 00:00:00', '27', 'Rampura', 'Dhaka', 'Dhaka', '1219'),
(32, 'Fatema', 'Begum', 'fatema.begum@gmail.com', '1989345678999', 'Female', '1989-04-11', '2025-07-18 00:00:00', '33', 'Amborkhana', 'Sylhet', 'Sylhet', '3100'),
(33, 'Liam', 'Walker', 'liam.walker@mail.com', NULL, 'Male', '1988-12-21', '2025-07-19 00:00:00', 'Tea Lodge', 'Srimangal', 'Moulvibazar', 'Moulvibazar', '3210'),
(34, 'Noor', 'Islam', 'noor.islam@gmail.com', '1995123456789', 'Male', '1995-03-13', '2025-07-20 00:00:00', '6', 'Sonadanga', 'Khulna', 'Khulna', '9000'),
(35, 'Hassan', 'Ali', 'hassan.ali@gmail.com', '1996234567891', 'Male', '1996-02-28', '2025-07-21 00:00:00', '15', 'Rajpara', 'Rajshahi', 'Rajshahi', '6000'),
(36, 'Ayesha', 'Sultana', 'ayesha.sultana@gmail.com', '1998456789011', 'Female', '1998-10-17', '2025-07-22 00:00:00', '22', 'Kotwali', 'Barishal', 'Barishal', '8200'),
(37, 'Daniel', 'Scott', 'daniel.scott@mail.com', NULL, 'Male', '1987-06-09', '2025-07-23 00:00:00', 'Forest Camp', 'Sundarbans', 'Satkhira', 'Satkhira', '9400'),
(38, 'Mahin', 'Rahman', 'mahin.rahman@gmail.com', '1999345678901', 'Male', '1999-01-04', '2025-07-24 00:00:00', '11', 'Dhanmondi', 'Dhaka', 'Dhaka', '1209'),
(39, 'Sabrina', 'Akter', 'sabrina.akter@gmail.com', '1995456789012', 'Female', '1995-07-11', '2025-07-25 00:00:00', '41', 'Halishahar', 'Chittagong', 'Chattogram', '4216'),
(40, 'George', 'Adams', 'george.adams@mail.com', NULL, 'Male', '1983-03-30', '2025-07-26 00:00:00', 'Hill Lodge', 'Bandarban', 'Bandarban', 'Bandarban', '4600'),
(41, 'Rasel', 'Ahmed', 'rasel.ahmed@gmail.com', '1992233445566', 'Male', '1992-04-21', '2025-07-27 00:00:00', '9', 'Mirpur', 'Dhaka', 'Dhaka', '1216'),
(42, 'Ritu', 'Das', 'ritu.das@gmail.com', '1996789011112', 'Female', '1996-08-09', '2025-07-28 00:00:00', '3', 'Kandirpar', 'Cumilla', 'Cumilla', '3500'),
(43, 'Jack', 'Turner', 'jack.turner@mail.com', NULL, 'Male', '1986-12-15', '2025-07-29 00:00:00', 'Sea View', 'Coxs Bazar', 'Coxs Bazar', 'Coxs Bazar', '4700'),
(44, 'Naim', 'Uddin', 'naim.uddin@gmail.com', '1993234567890', 'Male', '1993-02-02', '2025-07-30 00:00:00', '14', 'Shibbari', 'Khulna', 'Khulna', '9100'),
(45, 'Tasnim', 'Rahman', 'tasnim.rahman@gmail.com', '1997456789000', 'Female', '1997-05-25', '2025-07-31 00:00:00', '23', 'Uposhohor', 'Sylhet', 'Sylhet', '3100'),
(46, 'Adam', 'Hughes', 'adam.hughes@mail.com', NULL, 'Male', '1988-07-07', '2025-08-01 00:00:00', 'Beach Lodge', 'Saint Martin', 'Coxs Bazar', 'Coxs Bazar', '4762'),
(47, 'Rony', 'Karim', 'rony.karim@gmail.com', '1993123456700', 'Male', '1993-10-12', '2025-08-02 00:00:00', '21', 'Banani', 'Dhaka', 'Dhaka', '1213'),
(48, 'Faria', 'Jahan', 'faria.jahan@gmail.com', '1998678901234', 'Female', '1998-04-14', '2025-08-03 00:00:00', '19', 'Amborkhana', 'Sylhet', 'Sylhet', '3100'),
(49, 'Luis', 'Morales', 'luis.morales@mail.com', NULL, 'Male', '1985-01-18', '2025-08-04 00:00:00', 'Eco Resort', 'Kuakata', 'Patuakhali', 'Patuakhali', '8650'),
(50, 'Saif', 'Hasan', 'saif.hasan@gmail.com', '1991456789123', 'Male', '1991-09-20', '2025-08-05 00:00:00', '12', 'Agrabad', 'Chittagong', 'Chattogram', '4100'),
(51, 'Nadia', 'Islam', 'nadia.islam@gmail.com', '1997345678901', 'Female', '1997-03-03', '2025-08-06 00:00:00', '7', 'Sonadanga', 'Khulna', 'Khulna', '9000'),
(52, 'Owen', 'Parker', 'owen.parker@mail.com', NULL, 'Male', '1989-02-11', '2025-08-07 00:00:00', 'Tea Lodge', 'Srimangal', 'Moulvibazar', 'Moulvibazar', '3210'),
(53, 'Kamrul', 'Hassan', 'kamrul.hassan@gmail.com', '1994456789012', 'Male', '1994-06-22', '2025-08-08 00:00:00', '8', 'Uttara', 'Dhaka', 'Dhaka', '1230'),
(54, 'Sadia', 'Noor', 'sadia.noor@gmail.com', '1998456789019', 'Female', '1998-11-29', '2025-08-09 00:00:00', '13', 'Rajpara', 'Rajshahi', 'Rajshahi', '6000'),
(55, 'Mason', 'Carter', 'mason.carter@mail.com', NULL, 'Male', '1987-08-13', '2025-08-10 00:00:00', 'Forest Lodge', 'Sundarbans', 'Satkhira', 'Satkhira', '9400'),
(56, 'Imtiaz', 'Ahmed', 'imtiaz.ahmed@gmail.com', '1992234567893', 'Male', '1992-01-11', '2025-08-11 00:00:00', '15', 'Mirpur', 'Dhaka', 'Dhaka', '1216'),
(57, 'Tania', 'Sultana', 'tania.sultana@gmail.com', '1996456789012', 'Female', '1996-05-08', '2025-08-12 00:00:00', '11', 'Kotwali', 'Barishal', 'Barishal', '8200'),
(58, 'Benjamin', 'Reed', 'benjamin.reed@mail.com', NULL, 'Male', '1986-04-25', '2025-08-13 00:00:00', 'Sea Pearl', 'Inani', 'Coxs Bazar', 'Coxs Bazar', '4700'),
(59, 'Ashik', 'Rahman', 'ashik.rahman@gmail.com', '1995234567800', 'Male', '1995-12-02', '2025-08-14 00:00:00', '5', 'Rampura', 'Dhaka', 'Dhaka', '1219'),
(60, 'Nabila', 'Haque', 'nabila.haque@gmail.com', '1997234567801', 'Female', '1997-07-07', '2025-08-15 00:00:00', '18', 'Zindabazar', 'Sylhet', 'Sylhet', '3100'),
(61, 'Henry', 'Collins', 'henry.collins@mail.com', NULL, 'Male', '1984-03-05', '2025-08-16 00:00:00', 'Hill View', 'Bandarban', 'Bandarban', 'Bandarban', '4600'),
(62, 'Rifat', 'Khan', 'rifat.khan@gmail.com', '1994234567800', 'Male', '1994-02-14', '2025-08-17 00:00:00', '22', 'Banani', 'Dhaka', 'Dhaka', '1213'),
(63, 'Jannat', 'Akter', 'jannat.akter@gmail.com', '1998345678902', 'Female', '1998-01-21', '2025-08-18 00:00:00', '9', 'Kandirpar', 'Cumilla', 'Cumilla', '3500'),
(64, 'Victor', 'Sanchez', 'victor.sanchez@mail.com', NULL, 'Male', '1985-09-18', '2025-08-19 00:00:00', 'Beach Lodge', 'Kuakata', 'Patuakhali', 'Patuakhali', '8650'),
(65, 'Sami', 'Uddin', 'sami.uddin@gmail.com', '1991345678901', 'Male', '1991-06-30', '2025-08-20 00:00:00', '14', 'Shibbari', 'Khulna', 'Khulna', '9100'),
(66, 'Olivia', 'Morgan', 'olivia.morgan@mail.com', NULL, 'Female', '1992-10-01', '2025-08-21 00:00:00', 'Sea Breeze', 'Laboni', 'Coxs Bazar', 'Coxs Bazar', '4700'),
(67, 'Hasib', 'Rahman', 'hasib.rahman@gmail.com', '1997234567809', 'Male', '1997-08-28', '2025-08-22 00:00:00', '16', 'Dhanmondi', 'Dhaka', 'Dhaka', '1209'),
(68, 'Salma', 'Begum', 'salma.begum@gmail.com', '1989456789011', 'Female', '1989-05-17', '2025-08-23 00:00:00', '10', 'Sonadanga', 'Khulna', 'Khulna', '9000'),
(69, 'Ryan', 'Foster', 'ryan.foster@mail.com', NULL, 'Male', '1987-11-09', '2025-08-24 00:00:00', 'Eco Lodge', 'Sundarbans', 'Satkhira', 'Satkhira', '9400'),
(70, 'Adnan', 'Karim', 'adnan.karim@gmail.com', '1992456789011', 'Male', '1992-03-15', '2025-08-25 00:00:00', '7', 'Mirpur', 'Dhaka', 'Dhaka', '1216'),
(71, 'Harun', 'Rashid', 'harun.rashid@gmail.com', '1990456789012', 'Male', '1990-07-19', '2025-08-26 00:00:00', '14', 'Mohammadpur', 'Dhaka', 'Dhaka', '1207'),
(72, 'Anna', 'Peterson', 'anna.peterson@mail.com', NULL, 'Female', '1991-03-14', '2025-08-27 00:00:00', 'Sea Pearl', 'Laboni', 'Coxs Bazar', 'Coxs Bazar', '4700'),
(73, 'Shakib', 'Alam', 'shakib.alam@gmail.com', '1996234567898', 'Male', '1996-11-09', '2025-08-28 00:00:00', '9', 'Uttara', 'Dhaka', 'Dhaka', '1230'),
(74, 'Julia', 'Roberts', 'julia.roberts@mail.com', NULL, 'Female', '1988-04-27', '2025-08-29 00:00:00', 'Hill Resort', 'Bandarban', 'Bandarban', 'Bandarban', '4600'),
(75, 'Reza', 'Karim', 'reza.karim@gmail.com', '1993456789022', 'Male', '1993-02-18', '2025-08-30 00:00:00', '6', 'Rajpara', 'Rajshahi', 'Rajshahi', '6000'),
(76, 'Martha', 'Lopez', 'martha.lopez@mail.com', NULL, 'Female', '1990-06-11', '2025-08-31 00:00:00', 'Tea Garden Lodge', 'Srimangal', 'Moulvibazar', 'Moulvibazar', '3210'),
(77, 'Tariq', 'Hossain', 'tariq.hossain@gmail.com', '1995345678900', 'Male', '1995-09-22', '2025-09-01 00:00:00', '17', 'Sonadanga', 'Khulna', 'Khulna', '9000'),
(78, 'Sara', 'Mitchell', 'sara.mitchell@mail.com', NULL, 'Female', '1994-01-08', '2025-09-02 00:00:00', 'Beach Resort', 'Kuakata', 'Patuakhali', 'Patuakhali', '8650'),
(79, 'Fahad', 'Mahmud', 'fahad.mahmud@gmail.com', '1997123456780', 'Male', '1997-12-30', '2025-09-03 00:00:00', '12', 'Agrabad', 'Chittagong', 'Chattogram', '4100'),
(80, 'Daniel', 'Evans', 'daniel.evans@mail.com', NULL, 'Male', '1986-08-15', '2025-09-04 00:00:00', 'Forest Lodge', 'Sundarbans', 'Satkhira', 'Satkhira', '9400');

-- --------------------------------------------------------

--
-- Table structure for table `customerphone`
--

CREATE TABLE `customerphone` (
  `CustomerID` int(11) NOT NULL,
  `PhoneNumber` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customerphone`
--

INSERT INTO `customerphone` (`CustomerID`, `PhoneNumber`) VALUES
(1, '01305562147'),
(1, '01712458963'),
(2, '01625478963'),
(2, '01819632541'),
(3, '01755698412'),
(3, '01844563214'),
(3, '01911475823'),
(4, '01401254789'),
(4, '01722365478'),
(5, '01711236548'),
(5, '01813698547'),
(6, '01302214587'),
(6, '01675412369'),
(7, '01733654128'),
(7, '01815547896'),
(8, '01620014587'),
(8, '01711478523'),
(8, '01922365410'),
(9, '01408896541'),
(9, '01715569842'),
(10, '01712236549'),
(10, '01817745821'),
(11, '01314458796'),
(11, '01611254879'),
(12, '01718896542'),
(12, '01812236547'),
(13, '01556632147'),
(13, '01744589632'),
(13, '01933654127'),
(14, '01403321456'),
(14, '01711236589'),
(15, '01615569842'),
(15, '01814458796'),
(16, '01307789654'),
(16, '01715523641'),
(17, '01719985472'),
(17, '01822365418'),
(18, '01621145873'),
(18, '01711478529'),
(18, '01944563218'),
(19, '01404412587'),
(19, '01552236541'),
(19, '01722365894'),
(19, '01811475823'),
(20, '01712236544'),
(20, '01815569843'),
(21, '01318896542'),
(21, '01633214587'),
(22, '01714458793'),
(22, '01819965412'),
(23, '01624458796'),
(23, '01712236541'),
(23, '01955632147'),
(24, '01405521478'),
(24, '01733654120'),
(25, '01711478520'),
(25, '01822365471'),
(26, '01309985471'),
(26, '01618896547'),
(27, '01715569840'),
(27, '01814458792'),
(28, '01625569841'),
(28, '01712236540'),
(28, '01911475820'),
(29, '01406632147'),
(29, '01722365890'),
(30, '01714458790'),
(30, '01813321458'),
(31, '01312236547'),
(31, '01719985470'),
(32, '01554412587'),
(32, '01611478523'),
(32, '01824458796'),
(33, '01715569843'),
(33, '01817745820'),
(33, '01922365417'),
(34, '01407789654'),
(34, '01718896540'),
(35, '01629985471'),
(35, '01713321458'),
(35, '01812236540'),
(36, '01301125478'),
(36, '01635569842'),
(37, '01714458790'),
(37, '01815523641'),
(37, '01914475823'),
(38, '01628896542'),
(38, '01712236543'),
(38, '01955632140'),
(39, '01408896540'),
(39, '01733654121'),
(40, '01556632140'),
(40, '01711478521'),
(40, '01822365470'),
(41, '01309985470'),
(41, '01618896540'),
(42, '01715569841'),
(42, '01814458790'),
(42, '01912236547'),
(43, '01625569840'),
(43, '01712236541'),
(43, '01911475821'),
(44, '01406632140'),
(44, '01722365891'),
(45, '01714458791'),
(45, '01813321450'),
(46, '01315569842'),
(46, '01632214587'),
(47, '01717745821'),
(47, '01818896540'),
(48, '01621145870'),
(48, '01719985471'),
(48, '01922365411'),
(49, '01407789650'),
(49, '01718896541'),
(50, '01713321451'),
(50, '01812236541'),
(51, '01552236540'),
(51, '01744589631'),
(51, '01933654121'),
(52, '01303321451'),
(52, '01711236581'),
(53, '01615569841'),
(53, '01814458791'),
(54, '01307789651'),
(54, '01715523640'),
(54, '01819965410'),
(55, '01719985470'),
(55, '01822365411'),
(56, '01711478521'),
(56, '01944563211'),
(57, '01318896541'),
(57, '01553321458'),
(57, '01633214581'),
(58, '01714458791'),
(58, '01819965411'),
(59, '01712236540'),
(59, '01955632141'),
(60, '01405521471'),
(60, '01621145871'),
(60, '01733654122'),
(61, '01711478522'),
(61, '01822365472'),
(62, '01309985472'),
(62, '01618896542'),
(63, '01715569842'),
(63, '01814458791'),
(63, '01912236541'),
(64, '01712236542'),
(64, '01911475822'),
(65, '01406632141'),
(65, '01722365892'),
(66, '01552236543'),
(66, '01624458791'),
(66, '01714458792'),
(66, '01813321451'),
(67, '01312236541'),
(67, '01401125471'),
(67, '01719985472'),
(67, '01819965413'),
(68, '01554412581'),
(68, '01611478521'),
(68, '01713321452'),
(68, '01824458791'),
(69, '01626632147'),
(69, '01715569841'),
(69, '01817745821'),
(69, '01922365412'),
(70, '01304412587'),
(70, '01407789651'),
(70, '01551125478'),
(70, '01718896542'),
(71, '01315569843'),
(71, '01411478523'),
(71, '01812236542'),
(72, '01301125471'),
(72, '01635569841'),
(72, '01819965414'),
(73, '01714458791'),
(73, '01815523640'),
(73, '01914475821'),
(74, '01511223344'),
(74, '01710011223'),
(74, '01955632142'),
(75, '01408896542'),
(75, '01733654123'),
(76, '01611223344'),
(76, '01711478523'),
(76, '01822365473'),
(77, '01309985473'),
(77, '01618896543'),
(78, '01715569843'),
(78, '01814458793'),
(78, '01912236543'),
(79, '01712236543'),
(79, '01911445566'),
(79, '01911475823'),
(80, '01406632143'),
(80, '01710009988'),
(80, '01722365893');

-- --------------------------------------------------------

--
-- Table structure for table `guidelanguage`
--

CREATE TABLE `guidelanguage` (
  `GuideID` int(11) NOT NULL,
  `Language` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guidelanguage`
--

INSERT INTO `guidelanguage` (`GuideID`, `Language`) VALUES
(1, 'Bangla'),
(1, 'English'),
(1, 'Hindi'),
(2, 'Bangla'),
(2, 'English'),
(2, 'Hindi'),
(3, 'Bangla'),
(3, 'English'),
(3, 'Hindi'),
(4, 'Arabic'),
(4, 'Bangla'),
(4, 'English'),
(5, 'Arabic'),
(5, 'Bangla'),
(5, 'Hindi'),
(6, 'Bangla'),
(6, 'English'),
(6, 'Hindi'),
(7, 'Bangla'),
(7, 'Chinese'),
(7, 'Japanese'),
(8, 'Bangla'),
(8, 'English'),
(8, 'Hindi'),
(9, 'Arabic'),
(9, 'Bangla'),
(9, 'French'),
(10, 'Bangla'),
(10, 'English'),
(10, 'Hindi'),
(11, 'Arabic'),
(11, 'English'),
(11, 'Hindi'),
(12, 'Bangla'),
(12, 'English'),
(12, 'Hindi'),
(13, 'Arabic'),
(13, 'English'),
(13, 'Spanish'),
(14, 'Bangla'),
(14, 'English'),
(14, 'French'),
(14, 'German'),
(15, 'Arabic'),
(15, 'Bangla'),
(15, 'English'),
(16, 'Bangla'),
(16, 'Marma'),
(17, 'English'),
(17, 'Hindi'),
(17, 'Marma'),
(18, 'Bangla'),
(18, 'English'),
(18, 'Marma'),
(19, 'Bangla'),
(19, 'Marma'),
(20, 'Bangla'),
(20, 'English'),
(20, 'Hindi'),
(21, 'Bangla'),
(21, 'Chakma'),
(21, 'English'),
(22, 'Bangla'),
(22, 'English'),
(22, 'Japanese'),
(23, 'Bangla'),
(23, 'Chakma'),
(23, 'English'),
(24, 'Bangla'),
(24, 'English'),
(24, 'Hindi'),
(24, 'Tripura'),
(25, 'English'),
(25, 'Tripura'),
(26, 'Bangla'),
(26, 'English'),
(26, 'Tripura'),
(27, 'Bangla'),
(27, 'English'),
(27, 'Mro'),
(28, 'English'),
(28, 'Hindi'),
(28, 'Mro'),
(29, 'Bangla'),
(29, 'English'),
(29, 'Portuguese'),
(30, 'Arabic'),
(30, 'English'),
(31, 'Bangla'),
(31, 'English'),
(31, 'French'),
(31, 'Hindi'),
(32, 'Bangla'),
(32, 'English'),
(32, 'Hindi'),
(33, 'Arabic'),
(33, 'Bangla'),
(33, 'English'),
(33, 'Hindi'),
(34, 'Bangla'),
(34, 'Chinese'),
(34, 'English'),
(34, 'Japanese'),
(35, 'Bangla'),
(35, 'English'),
(35, 'Hindi'),
(36, 'Arabic'),
(36, 'Bangla'),
(36, 'English'),
(37, 'Bangla'),
(37, 'English'),
(37, 'Hindi'),
(38, 'Bangla'),
(38, 'English'),
(38, 'French'),
(38, 'German'),
(39, 'Bangla'),
(39, 'Chak'),
(40, 'English'),
(40, 'Khumi');

-- --------------------------------------------------------

--
-- Table structure for table `hotel`
--

CREATE TABLE `hotel` (
  `HotelID` int(11) NOT NULL,
  `HotelName` varchar(100) DEFAULT NULL,
  `StarRating` int(11) DEFAULT NULL,
  `PricePerNight` decimal(10,2) DEFAULT NULL,
  `LocationID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`HotelID`, `HotelName`, `StarRating`, `PricePerNight`, `LocationID`) VALUES
(1, 'Sea Crown Hotel', 4, 7500.00, 1),
(2, 'Hotel Sea Palace', 3, 5200.00, 1),
(3, 'Ocean Paradise Resort', 5, 12000.00, 1),
(4, 'Hotel Cox Today', 5, 15000.00, 1),
(5, 'Prime Park Hotel', 4, 8200.00, 1),
(6, 'Coral Blue Resort', 4, 9500.00, 2),
(7, 'Blue Marine Resort', 3, 6500.00, 2),
(8, 'Saint Martin Coral View', 3, 5800.00, 2),
(9, 'Inani Royal Resort', 4, 7200.00, 3),
(10, 'Inani Sea Breeze Hotel', 3, 4800.00, 3),
(11, 'Himchari Hill Resort', 3, 4500.00, 4),
(12, 'Himchari Nature Lodge', 2, 3200.00, 4),
(13, 'Sajek Resort', 4, 9000.00, 5),
(14, 'Sajek Valley View Resort', 3, 6200.00, 5),
(15, 'Cloud Hill Resort Sajek', 3, 5400.00, 5),
(16, 'Nilgiri Resort', 4, 8500.00, 6),
(17, 'Nilgiri Hill Cottage', 3, 5000.00, 6),
(18, 'Nilachal Tourist Lodge', 3, 4800.00, 7),
(19, 'Nilachal View Resort', 4, 7100.00, 7),
(20, 'Boga Lake Eco Resort', 3, 4700.00, 8),
(21, 'Boga Lake Hill Cottage', 2, 3100.00, 8),
(22, 'Keokradong Mountain Lodge', 3, 5200.00, 9),
(23, 'Keokradong Adventure Resort', 3, 5600.00, 9),
(24, 'Rangamati Lake View Hotel', 3, 4400.00, 10),
(25, 'Rangamati Tourist Motel', 2, 3000.00, 10),
(26, 'Kaptai Lake Resort', 4, 7800.00, 11),
(27, 'Kaptai Hill View Hotel', 3, 4200.00, 11),
(28, 'Ratargul Forest Resort', 3, 4800.00, 12),
(29, 'Ratargul Eco Lodge', 2, 3200.00, 12),
(30, 'Jaflong Green Resort', 4, 7200.00, 13),
(31, 'Jaflong Hill Breeze Hotel', 3, 4600.00, 13),
(32, 'Lalakhal Riverside Resort', 4, 7600.00, 14),
(33, 'Lalakhal Blue Water Hotel', 3, 5200.00, 14),
(34, 'Grand Sultan Tea Resort', 5, 16000.00, 15),
(35, 'Tea Garden Eco Resort', 4, 8400.00, 15),
(36, 'Lawachara Forest Resort', 3, 5000.00, 16),
(37, 'Lawachara Nature Lodge', 2, 3300.00, 16),
(38, 'Madhabkunda Waterfall Resort', 3, 4700.00, 17),
(39, 'Madhabkunda Hill Lodge', 2, 3100.00, 17),
(40, 'Sundarbans Tiger Resort', 4, 9200.00, 18),
(41, 'Sundarbans Eco Village', 3, 6400.00, 18),
(42, 'Kotka Forest Lodge', 3, 5500.00, 19),
(43, 'Kuakata Grand Hotel', 4, 7800.00, 20),
(44, 'Kuakata Sea Breeze Resort', 3, 5200.00, 20),
(45, 'Fatrar Char Eco Resort', 3, 4700.00, 21),
(46, 'Tanguar Haor Floating Resort', 3, 5600.00, 22),
(47, 'Hakaluki Haor Nature Resort', 3, 5100.00, 23),
(48, 'Nijhum Island Beach Resort', 3, 5400.00, 24),
(49, 'Sonargaon Heritage Hotel', 4, 8200.00, 25),
(50, 'Kantaji Temple Tourist Inn', 3, 4000.00, 30);

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `LocationID` int(11) NOT NULL,
  `PlaceName` varchar(100) DEFAULT NULL,
  `Area` varchar(100) DEFAULT NULL,
  `District` varchar(50) DEFAULT NULL,
  `Division` varchar(50) DEFAULT NULL,
  `BestSeason` varchar(50) DEFAULT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`LocationID`, `PlaceName`, `Area`, `District`, `Division`, `BestSeason`, `Description`) VALUES
(1, 'Cox\'s Bazar Sea Beach', 'Laboni', 'Cox\'s Bazar', 'Chattogram', 'Winter', 'World longest natural sea beach and most popular tourist destination in Bangladesh'),
(2, 'Saint Martin Island', 'Teknaf', 'Cox\'s Bazar', 'Chattogram', 'Winter', 'Beautiful coral island famous for blue water and seafood'),
(3, 'Inani Beach', 'Inani', 'Cox\'s Bazar', 'Chattogram', 'Winter', 'Rocky sea beach with crystal clear water and scenic sunset view'),
(4, 'Himchari Waterfall', 'Himchari', 'Cox\'s Bazar', 'Chattogram', 'Monsoon', 'Small waterfall surrounded by green hills near Cox\'s Bazar'),
(5, 'Sajek Valley', 'Sajek', 'Rangamati', 'Chattogram', 'Winter', 'Mountain valley famous for clouds, sunrise and tribal culture'),
(6, 'Nilgiri Hills', 'Bandarban', 'Bandarban', 'Chattogram', 'Winter', 'High hill resort area known for panoramic cloud views'),
(7, 'Nilachal', 'Bandarban', 'Bandarban', 'Chattogram', 'Winter', 'Popular viewpoint hill near Bandarban town'),
(8, 'Boga Lake', 'Ruma', 'Bandarban', 'Chattogram', 'Winter', 'High altitude lake surrounded by mountains'),
(9, 'Keokradong Peak', 'Ruma', 'Bandarban', 'Chattogram', 'Winter', 'One of the highest mountain peaks in Bangladesh'),
(10, 'Rangamati Lake', 'Kaptai', 'Rangamati', 'Chattogram', 'Winter', 'Beautiful lake created by Kaptai dam'),
(11, 'Kaptai Lake', 'Kaptai', 'Rangamati', 'Chattogram', 'Winter', 'Largest man-made lake in Bangladesh with scenic hill views'),
(12, 'Ratargul Swamp Forest', 'Gowainghat', 'Sylhet', 'Sylhet', 'Monsoon', 'Freshwater swamp forest often called the Amazon of Bangladesh'),
(13, 'Jaflong', 'Jaflong', 'Sylhet', 'Sylhet', 'Winter', 'Border river area famous for stone collection and mountain views'),
(14, 'Lalakhal', 'Kanaighat', 'Sylhet', 'Sylhet', 'Winter', 'River with crystal blue water surrounded by green hills'),
(15, 'Srimangal Tea Garden', 'Srimangal', 'Moulvibazar', 'Sylhet', 'Winter', 'Tea capital of Bangladesh known for lush green tea estates'),
(16, 'Lawachara National Park', 'Kamalganj', 'Moulvibazar', 'Sylhet', 'Winter', 'Rainforest national park famous for wildlife and hiking'),
(17, 'Madhabkunda Waterfall', 'Barlekha', 'Moulvibazar', 'Sylhet', 'Monsoon', 'Largest waterfall in Bangladesh'),
(18, 'Sundarbans Mangrove Forest', 'Shyamnagar', 'Satkhira', 'Khulna', 'Winter', 'Largest mangrove forest and home of Royal Bengal Tiger'),
(19, 'Kotka Beach', 'Dacope', 'Khulna', 'Khulna', 'Winter', 'Sea beach area inside Sundarbans forest'),
(20, 'Kuakata Sea Beach', 'Kuakata', 'Patuakhali', 'Barishal', 'Winter', 'Rare sea beach where both sunrise and sunset can be seen'),
(21, 'Fatrar Char', 'Kuakata', 'Patuakhali', 'Barishal', 'Winter', 'Mangrove forest area near Kuakata sea beach'),
(22, 'Tanguar Haor', 'Dharmapasha', 'Sunamganj', 'Sylhet', 'Monsoon', 'Large wetland ecosystem famous for boat tours'),
(23, 'Hakaluki Haor', 'Fenchuganj', 'Sylhet', 'Sylhet', 'Monsoon', 'Important wetland ecosystem for migratory birds'),
(24, 'Nijhum Dwip', 'Hatiya', 'Noakhali', 'Chattogram', 'Winter', 'Island famous for deer population and coastal forest'),
(25, 'Sonargaon Folk Museum', 'Sonargaon', 'Narayanganj', 'Dhaka', 'Winter', 'Historical city with traditional Bangladeshi culture'),
(26, 'Ahsan Manzil', 'Kumartoli', 'Dhaka', 'Dhaka', 'Winter', 'Historic pink palace museum beside Buriganga river'),
(27, 'Mahasthangarh', 'Shibganj', 'Bogra', 'Rajshahi', 'Winter', 'Ancient archaeological site of Bengal civilization'),
(28, 'Paharpur Buddhist Monastery', 'Badalgachi', 'Naogaon', 'Rajshahi', 'Winter', 'UNESCO world heritage Buddhist monastery'),
(29, 'Somapura Mahavihara', 'Paharpur', 'Naogaon', 'Rajshahi', 'Winter', 'One of the most important archaeological sites in South Asia'),
(30, 'Kantaji Temple', 'Kaharole', 'Dinajpur', 'Rangpur', 'Winter', 'Famous terracotta Hindu temple built in the 18th century');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `PaymentID` int(11) NOT NULL,
  `BookingID` int(11) DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `PaymentMethod` varchar(30) DEFAULT NULL,
  `PaymentStatus` varchar(20) DEFAULT NULL,
  `PaymentDate` date DEFAULT NULL,
  `TransactionID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`PaymentID`, `BookingID`, `Amount`, `PaymentMethod`, `PaymentStatus`, `PaymentDate`, `TransactionID`) VALUES
(1, 1, 12000.00, 'Bkash', 'Paid', '2025-07-05', 'BKX9384721'),
(2, 2, 8800.00, 'Card', 'Paid', '2025-08-25', 'CRD8291736'),
(3, 3, 9500.00, 'Bkash', 'Paid', '2025-03-20', 'BKX7291834'),
(4, 4, 18000.00, 'Nagad', 'Pending', '2025-09-01', 'NGD1239482'),
(5, 5, 9000.00, 'Rocket', 'Paid', '2025-05-10', 'RKT9384721'),
(6, 6, 9200.00, 'Card', 'Paid', '2025-08-15', 'CRD1938472'),
(7, 7, 9000.00, 'Bkash', 'Paid', '2025-02-15', 'BKX8273645'),
(8, 8, 17500.00, 'Bkash', 'Paid', '2025-10-01', 'BKX1928374'),
(9, 9, 15000.00, 'Card', 'Refunded', '2025-06-15', 'CRD8372619'),
(10, 10, 21000.00, 'Nagad', 'Paid', '2025-07-25', 'NGD9182736'),
(11, 11, 14000.00, 'Bkash', 'Paid', '2025-01-25', 'BKX2837465'),
(12, 12, 9500.00, 'Card', 'Paid', '2025-07-20', 'CRD9827364'),
(13, 13, 15000.00, 'Bkash', 'Paid', '2025-09-05', 'BKX1927364'),
(14, 14, 18000.00, 'Rocket', 'Paid', '2025-04-18', 'RKT1928374'),
(15, 15, 9200.00, 'Card', 'Paid', '2025-08-22', 'CRD9182734'),
(16, 16, 8000.00, 'Bkash', 'Refunded', '2025-03-15', 'BKX1937462'),
(17, 17, 9000.00, 'Bkash', 'Paid', '2025-09-10', 'BKX8273641'),
(18, 18, 16000.00, 'Card', 'Paid', '2025-08-28', 'CRD1827364'),
(19, 19, 17500.00, 'Nagad', 'Pending', '2025-07-15', 'NGD7283641'),
(20, 20, 14000.00, 'BankTransfer', 'Paid', '2025-04-20', 'BNK9384726'),
(21, 21, 9200.00, 'Bkash', 'Paid', '2025-08-22', 'BKX8372619'),
(22, 22, 18000.00, 'Card', 'Paid', '2025-02-10', 'CRD7362819'),
(23, 23, 9200.00, 'Bkash', 'Refunded', '2025-07-30', 'BKX2837462'),
(24, 24, 18000.00, 'Card', 'Paid', '2025-09-15', 'CRD2837462'),
(25, 25, 17500.00, 'Nagad', 'Paid', '2025-04-05', 'NGD8372619'),
(26, 26, 8500.00, 'Bkash', 'Paid', '2025-03-05', 'BKX9283746'),
(27, 27, 9200.00, 'Card', 'Paid', '2025-06-10', 'CRD8374621'),
(28, 28, 6000.00, 'Bkash', 'Paid', '2025-08-23', 'BKX8273648'),
(29, 29, 9500.00, 'Card', 'Paid', '2025-09-10', 'CRD7283647'),
(30, 30, 9000.00, 'Bkash', 'Paid', '2025-07-20', 'BKX9283647'),
(31, 31, 9000.00, 'Card', 'Paid', '2025-05-12', 'CRD1938476'),
(32, 32, 9100.00, 'Bkash', 'Paid', '2025-08-30', 'BKX9182736'),
(33, 33, 9500.00, 'Nagad', 'Paid', '2025-07-08', 'NGD1928374'),
(34, 34, 16000.00, 'Bkash', 'Paid', '2025-03-12', 'BKX8273649'),
(35, 35, 4500.00, 'BankTransfer', 'Paid', '2025-08-26', 'BNK8273649'),
(36, 36, 8500.00, 'Bkash', 'Paid', '2025-09-12', 'BKX8372612'),
(37, 37, 15000.00, 'Card', 'Paid', '2025-07-05', 'CRD8372612'),
(38, 38, 9000.00, 'Bkash', 'Paid', '2025-04-12', 'BKX9283741'),
(39, 39, 18000.00, 'Rocket', 'Paid', '2025-08-30', 'RKT8372612'),
(40, 40, 9000.00, 'Card', 'Paid', '2025-07-20', 'CRD8273641'),
(41, 41, 12000.00, 'Bkash', 'Paid', '2025-09-02', 'BKX8372613'),
(42, 42, 12000.00, 'Card', 'Pending', '2025-02-25', 'CRD9283742'),
(43, 43, 14000.00, 'Bkash', 'Paid', '2025-07-20', 'BKX8273642'),
(44, 44, 8700.00, 'Card', 'Paid', '2025-08-20', 'CRD8372614'),
(45, 45, 8700.00, 'Bkash', 'Paid', '2025-05-20', 'BKX8273643'),
(46, 46, 18000.00, 'Card', 'Paid', '2025-08-25', 'CRD8273644'),
(47, 47, 9200.00, 'Cash', 'Paid', '2025-09-20', 'CSH8273644'),
(48, 48, 9000.00, 'Bkash', 'Paid', '2025-08-01', 'BKX9283743'),
(49, 49, 18000.00, 'Card', 'Paid', '2025-07-10', 'CRD8273645'),
(50, 50, 15000.00, 'Bkash', 'Paid', '2025-03-25', 'BKX8273646'),
(51, 51, 9000.00, 'Bkash', 'Paid', '2025-08-28', 'BKX8372615'),
(52, 52, 15000.00, 'Card', 'Paid', '2025-09-08', 'CRD9283744'),
(53, 53, 7000.00, 'Bkash', 'Paid', '2025-11-01', 'BKX8273647'),
(54, 54, 20000.00, 'Card', 'Paid', '2025-07-20', 'CRD8273646'),
(55, 55, 9200.00, 'Bkash', 'Paid', '2025-06-15', 'BKX8372616'),
(56, 56, 9000.00, 'BankTransfer', 'Paid', '2025-08-15', 'BNK9283745'),
(57, 57, 21000.00, 'Bkash', 'Paid', '2025-08-25', 'BKX8273648'),
(58, 58, 16000.00, 'Card', 'Paid', '2025-07-15', 'CRD8273647'),
(59, 59, 9500.00, 'Bkash', 'Paid', '2025-08-26', 'BKX8372617'),
(60, 60, 14000.00, 'Card', 'Paid', '2025-09-12', 'CRD9283746'),
(61, 61, 9300.00, 'Bkash', 'Paid', '2025-07-22', 'BKX8273649'),
(62, 62, 15000.00, 'Card', 'Paid', '2025-08-22', 'CRD8273648'),
(63, 63, 17500.00, 'Bkash', 'Paid', '2025-10-15', 'BKX8372618'),
(64, 64, 12000.00, 'Card', 'Paid', '2025-08-23', 'CRD8273649'),
(65, 65, 20000.00, 'BankTransfer', 'Paid', '2025-10-05', 'BNK8372619'),
(66, 66, 20000.00, 'Bkash', 'Paid', '2025-06-25', 'BKX9283747'),
(67, 67, 14000.00, 'Card', 'Paid', '2025-08-28', 'CRD8273650'),
(68, 68, 9100.00, 'Cash', 'Paid', '2025-09-10', 'CSH8372620'),
(69, 69, 9000.00, 'Bkash', 'Paid', '2025-07-22', 'BKX8273651'),
(70, 70, 9000.00, 'Card', 'Paid', '2025-09-12', 'CRD8372621');

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `ReviewID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `TourID` int(11) DEFAULT NULL,
  `Rating` int(11) DEFAULT NULL,
  `Comment` text DEFAULT NULL,
  `ReviewDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`ReviewID`, `CustomerID`, `TourID`, `Rating`, `Comment`, `ReviewDate`) VALUES
(1, 1, 5, 5, 'The Sajek Valley Cloud Tour was a dream! Waking up at 5 AM to see the clouds floating below our balcony was a core memory. The guide (ID: 16) was exceptionally punctual and knew the best spots for photography. Highly recommended for couples!', '2025-12-10'),
(2, 2, 3, 4, 'Decent trip to Inani. The beach was much quieter than the main Cox’s Bazar area, which we loved. Hotel service at the resort was 4/5, but the sunset made up for everything.', '2025-11-28'),
(3, 3, 7, 5, 'Bandarban never disappoints. The Nilachal view is the best in Bangladesh.', '2025-10-15'),
(4, 4, 1, 4, 'Good organization for the Cox’s Bazar adventure. The group size was perfect (20 people), so it didn’t feel too crowded. Price is fair for a 3-day trip.', '2025-11-15'),
(5, 5, 10, 5, 'Rangamati is so peaceful. The boat ride on Kaptai Lake was the highlight. The guide was very knowledgeable about the local tribal culture.', '2025-11-01'),
(6, 6, 8, 4, 'Boga Lake was tough to reach but worth it. If you love adventure and don’t mind basic accommodation, go for it. The trekking was intense!', '2025-12-25'),
(7, 7, 4, 3, 'Himchari was okay. The waterfall didn’t have much water since we went late in the season. Management was fine, but I expected more for 8000 BDT.', '2025-10-20'),
(8, 8, 12, 5, 'Ratargul is a must-see. It felt like we were in a movie scene. The swamp forest is so quiet and green. Make sure to tip your boatman!', '2026-10-01'),
(9, 9, 6, 4, 'Nilgiri mountain retreat was beautiful. A bit cold at night, so bring jackets.', '2025-11-25'),
(10, 10, 9, 5, 'Keokradong trekking was the most challenging thing I’ve done this year. Reaching the peak and staying at the local cottage was a 10/10 experience. Guide ID 21 was a lifesaver during the steep climbs.', '2025-11-12'),
(11, 11, 14, 4, 'Lalakhal has such a unique blue color. The boat journey is very photogenic.', '2025-11-20'),
(12, 12, 2, 5, 'Saint Martin is paradise. The seafood was fresh and the coral beach is stunning. We spent hours just sitting by the water. Worth every penny of the 18,000 BDT.', '2025-12-20'),
(13, 13, 5, 5, 'Second time in Sajek, still as magical as the first. The clouds were everywhere!', '2025-12-10'),
(14, 14, 11, 4, 'Very relaxing boat ride. Perfect for a family getaway.', '2025-11-20'),
(15, 15, 7, 4, 'Bandarban hills were majestic. The arrangement was professional.', '2025-10-12'),
(16, 16, 15, 5, 'Srimangal was so green! Walking through the tea gardens during the morning mist was incredibly peaceful. The hotel (ID: 34) was very comfortable.', '2025-10-18'),
(17, 17, 13, 4, 'Jaflong river was beautiful but be prepared for the crowd near the border.', '2025-11-10'),
(18, 18, 16, 5, 'Lawachara is a gem. We saw some rare monkeys and the rainforest canopy is thick and beautiful. Great for nature photography.', '2026-10-05'),
(19, 19, 6, 2, 'The views were great but our transport was delayed by 3 hours. Really frustrated with the logistics on this specific day.', '2025-11-26'),
(20, 20, 18, 5, 'Sundarbans Tiger Trail was a lifetime experience. We didn’t see a tiger, but the deer and crocodiles were everywhere. The boat was well-equipped.', '2025-12-15'),
(21, 21, 17, 4, 'Madhabkunda waterfall is massive! The hike up is a bit slippery, be careful.', '2025-11-25'),
(22, 22, 1, 5, 'Beach was clean, hotel was top-notch. Will book again.', '2025-11-15'),
(23, 23, 3, 4, 'Standard service. No complaints.', '2025-11-28'),
(24, 24, 20, 5, 'Kuakata is amazing because you see both sunrise and sunset from the same spot. The beach is much wider than Cox’s Bazar. Very serene experience.', '2025-10-28'),
(25, 25, 9, 4, 'Hard trek but the view from the top makes you forget the pain.', '2025-11-12'),
(26, 26, 8, 4, 'Camping at Boga Lake was a bit cold but the bonfire made it special.', '2025-12-25'),
(27, 27, 12, 5, 'A literal swamp forest. Loved every minute of the silence.', '2026-10-01'),
(28, 28, 21, 4, 'Educational tour. Learned a lot about mangroves.', '2025-11-15'),
(29, 29, 5, 5, 'Sajek is love.', '2025-12-10'),
(30, 30, 22, 4, 'Tanguar Haor in a boat during the rain is something everyone should experience once. The water goes on for miles.', '2026-09-25'),
(31, 31, 7, 4, 'Bandarban trip was well coordinated.', '2025-10-12'),
(32, 32, 14, 5, 'River water is so clear you can see the bottom. Lalakhal is a hidden gem.', '2025-11-20'),
(33, 33, 10, 4, 'Kaptai lake was very serene. Good for relaxing.', '2025-11-01'),
(34, 34, 18, 5, 'The wildlife expedition was very professional and safe.', '2025-12-15'),
(35, 35, 19, 4, 'Kotka beach is so isolated and beautiful. Total peace.', '2025-12-20'),
(36, 36, 15, 5, 'If you need a break from Dhaka’s noise, go to Srimangal. The tea gardens are therapeutic.', '2025-10-18'),
(37, 37, 11, 4, 'Pleasant boat ride on the lake.', '2025-11-20'),
(38, 38, 24, 5, 'Nijhum Dwip is the place for deer spotting. We saw hundreds of them at dawn. Truly an island escape.', '2025-12-05'),
(39, 39, 16, 3, 'Rainforest was great but the toilets at the campsite were not well maintained.', '2026-10-05'),
(40, 40, 2, 5, 'Best trip ever! Saint Martin is the crown jewel of our tourism.', '2025-12-20'),
(41, 41, 13, 4, 'River view was great, but food options were limited.', '2025-11-10'),
(42, 42, 6, 4, 'Mountain retreat was relaxing.', '2025-11-25'),
(43, 43, 25, 5, 'Sonargaon is full of history. Panam City felt like walking through a ghost town from the past. Very well preserved.', '2026-09-18'),
(44, 44, 17, 4, 'The waterfall sound is so relaxing.', '2025-11-25'),
(45, 45, 21, 4, 'Mangrove tour was good. Pack mosquito repellent!', '2025-11-15'),
(46, 46, 9, 5, 'Keokradong is a must for every trekker.', '2025-11-12'),
(47, 47, 26, 4, 'Ahsan Manzil is beautiful. The city tour was very informative.', '2026-09-12'),
(48, 48, 8, 5, 'Boga Lake has some mystical vibe. Loved it.', '2025-12-25'),
(49, 49, 12, 4, 'Swamp forest tour was nice but too short.', '2026-10-01'),
(50, 50, 23, 4, 'Hakaluki Haor is great for bird lovers. We saw many migratory birds.', '2025-12-12'),
(51, 51, 5, 5, 'Sunrise at Sajek is worth the long journey.', '2025-12-10'),
(52, 52, 14, 4, 'Water was so blue! Great trip.', '2025-11-20'),
(53, 53, 7, 4, 'Hills of Bandarban are calling again.', '2025-10-12'),
(54, 54, 20, 5, 'Kuakata is much better than Cox’s Bazar if you want peace.', '2025-10-28'),
(55, 55, 3, 4, 'Relaxing trip to Inani.', '2025-11-28'),
(56, 56, 18, 5, 'Sundarbans was mysterious and beautiful.', '2025-12-15'),
(57, 57, 11, 4, 'Kaptai boat journey was refreshing.', '2025-11-20'),
(58, 58, 22, 4, 'Tanguar Haor was breathtaking.', '2026-09-25'),
(59, 59, 6, 3, 'Okay trip, but long travel.', '2025-11-25'),
(60, 60, 24, 5, 'Nijhum Dwip was like a dream.', '2025-12-05'),
(61, 61, 15, 5, 'Tea garden was refreshing.', '2025-10-18'),
(62, 62, 10, 4, 'Lake scenery was good.', '2025-11-01'),
(63, 63, 16, 4, 'Forest walk was nice.', '2026-10-05'),
(64, 64, 21, 4, 'Interesting mangrove forest.', '2025-11-15'),
(65, 65, 19, 4, 'Wild life was amazing.', '2025-12-20'),
(66, 66, 13, 5, 'Specatcular views at Jaflong.', '2025-11-10'),
(67, 67, 2, 5, 'Saint Martin island is simply beautiful.', '2025-12-20'),
(68, 68, 23, 4, 'Haor region is very calm.', '2025-12-12'),
(69, 69, 8, 4, 'Hill scenery was great.', '2025-12-25'),
(70, 70, 17, 4, 'Waterfall was nice.', '2025-11-25'),
(71, 71, 12, 5, 'Memorable boat journey.', '2026-10-01'),
(72, 72, 6, 4, 'Helpful guide and nice hills.', '2025-11-25'),
(73, 73, 24, 5, 'Perfect for vacation.', '2025-12-05'),
(74, 74, 9, 4, 'Great trekking route.', '2025-11-12'),
(75, 75, 18, 5, 'Adventurous Sundarbans journey.', '2025-12-15'),
(76, 76, 22, 4, 'Calm haor boat ride.', '2026-09-25'),
(77, 77, 14, 4, 'Amazing water color.', '2025-11-20'),
(78, 78, 3, 3, 'Average experience.', '2025-11-28'),
(79, 79, 5, 5, 'Magical Sajek views.', '2025-12-10'),
(80, 80, 11, 4, 'Relaxing lake environment.', '2025-11-20');

-- --------------------------------------------------------

--
-- Table structure for table `tourguide`
--

CREATE TABLE `tourguide` (
  `GuideID` int(11) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Phone` varchar(11) NOT NULL,
  `ExperienceYears` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tourguide`
--

INSERT INTO `tourguide` (`GuideID`, `FirstName`, `LastName`, `Phone`, `ExperienceYears`) VALUES
(1, 'Rahim', 'Uddin', '01712034567', 6),
(2, 'Karim', 'Ahmed', '01815023456', 8),
(3, 'Tanvir', 'Hasan', '01914098765', 5),
(4, 'Sabbir', 'Hossain', '01617011223', 4),
(5, 'Mahmud', 'Rahman', '01711022334', 10),
(6, 'Arif', 'Islam', '01819988776', 7),
(7, 'Shakil', 'Khan', '01914556677', 3),
(8, 'Nayeem', 'Ahmed', '01712349876', 6),
(9, 'Rashid', 'Karim', '01817654321', 9),
(10, 'Imran', 'Hossain', '01918765432', 5),
(11, 'Sanjida', 'Akter', '01713456789', 4),
(12, 'Nusrat', 'Jahan', '01814321234', 6),
(13, 'Farzana', 'Rahman', '01916789012', 3),
(14, 'Rokeya', 'Sultana', '01719887766', 7),
(15, 'Tania', 'Islam', '01817665544', 2),
(16, 'Uchai', 'Marma', '01716543211', 8),
(17, 'Aung', 'Marma', '01815432119', 6),
(18, 'Kyaw', 'Marma', '01917654329', 5),
(19, 'Mong', 'Marma', '01718889991', 9),
(20, 'Bimal', 'Chakma', '01819994411', 10),
(21, 'Ratan', 'Chakma', '01913335577', 7),
(22, 'Jibon', 'Chakma', '01712221133', 6),
(23, 'Sujon', 'Chakma', '01814443322', 4),
(24, 'Tapan', 'Tripura', '01915554466', 5),
(25, 'Rakesh', 'Tripura', '01713332244', 6),
(26, 'Suman', 'Tripura', '01812225588', 3),
(27, 'Lal', 'Mro', '01918882211', 8),
(28, 'Khyai', 'Mro', '01717773355', 5),
(29, 'David', 'Costa', '01819990011', 9),
(30, 'Michael', 'Gomes', '01916661122', 11),
(31, 'Sadiq', 'Rahman', '01715557788', 4),
(32, 'Hafiz', 'Uddin', '01818889922', 12),
(33, 'Salman', 'Mahmud', '01917770033', 5),
(34, 'Rafi', 'Ahmed', '01719991122', 2),
(35, 'Shuvo', 'Hasan', '01816664455', 6),
(36, 'Anika', 'Rahman', '01918887766', 3),
(37, 'Mim', 'Akter', '01717778899', 4),
(38, 'Sadia', 'Islam', '01814445566', 5),
(39, 'Thui', 'Chak', '01919993344', 7),
(40, 'Aye', 'Khumi', '01716668822', 6);

-- --------------------------------------------------------

--
-- Table structure for table `tourpackage`
--

CREATE TABLE `tourpackage` (
  `TourID` int(11) NOT NULL,
  `TourName` varchar(100) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `MaxSeats` int(11) DEFAULT NULL,
  `LocationID` int(11) DEFAULT NULL,
  `GuideID` int(11) DEFAULT NULL,
  `HotelID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tourpackage`
--

INSERT INTO `tourpackage` (`TourID`, `TourName`, `StartDate`, `EndDate`, `Price`, `MaxSeats`, `LocationID`, `GuideID`, `HotelID`) VALUES
(1, 'Coxs Bazar Sea Adventure', '2025-11-05', '2025-11-08', 12000.00, 20, 1, 5, 2),
(2, 'Saint Martin Coral Island Tour', '2025-12-10', '2025-12-14', 18000.00, 15, 2, 8, 7),
(3, 'Inani Beach Relax Trip', '2025-11-20', '2025-11-23', 9500.00, 18, 3, 3, 9),
(4, 'Himchari Waterfall Exploration', '2025-10-12', '2025-10-15', 8000.00, 16, 4, 12, 11),
(5, 'Sajek Valley Cloud Tour', '2025-12-01', '2025-12-04', 14000.00, 15, 5, 16, 13),
(6, 'Nilgiri Mountain Retreat', '2025-11-18', '2025-11-21', 15000.00, 12, 6, 17, 16),
(7, 'Nilachal Scenic Hill Tour', '2025-10-05', '2025-10-08', 9000.00, 14, 7, 19, 18),
(8, 'Boga Lake Adventure Camp', '2025-12-15', '2025-12-18', 16000.00, 10, 8, 20, 20),
(9, 'Keokradong Trekking Tour', '2025-11-02', '2025-11-06', 17500.00, 12, 9, 21, 22),
(10, 'Rangamati Lake Escape', '2025-10-22', '2025-10-25', 8500.00, 20, 10, 22, 24),
(11, 'Kaptai Lake Nature Tour', '2025-11-10', '2025-11-13', 9000.00, 18, 11, 23, 26),
(12, 'Ratargul Swamp Forest Trip', '2026-09-20', '2026-09-23', 9500.00, 16, 12, 25, 28),
(13, 'Jaflong River View Tour', '2025-10-30', '2025-11-02', 9200.00, 18, 13, 26, 30),
(14, 'Lalakhal Blue Water Tour', '2025-11-12', '2025-11-15', 9800.00, 18, 14, 27, 32),
(15, 'Srimangal Tea Garden Escape', '2025-10-08', '2025-10-11', 8700.00, 15, 15, 28, 34),
(16, 'Lawachara Rainforest Adventure', '2026-09-28', '2026-10-01', 9200.00, 14, 16, 30, 36),
(17, 'Madhabkunda Waterfall Trip', '2025-11-16', '2025-11-19', 9700.00, 16, 17, 31, 38),
(18, 'Sundarbans Tiger Trail', '2025-12-05', '2025-12-09', 20000.00, 12, 18, 32, 40),
(19, 'Kotka Wildlife Expedition', '2025-12-12', '2025-12-16', 21000.00, 10, 19, 33, 41),
(20, 'Kuakata Sunrise Sunset Tour', '2025-10-18', '2025-10-21', 9500.00, 18, 20, 34, 42),
(21, 'Fatrar Char Mangrove Tour', '2025-11-06', '2025-11-09', 8800.00, 16, 21, 35, 43),
(22, 'Tanguar Haor Boat Adventure', '2026-09-15', '2026-09-18', 9300.00, 15, 22, 36, 44),
(23, 'Hakaluki Haor Bird Watching', '2025-12-03', '2025-12-06', 9100.00, 14, 23, 37, 45),
(24, 'Nijhum Dwip Island Escape', '2025-11-25', '2025-11-29', 15000.00, 12, 24, 38, 46),
(25, 'Sonargaon Heritage Tour', '2026-09-10', '2026-09-12', 6000.00, 25, 25, 39, 47),
(26, 'Ahsan Manzil City Tour', '2026-09-05', '2026-09-06', 4500.00, 30, 26, 10, 48),
(27, 'Mahasthangarh History Tour', '2025-10-14', '2025-10-16', 7000.00, 20, 27, 12, 49),
(28, 'Paharpur Buddhist Heritage Tour', '2025-11-07', '2025-11-10', 7800.00, 18, 28, 14, 50),
(29, 'Somapura Archaeological Tour', '2025-12-20', '2025-12-23', 8200.00, 18, 29, 18, 48),
(30, 'Kantaji Temple Cultural Trip', '2025-10-28', '2025-10-30', 7200.00, 20, 30, 22, 49);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`BookingID`),
  ADD KEY `fk_booking_customer` (`CustomerID`),
  ADD KEY `fk_booking_tour` (`TourID`);

--
-- Indexes for table `bookingdetail`
--
ALTER TABLE `bookingdetail`
  ADD PRIMARY KEY (`BookingID`,`DetailID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustomerID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `customerphone`
--
ALTER TABLE `customerphone`
  ADD PRIMARY KEY (`CustomerID`,`PhoneNumber`);

--
-- Indexes for table `guidelanguage`
--
ALTER TABLE `guidelanguage`
  ADD PRIMARY KEY (`GuideID`,`Language`);

--
-- Indexes for table `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`HotelID`),
  ADD KEY `fk_hotel_location` (`LocationID`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`LocationID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`PaymentID`),
  ADD UNIQUE KEY `BookingID` (`BookingID`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`ReviewID`),
  ADD KEY `fk_review_customer` (`CustomerID`),
  ADD KEY `fk_review_tour` (`TourID`);

--
-- Indexes for table `tourguide`
--
ALTER TABLE `tourguide`
  ADD PRIMARY KEY (`GuideID`);

--
-- Indexes for table `tourpackage`
--
ALTER TABLE `tourpackage`
  ADD PRIMARY KEY (`TourID`),
  ADD KEY `fk_tourpackage_location` (`LocationID`),
  ADD KEY `fk_tourpackage_guide` (`GuideID`),
  ADD KEY `fk_tourpackage_hotel` (`HotelID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `BookingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `CustomerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `hotel`
--
ALTER TABLE `hotel`
  MODIFY `HotelID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `LocationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `ReviewID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `tourguide`
--
ALTER TABLE `tourguide`
  MODIFY `GuideID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `tourpackage`
--
ALTER TABLE `tourpackage`
  MODIFY `TourID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `fk_booking_customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  ADD CONSTRAINT `fk_booking_tour` FOREIGN KEY (`TourID`) REFERENCES `tourpackage` (`TourID`);

--
-- Constraints for table `bookingdetail`
--
ALTER TABLE `bookingdetail`
  ADD CONSTRAINT `fk_bookingdetail_booking` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`);

--
-- Constraints for table `customerphone`
--
ALTER TABLE `customerphone`
  ADD CONSTRAINT `fk_customerphone_customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`);

--
-- Constraints for table `guidelanguage`
--
ALTER TABLE `guidelanguage`
  ADD CONSTRAINT `fk_guidelanguage_guide` FOREIGN KEY (`GuideID`) REFERENCES `tourguide` (`GuideID`);

--
-- Constraints for table `hotel`
--
ALTER TABLE `hotel`
  ADD CONSTRAINT `fk_hotel_location` FOREIGN KEY (`LocationID`) REFERENCES `location` (`LocationID`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_payment_booking` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `fk_review_customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  ADD CONSTRAINT `fk_review_tour` FOREIGN KEY (`TourID`) REFERENCES `tourpackage` (`TourID`);

--
-- Constraints for table `tourpackage`
--
ALTER TABLE `tourpackage`
  ADD CONSTRAINT `fk_tourpackage_guide` FOREIGN KEY (`GuideID`) REFERENCES `tourguide` (`GuideID`),
  ADD CONSTRAINT `fk_tourpackage_hotel` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`),
  ADD CONSTRAINT `fk_tourpackage_location` FOREIGN KEY (`LocationID`) REFERENCES `location` (`LocationID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
