import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;


public class Test {  
  
    public static void main(String[] args) {  
    	String webpath = getAppWebRoot() + "../../../WebRoot";
        File picFile = new File(webpath + "/WEB-INF/app/resources/images/step1.jpg"); // 图片文件路径  
        System.out.println(picFile.getAbsolutePath());
        BufferedImage image = null;  
        try {  
            image = ImageIO.read(picFile);  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        int width = image.getWidth();// 图片宽度  
        int height = image.getHeight();// 图片高度  
        System.out.println("width=" + width);  
        System.out.println("height=" + height);  
    }  
    
    public static String getAppWebRoot(){
		String s = Thread.currentThread().getContextClassLoader().getResource("").toString();
		if(s.startsWith("file://")){
			return s.substring(6);
		}else if(s.startsWith("file:/")){
			return s.substring(6);
		}else{
			return s;
		}
	}
}  
