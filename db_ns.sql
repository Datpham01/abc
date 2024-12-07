-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2024 at 10:16 AM
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
-- Database: `db_ns`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` bigint(20) NOT NULL,
  `category_image` varchar(255) DEFAULT NULL,
  `category_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_image`, `category_name`) VALUES
(1, NULL, 'Rau củ'),
(2, NULL, 'Trái cây'),
(3, NULL, 'Ngũ cốc'),
(4, NULL, 'Hạt'),
(5, NULL, 'Món ngon');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `rate_date` datetime DEFAULT NULL,
  `rating` double DEFAULT NULL,
  `order_detail_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `content`, `rate_date`, `rating`, `order_detail_id`, `product_id`, `user_id`) VALUES
(1, 'NGON', '2024-11-28 00:00:00', 0, NULL, 7, 3),
(2, 'giao hàng nhanh\r\nhỗ trợ nhiệt tình', '2024-11-28 00:00:00', 0, NULL, 4, 2),
(3, 'Chất lượng: Bắp cải tươi, lá xanh mướt, không có dấu hiệu bị sâu hay dập. Khi sờ vào, bắp chắc tay, nặng cân.\r\nHương vị: Ngọt tự nhiên, giòn khi ăn sống và không bị mềm nhũn sau khi nấu chín. Phù hợp để làm salad, xào, hoặc nấu canh.🥰🥰', '2024-11-28 00:00:00', 0, NULL, 7, 2),
(4, 'ngon', '2024-12-07 00:00:00', 0, NULL, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `favorite_id` bigint(20) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`favorite_id`, `product_id`, `user_id`) VALUES
(5, 2, 2),
(6, 7, 9);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` bigint(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `address`, `amount`, `order_date`, `phone`, `status`, `user_id`) VALUES
(1, 'Hà Nội', 2662900, '2024-11-25 00:00:00', '01234567783', 2, 2),
(2, 'bắc giang', 1512280, '2024-11-25 00:00:00', '0278377631', 2, 3),
(3, 'kiên giang', 97000, '2024-11-25 00:00:00', '4928682462', 3, 3),
(4, 'nghệ an', 32400, '2024-11-26 00:00:00', '0976644428', 2, 2),
(5, 'An Giang', 263340, '2024-11-26 00:00:00', '0435478899', 2, 2),
(6, 'An Giang', 263340, '2024-11-26 00:00:00', '0435478899', 2, 2),
(7, 'Hà Nam', 34455, '2024-11-26 00:00:00', '084782466', 3, 2),
(8, 'test', 12210, '2024-11-26 00:00:00', '0789378334', 3, 2),
(9, 'test2', 4050, '2024-11-26 00:00:00', '767454456', 3, 2),
(10, 'Hà Nội', 61050, '2024-11-26 00:00:00', '0884172786', 2, 2),
(11, 'con lon', 13020, '2024-11-26 00:00:00', '0998989', 3, 2),
(12, 'Hà Nam', 97000, '2024-11-26 00:00:00', '094767444', 3, 2),
(13, 'Hà Tĩnh', 13020, '2024-11-26 00:00:00', '074897453', 2, 2),
(14, 'PHÚ QUỐC', 33070, '2024-11-26 00:00:00', '986532677', 3, 2),
(15, 'Hà Nội', 32400, '2024-11-27 00:00:00', '07855644667', 3, 1),
(16, 'hà nội', 23000, '2024-11-28 00:00:00', '0986345365', 3, 2),
(17, 'Hà nội', 194000, '2024-11-29 00:00:00', '12345678', 2, 2),
(18, 'Huế', 113000, '2024-12-03 00:00:00', '0636725542', 2, 8),
(19, 'Hà Nội', 32400, '2024-12-04 00:00:00', '024372376', 2, 8),
(20, 'Hà Nội', 32400, '2024-12-04 00:00:00', '042767833', 2, 8),
(21, 'Thanh Hóa', 97000, '2024-12-05 00:00:00', '087834665', 2, 9),
(22, 'Hà nội', 1435000, '2024-12-07 00:00:00', '0874364613', 2, 9),
(23, 'bắc ninh', 19000, '2024-12-07 00:00:00', '094848882', 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_detail_id` bigint(20) NOT NULL,
  `price` double DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`order_detail_id`, `price`, `quantity`, `order_id`, `product_id`) VALUES
