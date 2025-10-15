package com.project.okr.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.okr.model.CmmnResponse;
import com.project.okr.model.TestModel;
import com.project.okr.service.TestService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/test")
public class TestController {
	
	@Autowired
	private TestService testService;
	
	@GetMapping(value = "/testLstInqr")
	public ResponseEntity<?> testLstInqr( @ModelAttribute TestModel testModel) throws Exception {
		
		CmmnResponse response = new CmmnResponse();

		List<TestModel> list = testService.testLstInqr(testModel);
		response.add("list", list);
		
		return ResponseEntity.ok(response);
	}

}
