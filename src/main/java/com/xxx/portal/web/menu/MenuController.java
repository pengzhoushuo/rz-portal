package com.xxx.portal.web.menu;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xxx.portal.data.gen.model.Menu;
import com.xxx.portal.util.BaseResponse;
import com.xxx.portal.webframework.domain.PageResponse;

@Controller
@RequestMapping({"/menu"})
public class MenuController {
	
	private static final Log logger = LogFactory.getLog(MenuController.class);
	
	@RequestMapping({"list"})
	public String list(@RequestParam(value="page", defaultValue="1") int pageNumber, @RequestParam(value="page.size", defaultValue="5") int pageSize, @RequestParam(value="sortType", defaultValue="auto") String sortType, Model model, ServletRequest request){
		return "menu/list";
	}
  
	@RequestMapping(value={"page"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public PageResponse<Menu> page(Model model, ServletRequest request){
		return null;
	}
  
	@RequestMapping(value={"initAdd"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	public String initAdd(Model model, ServletRequest request){
		return "notice/add";
	}
  
	@RequestMapping(value={"add"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public BaseResponse<Boolean> add(@Valid Menu menu, Model model, ServletRequest request){
		BaseResponse<Boolean> response = new BaseResponse<Boolean>();
		try{
			response.setObj(true);
		}catch (Exception e){
			logger.error(e);
		}
	    return response;
	}
	
	@RequestMapping(value={"initEdit"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
	public String initEdit(Model model, ServletRequest request){
		return "notice/edit";
	}
  
	@RequestMapping(value={"edit"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public BaseResponse<Boolean> edit(@Valid Menu menu, Model model, ServletRequest request){
		BaseResponse<Boolean> response = new BaseResponse<Boolean>();
		try{
			response.setObj(true);
		}catch (Exception e){
			logger.error(e);
		}
	    return response;
	}
  
	@RequestMapping(value={"delete"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public BaseResponse<Boolean> delete(@RequestParam("ids") String ids, ServletRequest request){
	    BaseResponse<Boolean> response = new BaseResponse<Boolean>();
	    try{
		     if (StringUtils.isNotBlank(ids)){
		    	 String[] idStrArray = ids.trim().split(",");
		    	 List<String> idList = new ArrayList<String>();
		    	 int len = idStrArray.length;
		    	 for (int i = 0; i < len; i++){
		    		 idList.add(idStrArray[i]);
		    	 }
		    	 response.setObj(true);
		      }
	    }catch (Exception e){
	      logger.error(e);
	    }
	    return response;
	}
}
