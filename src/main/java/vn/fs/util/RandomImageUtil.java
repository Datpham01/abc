package vn.fs.util;

import java.io.File;
import java.util.Random;

public class RandomImageUtil {
    public static String getRandomImageFromDirectory(String directoryPath) {
        // Tạo đối tượng File cho thư mục
        File dir = new File(directoryPath);

        // Lấy danh sách các tệp trong thư mục
        File[] files = dir.listFiles((dir1, name) -> name.endsWith(".jpg") || name.endsWith(".png") || name.endsWith(".jpeg"));

        if (files != null && files.length > 0) {
            // Chọn ngẫu nhiên một tệp từ danh sách
            Random rand = new Random();
            int randomIndex = rand.nextInt(files.length);
            return files[randomIndex].getName(); // Trả về tên tệp ảnh ngẫu nhiên
        }

        return null; // Nếu không có ảnh nào trong thư mục
    }
}
