package org.hqu.production_ms.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.hqu.production_ms.service.FileService;
import org.hqu.production_ms.util.DownloadUtil;
import org.hqu.production_ms.util.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


/**
 * 
 * created on 2016年9月27日 
 *
 * 上传图片处理
 *
 * @author  megagao
 * @version  0.0.1
 */
@Controller
public class FileController {

	@Autowired
	private FileService fileService;
	/*
	@RequestMapping("/file/upload")
	@ResponseBody
	public String pictureUpload(MultipartFile uploadFile) {
		@SuppressWarnings("unchecked")
		Map<String,Object> result = FileService.uploadFile(uploadFile);
		//为了保证功能的兼容性，需要把Result转换成json格式的字符串。
		String json = JsonUtils.objectToJson(result);
		return json;
	}*/
	@RequestMapping(value="/file/upload", method=RequestMethod.POST)
	@ResponseBody
	public String handleFileUpload(MultipartHttpServletRequest request){
		Iterator<String> iterator = request.getFileNames();
		String json = null;
		while (iterator.hasNext()) {
				String fileName = iterator.next();
				MultipartFile multipartFile = request.getFile(fileName);
				/*byte[] file = multipartFile.getBytes();*/
				Map<String,Object> result = fileService.uploadFile(multipartFile);
				
				json = JsonUtils.objectToJson(result);
				
		}
		
		return json;
	
	}
	
	@RequestMapping(value="/file/delete")
	@ResponseBody
	public String handleFileDelete(@RequestParam String fileName){
		
		fileService.deleteFile(fileName);
		Map<String,Object> result = new HashMap<String,Object>();	
		result.put("data", "success");
		String json = JsonUtils.objectToJson(result);
		return json;
	}
	
	@RequestMapping(value="/file/download")
	public void handleFileDownload(@RequestParam String fileName, HttpServletResponse response){
		
		fileName = fileName.substring(fileName.lastIndexOf("/")+1);
		
		String filePath = "F:\\upload\\temp\\file\\"+fileName;
		
		DownloadUtil du = new DownloadUtil();
		
		du.download(filePath, fileName, response, false);
	}
}
