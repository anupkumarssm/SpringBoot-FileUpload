package com.file.upload.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.file.upload.entity.FileUpload; 
import com.file.upload.repository.FileRepository; 

@Service
public class FileUploadServiceImpl implements FileUploadService{
	@Autowired
	FileRepository profileRepository;

	@Override
	public List<FileUpload> findAll() {
		return profileRepository.findAll();
	}

	@Override
	public FileUpload save(FileUpload profile) {
		return profileRepository.save(profile);
	}

	@Override
	public void deleteById(int id) {
		profileRepository.deleteById(id);
	}

	@Override
	public FileUpload findById(int id) {
		return profileRepository.findById(id).orElse(new FileUpload());
	}

	@Override
	public List<FileUpload> findByType(int type) { 
		return profileRepository.findByType(type);
	}
}