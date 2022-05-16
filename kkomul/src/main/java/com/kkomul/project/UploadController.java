package com.kkomul.project;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kkomul.project.file.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@Log4j
public class UploadController {

	private String uploadPathBoard = "D:\\sts-4.10.0.RELEASE\\kkomul\\src\\main\\webapp\\resources\\images\\boardFile";
	private String uploadPathMem = "D:\\sts-4.10.0.RELEASE\\kkomul\\src\\main\\webapp\\resources\\images\\memberFile";

	@GetMapping(value = "/member/profile_upload")
	public void profileUploadForm() throws Exception {
		
		log.info("profileUploadForm.................................");
		
	}

	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
		log.info("upload Ajax.................................");
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	@PostMapping(value = "/uploadAjaxAction",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("update ajax post............................");
		List<AttachFileDTO> attachList = new ArrayList<AttachFileDTO>();
		
		String uploadFolderPath = getFolder();
		
		File uploadFolder = new File(uploadPathBoard, getFolder());
		log.info("uploadFolder path : " + uploadFolder);
		
		if (uploadFolder.exists() == false) {
			uploadFolder.mkdirs();
		}
		
		for (MultipartFile multipartFile : uploadFile) {
			log.info("----------------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload Size : " + multipartFile.getSize());
			log.info("Upload ContentType : " + multipartFile.getContentType());
			
			AttachFileDTO attachFileDto = new AttachFileDTO();
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name : " + uploadFileName);
			
			attachFileDto.setFileName(uploadFileName);
			
			// 중복 데이터 제거
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadFolder, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachFileDto.setUuid(uuid.toString());
				attachFileDto.setUploadPath(uploadFolderPath);
				
				if (checkImageType(saveFile)) {
					attachFileDto.setImage(true);
					
					File thumbnail = new File(uploadFolder, "s_" + uploadFileName); // 썸네일용
					Thumbnails.of(saveFile).size(200, 200).toFile(thumbnail);
				}
				
				attachList.add(attachFileDto);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		
		return new ResponseEntity<List<AttachFileDTO>>(attachList, HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		log.info("fileName : " + fileName);
		
		File file = new File(uploadPathBoard + "\\" + fileName);
		log.info("file : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@GetMapping("/displayProfile")
	@ResponseBody
	public ResponseEntity<byte[]> getProfile(String userid, String fileName) {
		log.info("fileName : " + fileName);
		log.info("userid : " + userid);
		
		File file = new File(uploadPathMem + "\\" + userid + "\\" + fileName);
		log.info("file : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@GetMapping(value = "/download",
			produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, // userAgent > 단말기 정보
													String fileName) {
		Resource resource = new FileSystemResource(uploadPathBoard + "\\" + fileName);
		
		if (resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			boolean checkIE = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
					
			String downloadName = null;
			
			if (checkIE) {
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\", "");
			} else {
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);		
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		log.info("deleteFile : " + fileName);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html;charset=UTF-8");
		
		File file;
		
		try {
			file = new File(uploadPathBoard + "\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			if (type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName : " + largeFileName);
				
				file = new File(largeFileName);
				file.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", headers, HttpStatus.OK);
	}
}
