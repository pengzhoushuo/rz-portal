package com.xxx.portal.web.login;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xxx.portal.util.BaseResponse;


/**
 * 图片验证码Action
 * @author peng
 */
@Controller
@RequestMapping({"/login"})
public class LoginAction{
	
	/**
	 * 检验用户输入的验证码是否正确
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping(value={"validateRndCode"}, method={RequestMethod.POST})
	@ResponseBody
	public BaseResponse<String> check(Model model, HttpServletRequest req){
		BaseResponse<String> response = new BaseResponse<String>();
		response.setCode(BaseResponse.CODE_FAILURE);
		response.setMessage("验证码不正确");
		String rndcode = req.getParameter("rndcode");
		Object codeInSession = req.getSession().getAttribute("code");
		if(codeInSession != null){
			String codeInSessionString = codeInSession.toString();
			if(codeInSessionString.equalsIgnoreCase(rndcode)){
				response.setCode(BaseResponse.CODE_SUCCESS);
				response.setMessage("");
			}
		}
		return response;
	}
}
