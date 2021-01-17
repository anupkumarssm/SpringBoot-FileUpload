package com.file.upload.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.file.upload.entity.FileUpload;

 
public interface FileRepository extends JpaRepository<FileUpload, Integer>{

	List<FileUpload> findByType(int type);

}
