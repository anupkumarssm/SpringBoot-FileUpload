package com.file.upload.service;

import java.util.List;

import com.file.upload.entity.FileUpload;
 
public interface FileUploadService {
	List<FileUpload> findAll();
	FileUpload save(FileUpload profile);
	void deleteById(int id);
	FileUpload findById(int id);
	List<FileUpload> findByType(int i);

}
