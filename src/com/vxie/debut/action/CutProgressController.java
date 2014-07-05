package com.vxie.debut.action;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vxie.debut.business.BaseInfoService;
import com.vxie.debut.business.CutProgressService;
import com.vxie.debut.model.CutStepPosition;
import com.vxie.debut.model.CutTask;
import com.vxie.debut.utils.Constants;
import com.sunrise.springext.support.json.JSONException;

@Controller
@RequestMapping(value="/progress")
public class CutProgressController extends AbstractController {
	@Resource
	private CutProgressService cutProgressService;
	
	@Resource
	private BaseInfoService baseInfoService;
	
//	@RequestMapping(value="/list")
//	public String list(ModelMap map){
//		map.put("steps", cutProgressService.allSteps());
//		map.put("baseInfo", baseInfoService.find());
//		map.put("status", cutProgressService.getStepStatus());
//		return "/progress/list";
//	}
	
	
	//lw 2011-08-30
	@RequestMapping(value="/list")
	public String list(ModelMap map){
		map.put("steps", cutProgressService.allSteps());
		map.put("baseInfo", baseInfoService.find());
		map.put("status", cutProgressService.getStepStatus());
		return "/progress/progress";
	}
	

	
		
	@RequestMapping(value="/steps/exec")
	public String stepExec(ModelMap map, HttpSession session){
		Long userId = getSessionLong(session, "cutUserId");
		map.put("steps", cutProgressService.allVisitSteps(userId, getSessionLong(session, "isAdmin").intValue() > 0));
		map.put("status", cutProgressService.getStepStatus());
		map.put("canCheckIt", cutProgressService.canCheckStep(userId));
		map.put("canExecIt", cutProgressService.canExecStep(userId));
		return "/progress/step-exec";
	}
	
	@RequestMapping(value="/tasks/exec")
	public String taskExec(ModelMap map, HttpSession session){
		Long userId = getSessionLong(session, "cutUserId");
		map.put("steps", cutProgressService.getVisitTasks(userId, getSessionLong(session, "isAdmin").intValue() > 0));
		map.put("canCheckIt", cutProgressService.canCheckTask(userId));
		map.put("canExecIt", cutProgressService.canExecTask(userId));
		map.put("status", cutProgressService.getStepStatus());
		return "/progress/task-exec";
	}
	
	@RequestMapping(value="/refresh/step/{id}")
	@ResponseBody
	public String refreshStep(@PathVariable Long id){
		String percent = cutProgressService.getStepProgressVal(id);
		String temp = percent.substring(0, percent.length() - 1);
		if("null".equals(temp) || "".equals(temp)){
			percent = "0"+"%";
		}
		return percent;
	}
	
	@RequestMapping(value="/steps/status/{id}/{val}")
	@ResponseBody
	public String updateStepStatus(@PathVariable Long id, @PathVariable Long val){
		return cutProgressService.updateStepStatus(id, val);
	}
	
	//获得步骤的状态
	@RequestMapping(value="/steps/start/{id}")
	@ResponseBody
	public String startStep(@PathVariable Long id){
		return cutProgressService.startStep(id);
	}
	
	//更新子任务的状态
	@RequestMapping(value="/tasks/update/status/{id}/{val}")
	@ResponseBody
	public String updateTaskStatus(@PathVariable Long id, @PathVariable Long val){
		cutProgressService.updateTaskStatus(id, val);
		return cutProgressService.updateStepProcess(id, val);
	}
	
	//获得子任务的状态描述
	@RequestMapping(value="/tasks/get/status/{id}")
	@ResponseBody
	public String getTaskStatus(@PathVariable Long id){
		return cutProgressService.getTaskStatus(id);
	}
	
	//获得子任务的状态描述
	@RequestMapping(value="/tasks/get/status/text/{id}")
	@ResponseBody
	public String getTaskStatusText(@PathVariable Long id){
		return cutProgressService.getTaskStatusText(id);
	}
	
	
	@RequestMapping(value="/refresh/totaltime")
	@ResponseBody
	public String getCutTotalTime(){
		return cutProgressService.getCutTotalTime();
	}
	
	
	//读取每个步骤的定义文件  获得位置
	@SuppressWarnings("unchecked")
	private List<CutStepPosition> getStepPosition2(String file)throws Exception{
		
		List<CutTask> taskList = null;//cutProgressService.getTasks();
		Map<String, Map<String, String>> taskMap = new HashMap<String, Map<String, String>>();
		for(CutTask vo: taskList){
			Map<String, String> map = new HashMap<String, String>();
			map.put("taskName", vo.getTaskName());
			map.put("taskStatus", vo.getTaskStatus().toString());
			taskMap.put(vo.getTaskId().toString(), map);
		}
		
		//任务列表-对应图形中的框框
		List<CutStepPosition> reList = new ArrayList<CutStepPosition>();
		InputStream in = CutProgressController.class.getClassLoader().getResourceAsStream(file); 
		
		SAXReader saxReader = new SAXReader();
		Document doc = saxReader.read(in);
		Element  root = doc.getRootElement();
		Iterator ite = root.elementIterator("step");
		while(ite.hasNext()){
			Element element = (Element) ite.next();
			Attribute  attStepId = element.attribute("stepid");
			Attribute  attTaskId = element.attribute("taskid");
			Attribute  attX = element.attribute("x");
			Attribute  attY = element.attribute("y");
			Attribute  attW = element.attribute("width");
			Attribute  attH = element.attribute("height");
			
			CutStepPosition cspvo = new CutStepPosition();
			cspvo.setStepid(new Long(attStepId.getText()));
			String taskId = attTaskId.getText();
			cspvo.setTaskId(new Long(taskId));
			cspvo.setWidth(Integer.parseInt(attW.getText()));
			cspvo.setHeight(Integer.parseInt(attH.getText()));
			cspvo.setLeft(Integer.parseInt(attX.getText()));
			cspvo.setTop(Integer.parseInt(attY.getText()));
			
			Map<String, String> map = taskMap.get(taskId);
			cspvo.setTaskName(map.get("taskName"));
			String taskStatus = map.get("taskStatus");
			cspvo.setStatus(taskStatus);
			cspvo.setBorderColor(Constants.borderColor.get(taskStatus));
			cspvo.setTaskTitle(Constants.taskTitle.get(taskStatus));
			cspvo.setTextColor(Constants.textColor.get(taskStatus));
			
			
			reList.add(cspvo);
		}
		return reList;
	} 
	