(1, 15000, 100, 1, 1),
(2, 20000, 60, 1, 2),
(3, 1000, 70, 1, 3),
(4, 20000, 37, 2, 2),
(5, 1000, 21, 2, 3),
(6, 25000, 15, 2, 4),
(7, 12000, 18, 2, 5),
(8, 5000, 27, 2, 6),
(9, 21000, 18, 2, 8),
(10, 100000, 1, 3, 3),
(11, 40000, 1, 4, 10),
(12, 199000, 1, 5, 1),
(13, 20000, 1, 5, 2),
(14, 100000, 1, 5, 3),
(15, 25000, 1, 5, 4),
(16, 199000, 1, 6, 1),
(17, 20000, 1, 6, 2),
(18, 100000, 1, 6, 3),
(19, 25000, 1, 6, 4),
(20, 28900, 1, 7, 5),
(21, 7000, 1, 7, 7),
(22, 37000, 1, 8, 9),
(23, 5000, 1, 9, 6),
(24, 37000, 5, 10, 9),
(25, 21000, 1, 11, 8),
(26, 100000, 1, 12, 3),
(27, 21000, 1, 13, 8),
(28, 25000, 1, 14, 4),
(29, 5000, 1, 14, 6),
(30, 21000, 1, 14, 8),
(31, 40000, 1, 15, 10),
(32, 25000, 1, 16, 4),
(33, 7000, 1, 16, 7),
(34, 100000, 2, 17, 3),
(35, 100000, 1, 18, 3),
(36, 25000, 1, 18, 4),
(37, 40000, 1, 19, 10),
(38, 40000, 1, 20, 10),
(39, 100000, 1, 21, 3),
(40, 500000, 7, 22, 1),
(41, 20000, 1, 23, 2);

-- --------------------------------------------------------

--
-- Table structure for table `origins`
--

