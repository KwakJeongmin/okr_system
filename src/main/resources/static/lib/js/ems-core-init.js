// <![CDATA[

/*******************************************************************************
* DECLARE : axios 공통 인스턴스 생성
*******************************************************************************/
var axiosInstance = axios.create({
    baseURL: "/api",
    timeout: 600000,  
	maxContentLength: Infinity,
	maxBodyLength: Infinity
});

//]]>
