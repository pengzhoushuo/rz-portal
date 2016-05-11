package com.xxx.portal.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;

import com.alibaba.fastjson.JSONArray;


@Aspect
@Configuration
public class InvokeLogAspect {

	static Logger logger = LoggerFactory.getLogger(InvokeLogAspect.class);

	/**
	@Around("execution(* org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter.handle(..))")  
	public Object around(ProceedingJoinPoint joinPoint) throws Throwable {
		joinPoint.getSignature().toShortString();
		logTheCall(joinPoint);
		return joinPoint.proceed();

	}**/
	
	@Around("execution(* com.xxx.portal.web..*(..))")
	public Object around2(ProceedingJoinPoint joinPoint) throws Throwable {
		joinPoint.getSignature().toShortString();
		logTheCall(joinPoint);
		return joinPoint.proceed();

	}

	/**
	 * 记录外部调用日志
	 * 
	 * @param joinPoint
	 */
	private void logTheCall(ProceedingJoinPoint joinPoint) {
		Object[] args = joinPoint.getArgs();
		JSONArray array = (JSONArray) JSONArray.toJSON(args);
		logger.info("调用方法:" + joinPoint.getSignature().toShortString());
		logger.info("参数:" + array.toJSONString());
	}
}
