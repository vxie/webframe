package com.vxie.debut.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class PicUtil {
	
	/**
	 * <p>Description: 获取图片资源 <p>
	 * @return
	 */
	public static BufferedImage getPic (String fileName){
		String webpath = getAppWebRoot() + "../../../web";
        File picFile = new File(webpath + "/WEB-INF/app/resources/images/" + fileName); // 图片文件路径  
        BufferedImage image = null;  
        try {  
            image = ImageIO.read(picFile);  
        } catch (IOException e) {  
            e.printStackTrace();  
        }
        return image;
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
