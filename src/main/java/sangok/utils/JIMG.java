package sangok.utils;

import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnails;

public class JIMG {

	public static boolean saveToResizeImage(MultipartFile mf, int width, int height, float scaleFactor, File file) {
		boolean bRtn = true;
		try {
			BufferedImage originalImage = ImageIO.read(mf.getInputStream());
			Thumbnails.of(originalImage).scale(scaleFactor).toFile(file);
		} catch(Exception e) {
			e.printStackTrace();
			bRtn = false;			
		}
		return bRtn;
	}
}