	@RequestMapping(value="/taskStatus")
	@ResponseBody
	public String getTaskStatus() throws JSONException{
		return cutProgressService.getTaskStatus();
	}
	
	
	
	
	//lw 2011-08-30
	@RequestMapping(value="/pimage/{cutIndex}")// cutIndex 表示第n次割接
	public String progressImage(ModelMap map, @PathVariable String cutIndex)throws Exception{
		String fileName = "step" + cutIndex + ".xml";
		
		Map<Long, CutTask> taskMap = cutProgressService.getTasks();
		
		//任务列表-对应图形中的框框
		List<CutStepPosition> reList = new ArrayList<CutStepPosition>();
		
		ClassPathResource rs = new ClassPathResource("imgsetup.xhtml");
		if(rs.exists()){
			StringBuffer buff = new StringBuffer();
			try {
				BufferedReader reader = null;
				try {
	                 reader = new BufferedReader(new FileReader(rs.getFile()));
	                 String line = reader.readLine();
	            	 line = reader.readLine();
	            	 while(line != null){
	                     buff.append(line);
	                     line = reader.readLine();
	                 }
	 			} catch (Exception e) {
					e.printStackTrace();
				} finally{
					reader.close();
				}
				Document doc = DocumentHelper.parseText(buff.toString());
				Element body = doc.getRootElement().element("body");
				
				//设置背景图片的长宽属性
				Element img = body.element("img");
				map.put("picWidth", img.attribute("width").getValue());
				map.put("picHeight", img.attribute("height").getValue());
				map.put("imageName", this.getImageName(img.attribute("src").getValue()));
				Element emap = body.element("map");
				
				List<Element> eles = emap.elements("area");
				for (Element el : eles) {
					Integer[] coors = this.getCoords(
							el.attribute("coords").getValue(), 
							emap.attribute("offsets").getValue());
					String[] ids = el.attribute("href").getValue().split(",");
					
					CutStepPosition cspvo = new CutStepPosition();
					cspvo.setStepid(new Long(ids[0]));
					cspvo.setTaskId(new Long(ids[1]));
					cspvo.setLeft(coors[0]);
					cspvo.setTop(coors[1]);
					cspvo.setWidth(coors[2]);
					cspvo.setHeight(coors[3]);
					
					CutTask ct = taskMap.get(cspvo.getTaskId());
					if(ct!=null){
						cspvo.setTaskName(ct.getTaskName());
						String taskStatus = ""+ct.getTaskStatus();
						cspvo.setStatus(taskStatus);
						cspvo.setBorderColor(Constants.borderColor.get(taskStatus));
						cspvo.setTaskTitle(Constants.taskTitle.get(taskStatus));
						cspvo.setTextColor(Constants.textColor.get(taskStatus));
					}
					
					reList.add(cspvo);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		map.put("images",reList);
		map.put("cutIndex", cutIndex);
		map.put("borderWidth", Constants.borderWidth.get(cutIndex));
		return "/progress/progressimage";
	}
	private Integer[] getCoords(String value,String s){
		String[] coors = value.split(",");
		
		String[] offsets = s.split(",");
		
		int x1 = Integer.parseInt(coors[0]);
		int y1 = Integer.parseInt(coors[1]);
		
		int x2 = Integer.parseInt(coors[2]);
		int y2 = Integer.parseInt(coors[3]);
		
		int left = x1 + Integer.parseInt(offsets[0]);
		int top = y1 + Integer.parseInt(offsets[1]);
		int width = (x2 - x1) + Integer.parseInt(offsets[2]);
		int height = (y2 - y1) + Integer.parseInt(offsets[3]);
		
		return new Integer[]{left, top, width, height};
	}
	
	private String getImageName(String src){
		return src.substring(src.lastIndexOf("/"));
	}
}