CREATE TABLE `origins` (
  `origin_id` bigint(20) NOT NULL,
  `origin_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `origins`
--

INSERT INTO `origins` (`origin_id`, `origin_name`) VALUES
(1, 'Đà Lạt'),
(2, 'Thanh Hóa'),
(3, 'Hà Nội'),
(4, 'Bắc Ninh'),
(5, 'TP Hồ Chí Minh'),
(6, 'Hà Nam'),
(7, 'Bắc Giang'),
(8, 'Cần Thơ');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` bigint(20) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `discount` int(11) NOT NULL,
  `entered_date` datetime DEFAULT NULL,
  `price` double NOT NULL,
  `product_image` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `status` bit(1) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `favorite` bit(1) NOT NULL,
  `origin_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `description`, `discount`, `entered_date`, `price`, `product_image`, `product_name`, `quantity`, `status`, `category_id`, `favorite`, `origin_id`) VALUES
(1, 'Táo chứa nhiều vitamin C, kali, chất xơ (đặc biệt là pectin), và chất chống oxy hóa như quercetin; giúp tăng cường tiêu hóa, hỗ trợ giảm cân, bảo vệ tim mạch, thường được ăn tươi hoặc chế biến thành nước ép, mứt, bánh nướng và salad.', 59, '2024-11-14 00:00:00', 500000, 'quatao.jpg', 'Táo', -2, NULL, 2, b'0', 6),
(2, 'Dứa chứa nhiều vitamin C, mangan, và enzyme bromelain giúp hỗ trợ tiêu hóa; có tác dụng chống viêm, tăng cường miễn dịch, và thúc đẩy phục hồi cơ bắp, thường được ăn tươi hoặc chế biến thành nước ép, món tráng miệng, bánh, và canh chua.', 5, '2024-11-21 00:00:00', 20000, 'duathom.jpg', 'Dứa ( Thơm )', 501, NULL, 2, b'1', 2),
(3, 'Đậu bắp là một loại rau thuộc họ Cẩm quỳ, có hình dáng dài, màu xanh tươi và được cắt thành các khoanh tròn khi chế biến. Đậu bắp có vị nhẹ và thường được sử dụng trong các món canh, xào, hoặc nấu trong món ăn kiểu châu Á và châu Phi. Đặc biệt, đậu bắp có tác dụng tốt cho sức khỏe nhờ vào hàm lượng chất xơ và vitamin C cao, giúp hỗ trợ tiêu hóa và tăng cường hệ miễn dịch.', 3, '2024-11-08 00:00:00', 100000, 'daubap.jpg', 'Đậu bắp', 432782, NULL, 1, b'0', 2),
(4, 'Cà tím là một loại rau củ quả có màu tím đậm, hình dáng dài, hình trụ và bóng bẩy. Thịt bên trong cà tím có màu trắng, mềm, và có chứa hạt nhỏ. Cà tím được trồng phổ biến ở nhiều vùng nhiệt đới và có thể chế biến theo nhiều cách khác nhau.\r\nThành phần dinh dưỡng: Cà tím chứa ít calo và là nguồn cung cấp chất xơ, vitamin C, vitamin B6, kali và các chất chống oxy hóa. Nó cũng chứa nasunin, một loại anthocyanin giúp bảo vệ tế bào khỏi tổn thương.\r\nLợi ích sức khỏe:\r\nHỗ trợ giảm cân nhờ ít calo và chứa nhiều chất xơ.\r\nGiúp cải thiện sức khỏe tim mạch nhờ hàm lượng kali và chất chống oxy hóa.\r\nTốt cho tiêu hóa và giúp duy trì mức đường huyết ổn định.\r\nỨng dụng: Cà tím thường được chế biến trong các món xào, nướng, hay làm thành các món ăn như cà tím nướng, cà tím xào tỏi hay cà tím sốt.', 36, '2024-11-15 00:00:00', 25000, 'catim.jpg', 'Cà tím', 282, NULL, 1, b'0', 6),
(5, 'Cà rốt là một loại củ có màu cam nổi bật, hình dạng dài và nhọn. Cà rốt là một trong những loại rau củ phổ biến nhất trên thế giới, dễ trồng và chế biến thành nhiều món ăn khác nhau.\r\nThành phần dinh dưỡng: Cà rốt là nguồn cung cấp dồi dào vitamin A (dưới dạng beta-carotene), giúp cải thiện thị lực và sức khỏe da. Nó cũng cung cấp vitamin C, vitamin K, kali, và chất xơ.\r\nLợi ích sức khỏe:\r\nTốt cho thị lực và giúp bảo vệ mắt khỏi các bệnh về mắt nhờ vào beta-carotene.\r\nGiúp duy trì làn da khỏe mạnh và ngăn ngừa lão hóa da.\r\nHỗ trợ hệ tiêu hóa nhờ vào lượng chất xơ cao.\r\nỨng dụng: Cà rốt có thể ăn tươi, chế biến thành các món ăn như canh cà rốt, sinh tố cà rốt, hoặc sử dụng trong các món xào, nướng, salad.', 5, '2024-11-13 00:00:00', 28900, 'carot.jpg', 'Cà rốt', 682, NULL, 1, b'0', 4),
(6, 'Hạt tiêu, được chiết xuất từ quả của cây tiêu (Piper nigrum), là một gia vị phổ biến với vị cay nồng đặc trưng, thường được sử dụng trong các món ăn để tăng cường hương vị. Hạt tiêu có hai loại chính là tiêu đen và tiêu trắng, được phân biệt dựa trên cách chế biến quả tiêu. Không chỉ là gia vị, hạt tiêu còn có nhiều lợi ích sức khỏe, như hỗ trợ tiêu hóa, kích thích sự thèm ăn, cải thiện tuần hoàn máu và có tính kháng viêm, kháng khuẩn. Ngoài ra, hạt tiêu cũng được sử dụng trong y học cổ truyền để điều trị một số bệnh liên quan đến đường hô hấp và tiêu hóa.', 19, '2024-11-08 00:00:00', 5000, 'hattieu.jpg', 'Hạt tiêu', 4973, NULL, 4, b'0', 2),
(7, 'Bắp cải, hay còn gọi là cải bắp, là một loại rau thuộc họ Brassicaceae, có hình dáng tròn và các lá xếp chồng lên nhau. Loại rau này có nhiều màu sắc, từ xanh, tím đến trắng, và được dùng phổ biến trong các món ăn như salad, súp, hay xào. Bắp cải chứa nhiều vitamin C, K, chất xơ và các khoáng chất như kali, mangan, giúp tăng cường hệ miễn dịch, hỗ trợ tiêu hóa và duy trì sức khỏe tim mạch. Ngoài ra, bắp cải còn có đặc tính chống oxy hóa, giúp giảm nguy cơ mắc các bệnh mãn tính và chống viêm.', 0, '2024-11-20 00:00:00', 7000, 'bapcai.jpg', 'bắp cải', 100, NULL, 1, b'1', 4),
(8, 'Bí đỏ, hay còn gọi là bí ngô, là một loại quả thuộc họ Cucurbitaceae, có hình tròn hoặc dẹt và vỏ màu cam hoặc vàng tươi. Bí đỏ nổi bật với hàm lượng dinh dưỡng cao, đặc biệt là vitamin A, C, E, kali và chất xơ, rất tốt cho sức khỏe mắt, hệ miễn dịch và làn da. Bí đỏ còn chứa nhiều beta-carotene, một chất chống oxy hóa mạnh, giúp ngăn ngừa lão hóa và bảo vệ tế bào khỏi các tác nhân gây hại. Bên cạnh đó, bí đỏ còn có tác dụng giảm cân nhờ vào lượng calo thấp nhưng lại tạo cảm giác no lâu. Bí đỏ có thể được chế biến thành nhiều món ăn như canh, súp, bánh, hoặc nướng.', 38, '2024-11-29 00:00:00', 21000, 'bido.jpg', 'Bí đỏ', 659, NULL, 1, b'0', 3),
(9, 'Cà chua là một loại quả thuộc họ Solanaceae, có vỏ màu đỏ, hình tròn hoặc hình quả tim và chứa nhiều nước. Đây là nguồn cung cấp phong phú các dưỡng chất như vitamin C, vitamin A, kali và lycopene – một chất chống oxy hóa mạnh giúp bảo vệ tế bào khỏi tổn thương và làm giảm nguy cơ mắc các bệnh tim mạch và ung thư. Cà chua còn giúp cải thiện sức khỏe làn da, tăng cường hệ miễn dịch và hỗ trợ tiêu hóa nhờ vào lượng chất xơ dồi dào. Cà chua có thể được ăn tươi trong các món salad, nấu canh, chế biến thành nước ép, sốt hay làm thành các món ăn như pizza, pasta.', 67, '2024-11-21 00:00:00', 37000, 'cachua.jpg', 'Cà chua', 6571, NULL, 1, b'0', 5),
(10, 'Hành tím là một loại củ thuộc họ hành, có lớp vỏ màu tím đặc trưng và bên trong màu trắng hoặc tím nhạt. Với vị cay nhẹ và hương thơm đặc trưng, hành tím thường được sử dụng để tăng thêm hương vị cho các món ăn như xào, nấu canh, trộn gỏi hoặc làm dưa muối. Không chỉ là gia vị phổ biến, hành tím còn giàu chất chống oxy hóa, vitamin C, các hợp chất lưu huỳnh và flavonoid, giúp tăng cường hệ miễn dịch và hỗ trợ sức khỏe tim mạch.', 19, '2024-11-12 00:00:00', 40000, 'hanhtim.jpg', 'Hành tím', 664, NULL, 1, b'0', 3),
(11, 'Nem chua là một món ăn truyền thống của Việt Nam, được làm từ thịt lợn xay nhuyễn, bì lợn, tỏi, ớt, cùng các gia vị và bột gạo rang để hỗ trợ quá trình lên men. Món này thường được gói bằng lá chuối và để lên men tự nhiên trong một khoảng thời gian.\r\n\r\nNem chua có vị chua nhẹ đặc trưng từ quá trình lên men, kèm theo chút cay nồng từ ớt. Đây là một món ăn vặt hoặc khai vị rất được ưa chuộng, đặc biệt trong các dịp lễ, Tết hoặc các bữa tiệc nhỏ.', 20, '2024-12-05 00:00:00', 100000, 'nemchua.jpg', 'nem chua', 300, NULL, 5, b'0', 2);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'ROLE_ADMIN'),
(2, 'ROLE_USER'),
(3, 'ROLE_USER'),
(4, 'ROLE_USER\r\n'),
(5, 'ROLE_ADMIN'),
(6, 'ROLE_USER'),
(7, 'ROLE_USER'),
(8, 'ROLE_USER'),
(9, 'ROLE_USER'),
(10, 'ROLE_USER');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` bigint(20) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `register_date` date DEFAULT NULL,
  `status` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `avatar`, `email`, `name`, `password`, `register_date`, `status`) VALUES
