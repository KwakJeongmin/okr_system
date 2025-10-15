package com.project.okr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.okr.annotation.UseDefaultDatasource;
import com.project.okr.model.TestModel;

@Mapper
@UseDefaultDatasource
public interface TestMapper {
	
	List<TestModel> testLstInqr(TestModel testModel) throws Exception;

}
