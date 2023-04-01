-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 15, 2023 at 07:57 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_recipie`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_admin`
--

CREATE TABLE `tbl_admin` (
  `admin_id` int(11) NOT NULL,
  `admin_name` varchar(100) NOT NULL,
  `admin_email` varchar(100) NOT NULL,
  `admin_password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_admin`
--

INSERT INTO `tbl_admin` (`admin_id`, `admin_name`, `admin_email`, `admin_password`) VALUES
(1, 'Shinumol', 'shinumol@gmail.com', 'shinumol@123');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_comment`
--

CREATE TABLE `tbl_comment` (
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` varchar(500) NOT NULL,
  `recipie_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_event`
--

CREATE TABLE `tbl_event` (
  `event_id` int(11) NOT NULL,
  `event_date` varchar(100) NOT NULL,
  `event_details` varchar(100) NOT NULL,
  `event_title` varchar(100) NOT NULL,
  `event_poster` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_gallery`
--

CREATE TABLE `tbl_gallery` (
  `gallery_id` int(11) NOT NULL,
  `recipie_id` int(11) NOT NULL,
  `gallery_file` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_gallery`
--

INSERT INTO `tbl_gallery` (`gallery_id`, `recipie_id`, `gallery_file`) VALUES
(1, 1, 'gallery1.png'),
(2, 1, 'gallery2.png'),
(3, 2, 'egg.png'),
(4, 3, 'Green Pepper.png'),
(5, 3, 'Pepper.png'),
(6, 3, 'onion.png'),
(7, 3, 'salt.png'),
(8, 3, 'egg.png'),
(9, 3, 'gallery2.png'),
(10, 3, 'gallery1.png'),
(11, 4, 'Green Pepper.png'),
(12, 5, 'Green Pepper.png'),
(13, 6, 'Green Pepper.png'),
(14, 4, 'Pepper.png'),
(15, 7, 'Green Pepper.png'),
(16, 5, 'Pepper.png'),
(17, 6, 'Pepper.png'),
(18, 4, 'onion.png'),
(19, 4, 'salt.png'),
(20, 5, 'onion.png'),
(21, 7, 'Pepper.png'),
(22, 4, 'egg.png'),
(23, 5, 'salt.png'),
(24, 6, 'onion.png'),
(25, 4, 'gallery2.png'),
(26, 5, 'egg.png'),
(27, 6, 'salt.png'),
(28, 5, 'gallery2.png'),
(29, 4, 'gallery1.png'),
(30, 7, 'onion.png'),
(31, 6, 'egg.png'),
(32, 7, 'salt.png'),
(33, 6, 'gallery2.png'),
(34, 5, 'gallery1.png'),
(35, 7, 'egg.png'),
(36, 7, 'gallery2.png'),
(37, 6, 'gallery1.png'),
(38, 8, 'Green Pepper.png'),
(39, 7, 'gallery1.png'),
(40, 9, 'Green Pepper.png'),
(41, 10, 'Green Pepper.png'),
(42, 11, 'Green Pepper.png'),
(43, 12, 'Green Pepper.png'),
(44, 13, 'Green Pepper.png'),
(45, 8, 'Pepper.png'),
(46, 9, 'Pepper.png'),
(47, 10, 'Pepper.png'),
(48, 11, 'Pepper.png'),
(49, 12, 'Pepper.png'),
(50, 13, 'Pepper.png'),
(51, 8, 'onion.png'),
(52, 9, 'onion.png'),
(53, 10, 'onion.png'),
(54, 11, 'onion.png'),
(55, 8, 'salt.png'),
(56, 12, 'onion.png'),
(57, 13, 'onion.png'),
(58, 9, 'salt.png'),
(59, 10, 'salt.png'),
(60, 11, 'salt.png'),
(61, 8, 'egg.png'),
(62, 12, 'salt.png'),
(63, 13, 'salt.png'),
(64, 10, 'egg.png'),
(65, 9, 'egg.png'),
(66, 11, 'egg.png'),
(67, 8, 'gallery2.png'),
(68, 12, 'egg.png'),
(69, 13, 'egg.png'),
(70, 10, 'gallery2.png'),
(71, 9, 'gallery2.png'),
(72, 11, 'gallery2.png'),
(73, 13, 'gallery2.png'),
(74, 12, 'gallery2.png'),
(75, 8, 'gallery1.png'),
(76, 10, 'gallery1.png'),
(77, 9, 'gallery1.png'),
(78, 11, 'gallery1.png'),
(79, 13, 'gallery1.png'),
(80, 12, 'gallery1.png');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ingredient`
--

CREATE TABLE `tbl_ingredient` (
  `ingredient_id` int(11) NOT NULL,
  `recipie_id` int(11) NOT NULL,
  `ingredient_photo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_ingredient`
--

INSERT INTO `tbl_ingredient` (`ingredient_id`, `recipie_id`, `ingredient_photo`) VALUES
(1, 1, 'Green Pepper.png'),
(2, 1, 'Pepper.png'),
(3, 1, 'onion.png'),
(4, 1, 'salt.png'),
(5, 1, 'egg.png'),
(6, 2, 'Pepper.png'),
(7, 3, 'Green Pepper.png'),
(8, 3, 'Pepper.png'),
(9, 3, 'onion.png'),
(10, 4, 'Green Pepper.png'),
(11, 5, 'Green Pepper.png'),
(12, 6, 'Green Pepper.png'),
(13, 4, 'Pepper.png'),
(14, 7, 'Green Pepper.png'),
(15, 5, 'Pepper.png'),
(16, 4, 'onion.png'),
(17, 6, 'Pepper.png'),
(18, 7, 'Pepper.png'),
(19, 5, 'onion.png'),
(20, 6, 'onion.png'),
(21, 7, 'onion.png'),
(22, 8, 'Green Pepper.png'),
(23, 9, 'Green Pepper.png'),
(24, 10, 'Green Pepper.png'),
(25, 11, 'Green Pepper.png'),
(26, 12, 'Green Pepper.png'),
(27, 8, 'Pepper.png'),
(28, 13, 'Green Pepper.png'),
(29, 9, 'Pepper.png'),
(30, 10, 'Pepper.png'),
(31, 11, 'Pepper.png'),
(32, 12, 'Pepper.png'),
(33, 8, 'onion.png'),
(34, 13, 'Pepper.png'),
(35, 9, 'onion.png'),
(36, 10, 'onion.png'),
(37, 11, 'onion.png'),
(38, 12, 'onion.png'),
(39, 13, 'onion.png');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_like`
--

CREATE TABLE `tbl_like` (
  `like_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `recipie_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_recipie`
--

CREATE TABLE `tbl_recipie` (
  `recipie_id` int(11) NOT NULL,
  `recipie_title` varchar(100) NOT NULL,
  `recipie_details` varchar(1000) NOT NULL,
  `recipie_video` varchar(8000) NOT NULL,
  `user_id` int(11) NOT NULL,
  `recipie_status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_recipie`
--

INSERT INTO `tbl_recipie` (`recipie_id`, `recipie_title`, `recipie_details`, `recipie_video`, `user_id`, `recipie_status`) VALUES
(1, 'egg omelet', 'An egg dish made with two or three beaten eggs that are cooked until they set and then eaten as a flat or folded serving of food. Commonly served folded, the Omelet can be prepared as a plain Omelet served flat or one that is folded in half or folded into a rounded and somewhat tucked shape.', 'omeletteVideo.mp4', 1, 0),
(2, 'sdff', 'sdfs', 'Pexels Videos 4409.mp4', 1, 0),
(3, 'yt', 'j', 'Pexels Videos 4409.mp4', 1, 0),
(4, 'yt', 'j', 'Pexels Videos 4409.mp4', 1, 0),
(5, 'yt', 'j', 'Pexels Videos 4409.mp4', 1, 0),
(6, 'yt', 'j', 'Pexels Videos 4409.mp4', 1, 0),
(7, 'yt', 'j', 'Pexels Videos 4409.mp4', 1, 0),
(8, 'yt', 'j', 'Pexels Videos 4409.mp4', 1, 0),
(9, 'yt', 'j', 'Pexels Videos 4409.mp4', 1, 0),
(10, 'yt', 'j', 'Pexels Videos 4409.mp4', 1, 0),
(11, 'yt', 'j', 'Pexels Videos 4409.mp4', 1, 0),
(12, 'yt', 'j', 'Pexels Videos 4409.mp4', 1, 0),
(13, 'yt', 'j', 'Pexels Videos 4409.mp4', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_contact` varchar(100) NOT NULL,
  `image` varchar(500) NOT NULL,
  `user_place` varchar(100) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  `user_status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`user_id`, `user_name`, `user_email`, `user_contact`, `image`, `user_place`, `user_password`, `user_status`) VALUES
(57, 'Shini', 'kbvhj@fuhjbk', '9876543210', 'Pepper.png', 'hgchgv', 'khvh', 0);

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `wishlist_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `recipie_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_admin`
--
ALTER TABLE `tbl_admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `tbl_comment`
--
ALTER TABLE `tbl_comment`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `tbl_event`
--
ALTER TABLE `tbl_event`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `tbl_gallery`
--
ALTER TABLE `tbl_gallery`
  ADD PRIMARY KEY (`gallery_id`);

--
-- Indexes for table `tbl_ingredient`
--
ALTER TABLE `tbl_ingredient`
  ADD PRIMARY KEY (`ingredient_id`);

--
-- Indexes for table `tbl_like`
--
ALTER TABLE `tbl_like`
  ADD PRIMARY KEY (`like_id`);

--
-- Indexes for table `tbl_recipie`
--
ALTER TABLE `tbl_recipie`
  ADD PRIMARY KEY (`recipie_id`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`wishlist_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_admin`
--
ALTER TABLE `tbl_admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_comment`
--
ALTER TABLE `tbl_comment`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_event`
--
ALTER TABLE `tbl_event`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_gallery`
--
ALTER TABLE `tbl_gallery`
  MODIFY `gallery_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `tbl_ingredient`
--
ALTER TABLE `tbl_ingredient`
  MODIFY `ingredient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `tbl_like`
--
ALTER TABLE `tbl_like`
  MODIFY `like_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_recipie`
--
ALTER TABLE `tbl_recipie`
  MODIFY `recipie_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `wishlist_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
