-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 17, 2024 lúc 10:39 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `db_ns`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `category_id` bigint(20) NOT NULL,
  `category_image` varchar(255) DEFAULT NULL,
  `category_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`category_id`, `category_image`, `category_name`) VALUES
(1, '01.jpg', 'Rau củ'),
(2, '02.jpg', 'Trái cây'),
(3, '04.jpg', 'Ngũ cốc'),
(4, '07.jpg', 'Hạt'),
(5, '08.jpg', 'Món ngon'),
(6, '03.jpg', 'Thịt'),
(7, '05.jpg', 'Hải Sản');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comments`
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
-- Đang đổ dữ liệu cho bảng `comments`
--

INSERT INTO `comments` (`id`, `content`, `rate_date`, `rating`, `order_detail_id`, `product_id`, `user_id`) VALUES
(1, 'NGON', '2024-11-28 00:00:00', 0, NULL, 7, 3),
(2, 'giao hàng nhanh\r\nhỗ trợ nhiệt tình', '2024-11-28 00:00:00', 0, NULL, 4, 2),
(3, 'Chất lượng: Bắp cải tươi, lá xanh mướt, không có dấu hiệu bị sâu hay dập. Khi sờ vào, bắp chắc tay, nặng cân.\r\nHương vị: Ngọt tự nhiên, giòn khi ăn sống và không bị mềm nhũn sau khi nấu chín. Phù hợp để làm salad, xào, hoặc nấu canh.🥰🥰', '2024-11-28 00:00:00', 0, NULL, 7, 2),
(4, 'ngon', '2024-12-07 00:00:00', 0, NULL, 5, 2),
(5, 'táo rất ngọt và ngon😋', '2024-12-16 00:00:00', 0, NULL, 1, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `favorites`
--

CREATE TABLE `favorites` (
  `favorite_id` bigint(20) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `favorites`
--

INSERT INTO `favorites` (`favorite_id`, `product_id`, `user_id`) VALUES
(5, 2, 2),
(6, 7, 9),
(7, 11, 10),
(8, 10, 10),
(9, 3, 10),
(10, 1, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `inventories`
--

CREATE TABLE `inventories` (
  `inventory_id` int(11) NOT NULL,
  `max_capacity` int(11) NOT NULL,
  `warehouse_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `inventories`
--

INSERT INTO `inventories` (`inventory_id`, `max_capacity`, `warehouse_name`) VALUES
(1, 1000, 'kho 1'),
(2, 1000, 'kho 2'),
(3, 1000, 'kho 3');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
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
-- Đang đổ dữ liệu cho bảng `orders`
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
(23, 'bắc ninh', 19000, '2024-12-07 00:00:00', '094848882', 3, 2),
(24, 'Hà Nội', 2050000, '2024-12-07 00:00:00', '09876543218', 0, 10),
(25, 'hà nội', 160050, '2024-12-13 00:00:00', '0489378333', 2, 2),
(26, 'Test', 160050, '2024-12-13 00:00:00', '0224234556', 2, 2),
(27, 'test2', 29100, '2024-12-13 00:00:00', '0123456789', 2, 2),
(28, 'hhhh', 114000, '2024-12-13 00:00:00', '0909990999', 0, 9);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_details`
--

CREATE TABLE `order_details` (
  `order_detail_id` bigint(20) NOT NULL,
  `price` double DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order_details`
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
(41, 20000, 1, 23, 2),
(42, 500000, 10, 24, 1),
(43, 15000, 11, 25, 7),
(44, 15000, 11, 26, 7),
(45, 15000, 2, 27, 7),
(46, 20000, 6, 28, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `origins`
--

CREATE TABLE `origins` (
  `origin_id` bigint(20) NOT NULL,
  `origin_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `origins`
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
-- Cấu trúc bảng cho bảng `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `posts`
--

INSERT INTO `posts` (`id`, `author`, `content`, `created_at`, `title`) VALUES
(1, 'Admin', '<p><img alt=\"Những ruộng ớt đang lên xanh tốt sau gần 2 tháng trồng và chăm sóc. Ảnh: Thanh Tiến.\" src=\"https://i.ex-cdn.com/nongnghiep.vn/files/content/2024/11/27/a-5-115453_556-180426.jpg\" style=\"height:510px; width:680px\" /></p>\r\n<p>Trong v&agrave;i năm gần đ&acirc;y, người d&acirc;n x&atilde; Thanh Lương (<a href=\"https://nongsanviet.nongnghiep.vn/thi-xa-nghia-lo-tag148067/\" target=\"_blank\">thị x&atilde; Nghĩa Lộ</a>, tỉnh Y&ecirc;n B&aacute;i) đ&atilde; mạnh dạn li&ecirc;n kết với doanh nghiệp trồng ớt theo hướng hữu cơ, đảm bảo c&aacute;c y&ecirc;u cầu chất lượng v&agrave; an to&agrave;n để xuất khẩu quả ớt tươi sang thị trường Nhật Bản - một trong những thị trường kh&oacute; t&iacute;nh v&agrave; đ&ograve;i hỏi cao về chất lượng sản phẩm.</p>\r\n<p>Những ng&agrave;y cuối th&aacute;ng 11, thời tiết ở Nghĩa Lộ đ&atilde; se lạnh, những c&aacute;nh đồng ở x&atilde; Thanh Lương tấp nập người d&acirc;n chăm s&oacute;c rau m&agrave;u. Những ruộng ớt trồng c&aacute;ch đ&acirc;y gần 2 th&aacute;ng đang dần b&eacute;n rễ v&agrave; vươn l&ecirc;n xanh mướt, chuẩn bị cho vụ thu hoạch đầy hứa hẹn.</p>\r\n<p>Gia đ&igrave;nh chị Đ&egrave;o Thị H&eacute;o ở bản Đồng Nơi, x&atilde; Thanh Lương đ&atilde; trồng 1.000m2 ớt từ&nbsp;<a href=\"https://nongsanviet.nongnghiep.vn/vu-dong-tag1797/\" target=\"_blank\">vụ đ&ocirc;ng</a>&nbsp;năm 2023, to&agrave;n bộ sản phẩm được C&ocirc;ng ty Xuất nhập khẩu n&ocirc;ng sản Nghĩa Lộ thu mua với gi&aacute; 7.000 đồng/kg, mang lại thu nhập hơn 40 triệu đồng. Thấy hiệu quả kinh tế kh&aacute;, ngay sau vụ gặt l&uacute;a m&ugrave;a năm nay, gia đ&igrave;nh chị H&eacute;o đ&atilde; khẩn trương l&agrave;m đất, l&ecirc;n luống để trồng hơn 2.000m2 ớt.</p>\r\n<p><img alt=\"Chị Héo làm cỏ cho những khóm ớt, phần lớn diện tích ruộng được phủ nilon để hạn chế cỏ dại. Ảnh: Thanh Tiến.\" src=\"https://i.ex-cdn.com/nongnghiep.vn/files/content/2024/11/27/a-6-115553_923-180426.jpg\" style=\"height:510px; width:680px\" /></p>\r\n<p>Chị H&eacute;o chia sẻ, giống ớt được c&ocirc;ng ty cung cấp, sau khi trồng, chăm s&oacute;c khoảng 3 th&aacute;ng sẽ bắt đầu cho thu hoạch quả. Thời gian thu hoạch k&eacute;o d&agrave;i trong 3 - 4 th&aacute;ng. V&igrave; hợp đất, kh&iacute; hậu v&agrave; được hướng dẫn kỹ thuật n&ecirc;n diện t&iacute;ch ớt cho năng suất cao, gi&aacute; b&aacute;n ổn định v&agrave; thu nhập cao hơn nhiều lần so với ng&ocirc;, l&uacute;a v&agrave; c&aacute;c c&acirc;y m&agrave;u kh&aacute;c.</p>\r\n<p>Cũng như gia đ&igrave;nh chị H&eacute;o, 2 vợ chồng b&agrave; Đinh Thị Nga đang tất bật cắm cọc l&agrave;m chỗ dựa cho những&nbsp;<a href=\"https://nongsanviet.nongnghiep.vn/cay-ot-tag142448/\" target=\"_blank\">c&acirc;y ớt</a>&nbsp;khỏi bị đổ khi ra sai quả. Vụ đ&ocirc;ng năm nay gia đ&igrave;nh b&agrave; Nga trồng 2.500m2 ớt với giống ớt chu&ocirc;ng do c&ocirc;ng ty cung cấp.</p>\r\n<p>Theo b&agrave; Nga, trước đ&acirc;y to&agrave;n bộ diện t&iacute;ch n&agrave;y thường trồng dưa hấu, dưa chuột v&agrave; một số loại rau m&agrave;u trong vụ đ&ocirc;ng. Mấy năm nay b&agrave; chuyển sang&nbsp;<a href=\"https://nongsanviet.nongnghiep.vn/trong-ot-tag35386/\" target=\"_blank\">trồng ớt</a>&nbsp;cho năng suất cao, thời gian thu hoạch k&eacute;o d&agrave;i v&agrave; được doanh nghiệp bao ti&ecirc;u sản phẩm n&ecirc;n &iacute;t rủi ro, thu nhập lu&ocirc;n ổn định. Trung b&igrave;nh 1.000m2 đất trồng ớt thu hoạch được khoảng 6 tấn quả, với gi&aacute; b&aacute;n cho c&ocirc;ng ty l&agrave; 7.000 đồng/kg.&nbsp;</p>', '2024-12-15 00:03:02', 'Trồng ớt hướng hữu cơ, đáp ứng yêu cầu khắt khe để xuất sang Nhật Bản'),
(2, 'Admin', '<p>X&atilde; Nam Phương Tiến (huyện Chương Mỹ, TP H&agrave; Nội) mấy năm nay l&agrave; thi&ecirc;n đường cho những người muốn t&igrave;m cảm gi&aacute;c mạnh trong bộ m&ocirc;n nhảy d&ugrave; lượn mạo hiểm. Đ&acirc;y cũng l&agrave; nơi c&oacute; điều kiện thi&ecirc;n nhi&ecirc;n ưu đ&atilde;i m&agrave; hiếm v&ugrave;ng n&agrave;o c&oacute; thể s&aacute;nh được khi cận kề với c&aacute;c d&atilde;y n&uacute;i của tỉnh H&ograve;a B&igrave;nh, c&oacute; rừng, c&oacute; suối tạo th&agrave;nh một v&agrave;nh đai xanh thuận lợi để sản xuất&nbsp;<a href=\"https://nongsanviet.nongnghiep.vn/nong-nghiep-huu-co-tag78385/\" target=\"_blank\">n&ocirc;ng nghiệp hữu cơ</a>.</p>\n\n<p><img alt=\"Mùa bưởi vàng ở Nam Phương Tiến. Ảnh: Dương Đình Tường.\" src=\"https://i.ex-cdn.com/nongnghiep.vn/files/content/2024/12/11/dsc_1660-1153_20201222_208-135024-200424_567-161647.jpeg\" style=\"height:450px; width:680px\" /></p>\n\n<p>Điều &iacute;t ai ngờ mới chỉ hơn 20 năm trước, Nam Phương Tiến hầu hết chỉ to&agrave;n l&agrave; đồi n&uacute;i trọc v&igrave; nạn ph&aacute; rừng. Tr&ecirc;n những mảnh đất cằn cỗi ấy m&ugrave;a n&oacute;ng kh&ocirc; như rang, m&ugrave;a mưa th&igrave; b&ugrave;n nh&atilde;o nho&eacute;t, hoa m&agrave;u trồng xuống đều kh&ocirc;ng cho hiệu quả kinh tế.</p>\n\n<p>Trước thực trạng đ&oacute;, Sở NN-PTNT H&agrave; T&acirc;y (cũ) rồi sau s&aacute;p nhập l&agrave; Sở NN-PTNT H&agrave; Nội đ&atilde; c&oacute; kế hoạch chuyển đổi đất đồi g&ograve; ở đ&acirc;y sang trồng&nbsp;<a href=\"https://nongsanviet.nongnghiep.vn/buoi-dien-tag6207/\" target=\"_blank\">bưởi Diễn</a>, l&uacute;c đầu chỉ được 50ha. Từ năm 2011 - 2015 do để c&acirc;y ra hoa, thụ phấn tự nhi&ecirc;n n&ecirc;n năm được, năm mất, b&agrave; con gọi l&agrave; &ldquo;bưởi đặt v&ograve;ng&rdquo;.</p>\n\n<p>Về sau, c&aacute;c nh&agrave; khoa học đ&atilde; thực nghiệm thụ phấn bổ sung rồi trồng xen bưởi chua với bưởi Diễn để ch&uacute;ng thụ phấn ch&eacute;o khiến nạn &ldquo;bưởi đặt v&ograve;ng&rdquo; chấm dứt. Khi năng suất, sản lượng bưởi đ&atilde; tăng cao, lại xẩy ra t&igrave;nh trạng ế bởi nhiều v&ugrave;ng kh&aacute;c cũng trồng qu&aacute; nhiều bưởi Diễn. Vậy l&agrave; xu hướng chuyển sang bưởi hữu cơ để cải thiện chất lượng, an to&agrave;n thực phẩm bắt đầu ở Nam Phương Tiến.</p>\n\n<p>Trong khoảng 200ha bưởi của x&atilde;, ri&ecirc;ng HTX N&ocirc;ng nghiệp hữu cơ Nam Phương Tiến c&oacute; hơn 50ha gồm 3,5ha hữu cơ, 20ha hướng hữu cơ, 10ha được cấp&nbsp;<a href=\"https://nongsanviet.nongnghiep.vn/ma-so-vung-trong-tag71058/\" target=\"_blank\">m&atilde; số v&ugrave;ng trồng</a>&nbsp;để xuất khẩu sang thị trường ch&acirc;u &Acirc;u&hellip;</p>\n\n<p>C&aacute;c th&agrave;nh vi&ecirc;n của HTX được tập huấn kỹ c&agrave;ng về c&aacute;ch chăm s&oacute;c, b&oacute;n ph&acirc;n, phun thuốc sinh học. Việc triển khai ứng dụng tem điện tử th&ocirc;ng minh đ&atilde; gi&uacute;p truy xuất nguồn gốc, minh bạch h&oacute;a sản phẩm. Nhờ đ&oacute;, c&acirc;y bưởi đem lại thu nhập b&igrave;nh qu&acirc;n 500 - 700 triệu đồng/ha.</p>\n\n<p><img alt=\"Thụ phấn bổ sung cho bưởi. Ảnh: Dương Đình Tường.\" src=\"https://i.ex-cdn.com/nongnghiep.vn/files/content/2024/12/11/dsc_3023-200426_301-161647.jpg\" style=\"height:450px; width:680px\" /></p>\n\n<p>Về sản phẩm gạo, ở Nam Phương Tiến thời gian qua đ&atilde; c&oacute; đơn vị &aacute;p dụng nhật k&yacute; điện tử kết hợp camera hiện trường để quản l&yacute; mọi kh&acirc;u trong qu&aacute; tr&igrave;nh sản xuất theo thời gian thực. Một v&ugrave;ng sản xuất l&uacute;a theo chuẩn hữu cơ với diện t&iacute;ch 35ha, sản lượng khoảng 400 tấn/năm đ&atilde; được h&igrave;nh th&agrave;nh. Tuy nhi&ecirc;n do thị trường kh&oacute; ph&acirc;n biệt giữa sản phẩm gạo hữu cơ v&agrave; gạo b&igrave;nh thường n&ecirc;n trước đ&acirc;y c&oacute; sự hỗ trợ của nh&agrave; nước, n&ocirc;ng d&acirc;n c&ograve;n l&agrave;m theo, nay hết hỗ trợ th&igrave; lại bỏ. Đ&acirc;y l&agrave; một điều rất đ&aacute;ng để c&aacute;c nh&agrave; quản l&yacute; phải suy nghĩ, t&igrave;m c&aacute;ch giải quyết.</p>\n\n<p>Tr&ecirc;n địa b&agrave;n x&atilde; c&oacute; tới 6 HTX nhưng thực tế nhiều c&aacute;i chưa thực sự ph&aacute;t huy được vai tr&ograve; do mới chỉ đứng ra tổ chức sản xuất hay l&agrave;m đầu mối nhận sự hỗ trợ của c&aacute;c chương tr&igrave;nh, c&ograve;n bao ti&ecirc;u sản phẩm cho c&aacute;c th&agrave;nh vi&ecirc;n lại chưa l&agrave;m được. Tuy nhi&ecirc;n, c&oacute; một HTX ở ngo&agrave;i địa b&agrave;n khi nhận thấy tiềm năng n&ocirc;ng nghiệp hữu cơ của Nam Phương Tiến đ&atilde; quyết định đầu tư v&agrave;o.</p>\n\n<p>Chị Vũ Huyền Trang - Gi&aacute;m đốc HTX hữu cơ Chương Mỹ vốn l&agrave; nh&acirc;n vi&ecirc;n của Ph&ograve;ng NN-PTNT huyện Chương Mỹ nhưng năm ngo&aacute;i đ&atilde; nghỉ việc để chuy&ecirc;n t&acirc;m cho việc sản xuất&nbsp;<a href=\"https://nongsanviet.nongnghiep.vn/rau-huu-co-tag74057/\" target=\"_blank\">rau hữu cơ</a>: &ldquo;Ngay từ năm 2015 t&ocirc;i đ&atilde; sản xuất rau sạch ở x&atilde; Thụy Hương, x&atilde; Hợp Đồng rồi nhưng vừa l&agrave;m trong vừa l&agrave;m ngo&agrave;i tới năm 2023 th&igrave; nghỉ hẳn nh&agrave; nước, đổi t&ecirc;n HTX th&agrave;nh HTX hữu cơ Chương Mỹ, chọn x&atilde; Nam Phương Tiến l&agrave; v&ugrave;ng sản xuất thứ hai.</p>\n\n<p>Mới đ&acirc;y, Viện Quy hoạch v&agrave; Thiết kế n&ocirc;ng nghiệp đ&atilde; về Nam Phương Tiến để khảo s&aacute;t chuyển đổi sang n&ocirc;ng nghiệp sinh th&aacute;i. N&ocirc;ng nghiệp sinh th&aacute;i dựa tr&ecirc;n việc giảm thiểu d&ugrave;ng ph&acirc;n h&oacute;a học, thuốc BVTV h&oacute;a học. Nam Phương Tiến c&oacute; đầy đủ điều kiện để sản xuất n&ocirc;ng nghiệp sinh th&aacute;i bởi c&oacute; rừng ph&ograve;ng hộ, c&oacute; nước suối đầu nguồn, c&oacute; sự đa dạng về c&acirc;y trồng khi tr&ecirc;n n&uacute;i l&agrave; c&acirc;y rừng, dưới l&agrave; c&acirc;y ăn quả v&agrave; rau m&agrave;u xen kẽ.</p>\n\n<p>Chị Trang đ&atilde; đầu tư cho b&agrave; con l&agrave;m nh&agrave; lưới, nh&agrave; m&agrave;ng, cấp vật tư ph&acirc;n b&oacute;n, chế phẩm sinh học, đồng thời cử người chỉ đạo trực tiếp về kỹ thuật rồi thu mua lu&ocirc;n sản phẩm. HTX đ&atilde; ph&aacute;t triển được gần 2ha rau đang trong giai đoạn chuyển đổi hữu cơ v&agrave; c&oacute; kế hoạch sẽ mở rộng l&ecirc;n diện t&iacute;ch tối thiểu 5ha nữa.</p>\n\n<p>Sản lượng rau của đơn vị hiện c&ograve;n kh&aacute; khi&ecirc;m tốn, mỗi ng&agrave;y chỉ hơn 100kg nhưng gi&aacute; b&aacute;n kh&aacute; cao, trung b&igrave;nh 35.000đ/kg với đầu ra l&agrave; c&aacute;c trường học lớn rồi chuỗi kh&aacute;ch sạn, nh&agrave; h&agrave;ng ở H&agrave; Nội.</p>\n\n<p>Chị Trang h&agrave;o hứng n&oacute;i với t&ocirc;i về kế hoạch trong tương lai gần khi sản xuất kết hợp&nbsp;<a href=\"https://nongsanviet.nongnghiep.vn/du-lich-sinh-thai-tag49842/\" target=\"_blank\">du lịch sinh th&aacute;i</a>&nbsp;trải nghiệm th&agrave;nh một chuỗi, trong đ&oacute; li&ecirc;n kết với c&aacute;c trường học để l&agrave;m tour cho học sinh vừa trồng rau, vừa h&aacute;i bưởi rồi thu hoạch sản phẩm, chế biến trực tiếp tại chỗ. L&uacute;c đ&oacute; kh&aacute;ch đến đồi B&ugrave; của Nam Phương Tiến kh&ocirc;ng chỉ v&igrave; c&oacute; bộ m&ocirc;n nhảy d&ugrave; m&agrave; c&ograve;n cả v&igrave; c&oacute; những sản phẩm hữu cơ rất đặc sắc nữa.</p>\n', '2024-12-18 01:43:18', 'Chuyện nông nghiệp sinh thái dưới chân đồi Bù');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
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
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`product_id`, `description`, `discount`, `entered_date`, `price`, `product_image`, `product_name`, `quantity`, `status`, `category_id`, `favorite`, `origin_id`) VALUES
(1, 'Táo là một loại trái cây phổ biến và được trồng rộng rãi trên khắp thế giới. Đây là một loại trái cây có nguồn gốc từ khu vực Trung Á, nhưng hiện nay có mặt ở hầu hết các quốc gia với các giống khác nhau.\r\nLợi ích sức khỏe của táo:\r\nTáo là một nguồn cung cấp vitamin C dồi dào, giúp tăng cường hệ miễn dịch và bảo vệ da.\r\nChứa nhiều chất xơ, giúp cải thiện tiêu hóa và giảm cholesterol xấu.\r\nCó chứa các chất chống oxy hóa, giúp giảm nguy cơ mắc các bệnh mãn tính như tim mạch, tiểu đường.\r\nTáo cũng là một món ăn lý tưởng cho những người đang muốn giảm cân nhờ vào hàm lượng calo thấp và khả năng tạo cảm giác no lâu.', 69, '2024-11-15 00:00:00', 500000, 'quatao.jpg', 'Táo', 200, NULL, 2, b'0', 6),
(2, 'Dứa chứa nhiều vitamin C, mangan, và enzyme bromelain giúp hỗ trợ tiêu hóa; có tác dụng chống viêm, tăng cường miễn dịch, và thúc đẩy phục hồi cơ bắp, thường được ăn tươi hoặc chế biến thành nước ép, món tráng miệng, bánh, và canh chua.', 5, '2024-11-21 00:00:00', 20000, 'duathom.jpg', 'Dứa ( Thơm )', 60, NULL, 2, b'0', 2),
(3, 'Đậu bắp là một loại rau thuộc họ Cẩm quỳ, có hình dáng dài, màu xanh tươi và được cắt thành các khoanh tròn khi chế biến. Đậu bắp có vị nhẹ và thường được sử dụng trong các món canh, xào, hoặc nấu trong món ăn kiểu châu Á và châu Phi. Đặc biệt, đậu bắp có tác dụng tốt cho sức khỏe nhờ vào hàm lượng chất xơ và vitamin C cao, giúp hỗ trợ tiêu hóa và tăng cường hệ miễn dịch.', 3, '2024-11-08 00:00:00', 100000, 'daubap.jpg', 'Đậu bắp', 300, NULL, 1, b'0', 2),
(4, 'Cà tím là một loại rau củ quả có màu tím đậm, hình dáng dài, hình trụ và bóng bẩy. Thịt bên trong cà tím có màu trắng, mềm, và có chứa hạt nhỏ. Cà tím được trồng phổ biến ở nhiều vùng nhiệt đới và có thể chế biến theo nhiều cách khác nhau.\r\nThành phần dinh dưỡng: Cà tím chứa ít calo và là nguồn cung cấp chất xơ, vitamin C, vitamin B6, kali và các chất chống oxy hóa. Nó cũng chứa nasunin, một loại anthocyanin giúp bảo vệ tế bào khỏi tổn thương.\r\nLợi ích sức khỏe:\r\nHỗ trợ giảm cân nhờ ít calo và chứa nhiều chất xơ.\r\nGiúp cải thiện sức khỏe tim mạch nhờ hàm lượng kali và chất chống oxy hóa.\r\nTốt cho tiêu hóa và giúp duy trì mức đường huyết ổn định.\r\nỨng dụng: Cà tím thường được chế biến trong các món xào, nướng, hay làm thành các món ăn như cà tím nướng, cà tím xào tỏi hay cà tím sốt.', 36, '2024-11-15 00:00:00', 25000, 'catim.jpg', 'Cà tím', 282, NULL, 1, b'0', 6),
(5, 'Cà rốt là một loại củ có màu cam nổi bật, hình dạng dài và nhọn. Cà rốt là một trong những loại rau củ phổ biến nhất trên thế giới, dễ trồng và chế biến thành nhiều món ăn khác nhau.\r\nThành phần dinh dưỡng: Cà rốt là nguồn cung cấp dồi dào vitamin A (dưới dạng beta-carotene), giúp cải thiện thị lực và sức khỏe da. Nó cũng cung cấp vitamin C, vitamin K, kali, và chất xơ.\r\nLợi ích sức khỏe:\r\nTốt cho thị lực và giúp bảo vệ mắt khỏi các bệnh về mắt nhờ vào beta-carotene.\r\nGiúp duy trì làn da khỏe mạnh và ngăn ngừa lão hóa da.\r\nHỗ trợ hệ tiêu hóa nhờ vào lượng chất xơ cao.\r\nỨng dụng: Cà rốt có thể ăn tươi, chế biến thành các món ăn như canh cà rốt, sinh tố cà rốt, hoặc sử dụng trong các món xào, nướng, salad.', 5, '2024-11-13 00:00:00', 28900, 'carot.jpg', 'Cà rốt', 40, NULL, 1, b'0', 4),
(6, 'Hạt tiêu, được chiết xuất từ quả của cây tiêu (Piper nigrum), là một gia vị phổ biến với vị cay nồng đặc trưng, thường được sử dụng trong các món ăn để tăng cường hương vị. Hạt tiêu có hai loại chính là tiêu đen và tiêu trắng, được phân biệt dựa trên cách chế biến quả tiêu. Không chỉ là gia vị, hạt tiêu còn có nhiều lợi ích sức khỏe, như hỗ trợ tiêu hóa, kích thích sự thèm ăn, cải thiện tuần hoàn máu và có tính kháng viêm, kháng khuẩn. Ngoài ra, hạt tiêu cũng được sử dụng trong y học cổ truyền để điều trị một số bệnh liên quan đến đường hô hấp và tiêu hóa.', 19, '2024-11-08 00:00:00', 5000, 'hattieu.jpg', 'Hạt tiêu', 50, NULL, 4, b'0', 2),
(7, 'Bắp cải, hay còn gọi là cải bắp, là một loại rau thuộc họ Brassicaceae, có hình dáng tròn và các lá xếp chồng lên nhau. Loại rau này có nhiều màu sắc, từ xanh, tím đến trắng, và được dùng phổ biến trong các món ăn như salad, súp, hay xào. Bắp cải chứa nhiều vitamin C, K, chất xơ và các khoáng chất như kali, mangan, giúp tăng cường hệ miễn dịch, hỗ trợ tiêu hóa và duy trì sức khỏe tim mạch. Ngoài ra, bắp cải còn có đặc tính chống oxy hóa, giúp giảm nguy cơ mắc các bệnh mãn tính và chống viêm.', 3, '2024-11-20 00:00:00', 15000, 'bapcai.jpg', 'bắp cải', 100, NULL, 1, b'0', 4),
(8, 'Bí đỏ, hay còn gọi là bí ngô, là một loại quả thuộc họ Cucurbitaceae, có hình tròn hoặc dẹt và vỏ màu cam hoặc vàng tươi. Bí đỏ nổi bật với hàm lượng dinh dưỡng cao, đặc biệt là vitamin A, C, E, kali và chất xơ, rất tốt cho sức khỏe mắt, hệ miễn dịch và làn da. Bí đỏ còn chứa nhiều beta-carotene, một chất chống oxy hóa mạnh, giúp ngăn ngừa lão hóa và bảo vệ tế bào khỏi các tác nhân gây hại. Bên cạnh đó, bí đỏ còn có tác dụng giảm cân nhờ vào lượng calo thấp nhưng lại tạo cảm giác no lâu. Bí đỏ có thể được chế biến thành nhiều món ăn như canh, súp, bánh, hoặc nướng.', 38, '2024-11-29 00:00:00', 21000, 'bido.jpg', 'Bí đỏ', 100, NULL, 1, b'0', 3),
(9, 'Cà chua là một loại quả thuộc họ Solanaceae, có vỏ màu đỏ, hình tròn hoặc hình quả tim và chứa nhiều nước. Đây là nguồn cung cấp phong phú các dưỡng chất như vitamin C, vitamin A, kali và lycopene – một chất chống oxy hóa mạnh giúp bảo vệ tế bào khỏi tổn thương và làm giảm nguy cơ mắc các bệnh tim mạch và ung thư. Cà chua còn giúp cải thiện sức khỏe làn da, tăng cường hệ miễn dịch và hỗ trợ tiêu hóa nhờ vào lượng chất xơ dồi dào. Cà chua có thể được ăn tươi trong các món salad, nấu canh, chế biến thành nước ép, sốt hay làm thành các món ăn như pizza, pasta.', 67, '2024-11-21 00:00:00', 37000, 'cachua.jpg', 'Cà chua', 60, NULL, 1, b'0', 5),
(10, 'Hành tím là một loại củ thuộc họ hành, có lớp vỏ màu tím đặc trưng và bên trong màu trắng hoặc tím nhạt. Với vị cay nhẹ và hương thơm đặc trưng, hành tím thường được sử dụng để tăng thêm hương vị cho các món ăn như xào, nấu canh, trộn gỏi hoặc làm dưa muối. Không chỉ là gia vị phổ biến, hành tím còn giàu chất chống oxy hóa, vitamin C, các hợp chất lưu huỳnh và flavonoid, giúp tăng cường hệ miễn dịch và hỗ trợ sức khỏe tim mạch.', 19, '2024-11-12 00:00:00', 40000, 'hanhtim.jpg', 'Hành tím', 50, NULL, 1, b'0', 3),
(11, 'Nem chua là một món ăn truyền thống của Việt Nam, được làm từ thịt lợn xay nhuyễn, bì lợn, tỏi, ớt, cùng các gia vị và bột gạo rang để hỗ trợ quá trình lên men. Món này thường được gói bằng lá chuối và để lên men tự nhiên trong một khoảng thời gian.\r\n\r\nNem chua có vị chua nhẹ đặc trưng từ quá trình lên men, kèm theo chút cay nồng từ ớt. Đây là một món ăn vặt hoặc khai vị rất được ưa chuộng, đặc biệt trong các dịp lễ, Tết hoặc các bữa tiệc nhỏ.', 20, '2024-12-05 00:00:00', 100000, 'nemchua.jpg', 'nem chua', 100, NULL, 5, b'0', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_inventories`
--

CREATE TABLE `product_inventories` (
  `id` int(11) NOT NULL,
  `base_price` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `inventory_id` int(11) NOT NULL,
  `product_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_inventories`
--

INSERT INTO `product_inventories` (`id`, `base_price`, `quantity`, `inventory_id`, `product_id`) VALUES
(1, 100000, 100, 1, 1),
(2, 9800, 100, 1, 2),
(3, 9700, 100, 1, 3),
(4, 5900, 100, 2, 7),
(5, 13400, 100, 1, 4),
(6, 70000, 200, 1, 11),
(7, 15000, 100, 1, 10);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role`
--

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `role`
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
-- Cấu trúc bảng cho bảng `user`
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
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`user_id`, `avatar`, `email`, `name`, `password`, `register_date`, `status`) VALUES
(1, 'user.png', 'kumabear048@gmail.com', 'DP Gấu', '$2a$10$9ZqOwjATtEceArzlIRTtuOEoiy0Y.wMhQKWt3TAhth9h0uVfeGncq', '2024-11-24', b'1'),
(2, 'user.png', 'nguyenanhtu024@gmail.com', 'anh tú', '$2a$10$QtGkRxq3kUyGAtToFQ.qoOdeBKn9xLAPitA5kf0GeNCWYNPqBEqSS', '2024-11-24', b'1'),
(3, 'user.png', 'jvn49942@inohm.com', 'vân anh', '$2a$10$6HJKreuUfGvqd9WOa8rEs.akMWniIeEreQ4WB3GGjpcXTsPToVDUO', '2024-11-25', b'0'),
(4, 'user.png', 'myj74187@kisoq.com', 'Thanh Tú', '$2a$10$iqM.VTDBrOX8m.LMfrQlIOT2cMAXBSAfVbtbGuI.66qrLUGiTD.x6', '2024-11-25', b'1'),
(5, 'user.png', 'phamdat2001.ls@gmail.com', 'Đạt Phạm ', '$2a$10$awMKe97oSBz7sc0VFybV1usIjMcQ9cqDpJ4eVGcK6G56/f2TdPkYi', '2024-11-27', b'1'),
(6, 'user.png', 'cej81573@kisoq.com', 'thắng', '$2a$10$4lLMvh5pJHz3Fi/v2AQCZuBGEJw1ys6pz43.CoHg96rFViTVh7bmK', '2024-11-29', b'0'),
(7, 'user.png', 'datnguyen2k1.ls@gmail.com', 'Đạt Phạm', NULL, '2024-12-03', b'1'),
(8, 'user.png', 'ryv84268@kisoq.com', 'Vy', '$2a$10$49mmKca0xq/dsnathB/UhuGO.bvqIUo2SHHh.JaarekvUU745yNc.', '2024-12-03', b'1'),
(9, 'user.png', 'tco26031@kisoq.com', 'anh ', '$2a$10$8QS.xytJc.7BVyMi7.UuUu6yA7hYjZJVO6VkwPpzw9mCHRK3hpw0S', '2024-12-04', b'1'),
(10, 'user.png', 'oey92186@inohm.com', 'oanh', '$2a$10$FH3tHTkup/Jc9zmc4NPG3uaYeqjV81ZsJSeDCBTP05fUdURc8Tv/C', '2024-12-07', b'1');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users_roles`
--

CREATE TABLE `users_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users_roles`
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
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Chỉ mục cho bảng `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKfwepd0s8syqc9s06xnqa7mdwf` (`order_detail_id`),
  ADD KEY `FK6uv0qku8gsu6x1r2jkrtqwjtn` (`product_id`),
  ADD KEY `FKqi14bvepnwtjbbaxm7m4v44yg` (`user_id`);

--
-- Chỉ mục cho bảng `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`favorite_id`),
  ADD KEY `FK6sgu5npe8ug4o42bf9j71x20c` (`product_id`),
  ADD KEY `FK1uphh0glinnprjknyl68k1hw1` (`user_id`);

--
-- Chỉ mục cho bảng `inventories`
--
ALTER TABLE `inventories`
  ADD PRIMARY KEY (`inventory_id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `FKel9kyl84ego2otj2accfd8mr7` (`user_id`);

--
-- Chỉ mục cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `FKjyu2qbqt8gnvno9oe9j2s2ldk` (`order_id`),
  ADD KEY `FK4q98utpd73imf4yhttm3w0eax` (`product_id`);

--
-- Chỉ mục cho bảng `origins`
--
ALTER TABLE `origins`
  ADD PRIMARY KEY (`origin_id`);

--
-- Chỉ mục cho bảng `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
  ADD KEY `FK_origin_id` (`origin_id`);

--
-- Chỉ mục cho bảng `product_inventories`
--
ALTER TABLE `product_inventories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKegb663v6bjj1fbub5l7jjukgi` (`inventory_id`),
  ADD KEY `FK53md215ibhaod6dw7af2qussf` (`product_id`);

--
-- Chỉ mục cho bảng `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `UKob8kqyqqgmefl0aco34akdtpe` (`email`);

--
-- Chỉ mục cho bảng `users_roles`
--
ALTER TABLE `users_roles`
  ADD KEY `FKt4v0rrweyk393bdgt107vdx0x` (`role_id`),
  ADD KEY `FKgd3iendaoyh04b95ykqise6qh` (`user_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `favorites`
--
ALTER TABLE `favorites`
  MODIFY `favorite_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `inventories`
--
ALTER TABLE `inventories`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT cho bảng `order_details`
--
ALTER TABLE `order_details`
  MODIFY `order_detail_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT cho bảng `origins`
--
ALTER TABLE `origins`
  MODIFY `origin_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `product_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `product_inventories`
--
ALTER TABLE `product_inventories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `role`
--
ALTER TABLE `role`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `user_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `FK6uv0qku8gsu6x1r2jkrtqwjtn` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `FKfwepd0s8syqc9s06xnqa7mdwf` FOREIGN KEY (`order_detail_id`) REFERENCES `order_details` (`order_detail_id`),
  ADD CONSTRAINT `FKqi14bvepnwtjbbaxm7m4v44yg` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Các ràng buộc cho bảng `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `FK1uphh0glinnprjknyl68k1hw1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `FK6sgu5npe8ug4o42bf9j71x20c` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FKel9kyl84ego2otj2accfd8mr7` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Các ràng buộc cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `FK4q98utpd73imf4yhttm3w0eax` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `FKjyu2qbqt8gnvno9oe9j2s2ldk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `FK_origin_id` FOREIGN KEY (`origin_id`) REFERENCES `origins` (`origin_id`),
  ADD CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Các ràng buộc cho bảng `product_inventories`
--
ALTER TABLE `product_inventories`
  ADD CONSTRAINT `FK53md215ibhaod6dw7af2qussf` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `FKegb663v6bjj1fbub5l7jjukgi` FOREIGN KEY (`inventory_id`) REFERENCES `inventories` (`inventory_id`);

--
-- Các ràng buộc cho bảng `users_roles`
--
ALTER TABLE `users_roles`
  ADD CONSTRAINT `FKgd3iendaoyh04b95ykqise6qh` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `FKt4v0rrweyk393bdgt107vdx0x` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
