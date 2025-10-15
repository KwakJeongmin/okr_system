package com.project.okr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.okr.mapper.TestMapper;
import com.project.okr.model.TestModel;

@Service
public class TestService {
	
	@Autowired
    private TestMapper testMapper;

	public List<TestModel> testLstInqr(TestModel testModel) throws Exception {
		return testMapper.testLstInqr(testModel);
	}

}
