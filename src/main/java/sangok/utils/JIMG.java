package sangok.utils;

import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnails;

public class JIMG {

	public static boolean saveToResizeImage(MultipartFile mf, int width, int height, float scaleFactor, File file) {
		boolean bRtn = true;
		float nFactor = scaleFactor;
		try {
			BufferedImage originalImage = ImageIO.read(mf.getInputStream());
			int nWidth = originalImage.getWidth();
			int nHeight = originalImage.getHeight();
			int nStdVal = Math.max(nWidth, nHeight);
			if (nStdVal >= 4000) {
//				nFactor = 0.25f;
				nFactor = 0.38f;
			} else if (nStdVal >= 3000) {
//				nFactor = 0.33f;
				nFactor = 0.47f;
			} else if (nStdVal >= 2000) {
//				nFactor = 0.5f;
				nFactor = 0.63f;
			}
			Thumbnails.of(originalImage).scale(nFactor).toFile(file);
		} catch(Exception e) {
			e.printStackTrace();
			bRtn = false;			
		}
		return bRtn;
	}
}
