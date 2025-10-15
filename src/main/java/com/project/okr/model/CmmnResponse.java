package com.project.okr.model;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CmmnResponse {
	
	@ApiModelProperty(example = "상태코드")
	private int status;

	@ApiModelProperty(example = "메세지")
	private String message;

	@ApiModelProperty(example = "데이터")
	private Map<String, Object> data;

	public CmmnResponse() {
		this(HttpStatus.OK);
	}

	public CmmnResponse(HttpStatus httpStatus) {
		this.status  = httpStatus.value();
		this.message = httpStatus.getReasonPhrase();
		this.data    = new HashMap<String, Object>();
	}

	public void add(String key, Object value) {
		this.data.put(key, value);
	}

	public Object get(String key) {
		return this.data.get(key);
	}

}