(1, 'user.png', 'kumabear048@gmail.com', 'DP Gấu', '$2a$10$9ZqOwjATtEceArzlIRTtuOEoiy0Y.wMhQKWt3TAhth9h0uVfeGncq', '2024-11-24', b'1'),
(2, 'user.png', 'nguyenanhtu024@gmail.com', 'anh tú', '$2a$10$QtGkRxq3kUyGAtToFQ.qoOdeBKn9xLAPitA5kf0GeNCWYNPqBEqSS', '2024-11-24', b'1'),
(3, 'user.png', 'jvn49942@inohm.com', 'vân anh', '$2a$10$6HJKreuUfGvqd9WOa8rEs.akMWniIeEreQ4WB3GGjpcXTsPToVDUO', '2024-11-25', b'1'),
(4, 'user.png', 'myj74187@kisoq.com', 'Thanh Tú', '$2a$10$iqM.VTDBrOX8m.LMfrQlIOT2cMAXBSAfVbtbGuI.66qrLUGiTD.x6', '2024-11-25', b'1'),
(5, 'user.png', 'phamdat2001.ls@gmail.com', 'Đạt Phạm ', '$2a$10$awMKe97oSBz7sc0VFybV1usIjMcQ9cqDpJ4eVGcK6G56/f2TdPkYi', '2024-11-27', b'1'),
(6, 'user.png', 'cej81573@kisoq.com', 'thắng', '$2a$10$4lLMvh5pJHz3Fi/v2AQCZuBGEJw1ys6pz43.CoHg96rFViTVh7bmK', '2024-11-29', b'0'),
(7, 'user.png', 'datnguyen2k1.ls@gmail.com', 'Đạt Phạm', NULL, '2024-12-03', b'1'),
(8, 'user.png', 'ryv84268@kisoq.com', 'Vy', '$2a$10$49mmKca0xq/dsnathB/UhuGO.bvqIUo2SHHh.JaarekvUU745yNc.', '2024-12-03', b'1'),
(9, 'user.png', 'tco26031@kisoq.com', 'anh ', '$2a$10$8QS.xytJc.7BVyMi7.UuUu6yA7hYjZJVO6VkwPpzw9mCHRK3hpw0S', '2024-12-04', b'1'),
(10, 'user.png', 'oey92186@inohm.com', 'oanh', '$2a$10$FH3tHTkup/Jc9zmc4NPG3uaYeqjV81ZsJSeDCBTP05fUdURc8Tv/C', '2024-12-07', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `users_roles`
--

CREATE TABLE `users_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_roles`
--

INSERT INTO `users_roles` (`user_id`, `role_id`) VALUES
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 1),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKfwepd0s8syqc9s06xnqa7mdwf` (`order_detail_id`),
  ADD KEY `FK6uv0qku8gsu6x1r2jkrtqwjtn` (`product_id`),
  ADD KEY `FKqi14bvepnwtjbbaxm7m4v44yg` (`user_id`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`favorite_id`),
  ADD KEY `FK6sgu5npe8ug4o42bf9j71x20c` (`product_id`),
  ADD KEY `FK1uphh0glinnprjknyl68k1hw1` (`user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `FKel9kyl84ego2otj2accfd8mr7` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `FKjyu2qbqt8gnvno9oe9j2s2ldk` (`order_id`),
  ADD KEY `FK4q98utpd73imf4yhttm3w0eax` (`product_id`);

