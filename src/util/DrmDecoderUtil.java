package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import MarkAny.MaSaferJava.Madec;
/**
 * 
 * @author seok
 * @paramter pms 서버에 있는 DRM이 걸린 파일 full 경로
 * 
 * ex) drmDecoder(req, 'D:/workspace/plugin workspace/drm-decoder-test/temp/UI 설계 Platform 화면.pptx');
 
 */
public class DrmDecoderUtil {
	
	public static void drmDecoder(HttpServletRequest req, String filePath) throws Exception {
		File inputFile = new File(filePath);
		decodeFile(req, inputFile);
	}
	
	public static void decodeFile(HttpServletRequest req, File inputSourceFile) throws Exception {
		
		InputStream in = null;
		OutputStream out = null;
		
		try {
			
			String streamDrmInfopath = req.getSession().getServletContext().getRealPath(File.separator) + File.separator + "drm" + File.separator + "StreamDrmInfo_HYNIX.dat";
			Madec clMadec = new Madec(streamDrmInfopath);
			
			String inputSourceFileName = inputSourceFile.getName();
			
			String outputFilePath = inputSourceFile.getParent();
			String outputFileName = inputSourceFileName.substring(0, inputSourceFileName.lastIndexOf(".")) + "_decode" + inputSourceFileName.substring(inputSourceFileName.lastIndexOf("."));
			
			File outputFile = new File(outputFilePath + File.separator + outputFileName);
			
			in = new FileInputStream(inputSourceFile);
			out = new FileOutputStream(outputFile);

			long inputFileLength = inputSourceFile.length();

			long size = clMadec.lGetDecryptFileSize(inputSourceFile.getName(), inputFileLength, in);
			if(size == -1) {
				if(outputFile.exists()) {
					FileUtils.copyFile(inputSourceFile, outputFile);					
				} else {
					throw new Exception("MS-Word File Not Found.");
				}
			} else {
				clMadec.strMadec(out);
			}
			
		} finally {
			if(in != null) {
				in.close();
				in = null;
			}
			if(out != null) {
				out.close();
				out = null;
			}
		}
	}
}
