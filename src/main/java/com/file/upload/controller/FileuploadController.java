package com.file.upload.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

import com.file.upload.entity.FileUpload;
import com.file.upload.service.FileUploadService;
 

@Controller
public class FileuploadController {
	
	 @Value("${fileDestination}")
	 private String fileDestination;
	 
	@Autowired
	FileUploadService profileService;
	
	/**
	 * Redirect to Dashboard
	 */
	@RequestMapping(value = "/")
	public  String dashboard() { 
		return "redirect:dashboard";
	}
	/**
	 * Dashboard Page
	 * return dashboard
	 */
	@RequestMapping(value = "/dashboard")
	public  String dashboardPage() { 
		return "dashboard";
	}
	
	/**
	 * Base64 Page
	 * @param model
	 * @return base64page
	 */
	@RequestMapping(value = "/base64page")
	public  String base64Form(Model model) { 
		model.addAttribute("getAllImages",profileService.findByType(0));
		return "base64page";
	}
	
	
	/**
	 * Save Base64 Form
	 * @param profile
	 * @return redirect to base64page
	 */
	@RequestMapping(value = "/savebase64formsubmit")
	public String base64FormSubmit(FileUpload fileUpload) {
		fileUpload.setType(0);
		profileService.save(fileUpload);
		return "redirect:base64page";
	}
	/**
	 * Delete Image
	 * @param req, id
	 * @return redirect to base64page
	 */
	@RequestMapping(value = "/deleteimage")
	public String delete(HttpServletRequest req) {
		try {
			int id=Integer.parseInt(req.getParameter("id"));
			profileService.deleteById(id);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return  "redirect:base64page";
	} 
	
	
	/**
	 * File upload page
	 * @return fileuploadpage
	 */
	@RequestMapping(value = "/fileuploadpage")
	public  String fileUploadPage(HttpSession session,Model model) { 
		model.addAttribute("message",session.getAttribute("message"));
		session.removeAttribute("message");
		model.addAttribute("error",session.getAttribute("error"));
		session.removeAttribute("error");
		model.addAttribute("getAllSingleFileUploadred",profileService.findByType(1));
		model.addAttribute("getAllMultiFileUploadred",profileService.findByType(2));
		return "fileuploadpage";
	}
	
	/**
	 * Upload single file using Spring Controller
	 */
	@RequestMapping(value = "/singlefileuploadform")
	public String uploadFileHandler(HttpSession session,@RequestParam("name") String name,
			@RequestParam("file") MultipartFile file) {
		String message = "";
		if (!file.isEmpty()) {
			try {
			      //First Method
				 // Get the file and save it somewhere
					/*
					 * File dir1 = new File(fileDestination); if (!dir1.exists()) dir1.mkdirs();
					 * byte[] bytes = file.getBytes(); Path path = Paths.get(fileDestination +"/"+
					 * file.getOriginalFilename()); Files.write(path, bytes);
					 */

	            //Second Method
				  byte[] bytes = file.getBytes();
				  // Creating the directory to store file
				  File dir = new File("UploadedFile");
				  if (!dir.exists())
					  dir.mkdirs();
				  // Create the file on server
				  FileUpload fileUpload=new FileUpload();
				  fileUpload.setName(name);
				  fileUpload = profileService.save(fileUpload);
				  File serverFile = new File(dir.getAbsolutePath()
				  + File.separator +fileUpload.getId()+"_"+ file.getOriginalFilename()); 
				  BufferedOutputStream stream =   new BufferedOutputStream( new FileOutputStream(serverFile));
				  stream.write(bytes); stream.close();
				  System.out.println("Server File Location=" + serverFile.getAbsolutePath());
				  fileUpload.setFilename(file.getOriginalFilename());
				  fileUpload.setFilepath(serverFile.getAbsolutePath());
				  fileUpload.setType(1);
				  profileService.save(fileUpload);
				  
				  message = message + "You successfully uploaded file=" + name
							+ "<br />";
					session.setAttribute("message", message);
				return "redirect:fileuploadpage";
			} catch (Exception e) {
				 message =  "You failed to upload file=" + name
							+ "<br />";
				 session.setAttribute("error", message);
				return "You failed to upload " + name + " => " + e.getMessage();
			}
		} 
		return "redirect:fileuploadpage";
	}
	
	
	/**
	 * Upload multiple file
	 */
	@RequestMapping(value = "/multiplefileuploadform")
	public String uploadMultipleFileHandler(HttpSession session,@RequestParam("name") String[] names,
			@RequestParam("file") MultipartFile[] files) {

		if (files.length != names.length)
			return "Mandatory information missing";

		String message = "";
		for (int i = 0; i < files.length; i++) {
			MultipartFile file = files[i];
			String name = names[i];
			try {
				byte[] bytes = file.getBytes();

				// Creating the directory to store file
				File dir = new File("UploadedFile");
				if (!dir.exists())
					dir.mkdirs();

				// Create the file on server
				FileUpload fileUpload=new FileUpload();
				fileUpload.setName(name);
				fileUpload = profileService.save(fileUpload);
				File serverFile = new File(dir.getAbsolutePath()
						+ File.separator +fileUpload.getId()+"_"+ file.getOriginalFilename());
				BufferedOutputStream stream = new BufferedOutputStream(
						new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();

				System.out.println("Server File Location="
						+ serverFile.getAbsolutePath());

				message = message + "You successfully uploaded file=" + name
						+ "<br />";
				fileUpload.setFilename(file.getOriginalFilename());
				fileUpload.setFilepath(serverFile.getAbsolutePath());
				fileUpload.setType(2);
				  profileService.save(fileUpload);
				session.setAttribute("message", message);
			} catch (Exception e) {
				message =  "You failed to upload file=" + name
						+ "<br />";
			 session.setAttribute("error", message);
				return "redirect:fileuploadpage";
			}
		}
		return "redirect:fileuploadpage";
	}
	 
	/**
	 * Download file
	 */
	/*
	 * @RequestMapping(value = "/download") public StreamingResponseBody
	 * getSteamingFile(HttpServletResponse response) throws IOException {
	 * 
	 * response.setContentType("text/html;charset=UTF-8"); InputStream inputStream =
	 * new FileInputStream(new
	 * File("C:\\Users\\anups\\Downloads\\FilesUploaded\\edugrow-logo.jpg"));
	 * 
	 * return outputStream -> { int nRead; byte[] data = new byte[1024]; while
	 * ((nRead = inputStream.read(data, 0, data.length)) != -1) {
	 * outputStream.write(data, 0, nRead); } inputStream.close(); }; }
	 */
	/**
	 * Delete file
	 */
	@RequestMapping(value="/deletefile", method=RequestMethod.GET)
	public String downloadFile(@RequestParam("id") int id) {
		FileUpload profile=profileService.findById(id); 
		File fileToDelete = new File(profile.getFilepath());
	    if(fileToDelete.delete())
	    	profileService.deleteById(id);
      return "redirect:fileuploadpage";
	}
	/**
	 * Download file
	 */
	@RequestMapping(value="/downloadFile")
	public void getLogFile(HttpSession session,HttpServletResponse response,@RequestParam("id") int id) throws Exception {
	    try { 
	    	FileUpload profile=profileService.findById(id); 
	        File f = new File(profile.getFilepath());
	        InputStream inputStream = new FileInputStream(f);
	        response.setContentType("application/force-download");
	        response.setHeader("Content-Disposition", "attachment; filename="+profile.getFilename()); 
	        IOUtils.copy(inputStream, response.getOutputStream());
	        response.flushBuffer();
	        inputStream.close();
	    } catch (Exception e){
	        e.printStackTrace();
	    }

	}
	
	
	
}