--
-- Indexes for table `origins`
--
ALTER TABLE `origins`
  ADD PRIMARY KEY (`origin_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
  ADD KEY `FK_origin_id` (`origin_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `UKob8kqyqqgmefl0aco34akdtpe` (`email`);

--
-- Indexes for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD KEY `FKt4v0rrweyk393bdgt107vdx0x` (`role_id`),
  ADD KEY `FKgd3iendaoyh04b95ykqise6qh` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `favorite_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `order_detail_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `origins`
--
ALTER TABLE `origins`
  MODIFY `origin_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `FK6uv0qku8gsu6x1r2jkrtqwjtn` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `FKfwepd0s8syqc9s06xnqa7mdwf` FOREIGN KEY (`order_detail_id`) REFERENCES `order_details` (`order_detail_id`),
  ADD CONSTRAINT `FKqi14bvepnwtjbbaxm7m4v44yg` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `FK1uphh0glinnprjknyl68k1hw1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `FK6sgu5npe8ug4o42bf9j71x20c` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FKel9kyl84ego2otj2accfd8mr7` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `FK4q98utpd73imf4yhttm3w0eax` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `FKjyu2qbqt8gnvno9oe9j2s2ldk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `FK_origin_id` FOREIGN KEY (`origin_id`) REFERENCES `origins` (`origin_id`),
  ADD CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD CONSTRAINT `FKgd3iendaoyh04b95ykqise6qh` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `FKt4v0rrweyk393bdgt107vdx0x` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
