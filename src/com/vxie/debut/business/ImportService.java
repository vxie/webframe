package com.vxie.debut.business;

import java.io.File;

import jxl.Workbook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>Description: </p>
 * <p>Company: sunrise Tech Ltd.</p>
 * @author tanggensheng
 * @date 2012-8-1上午11:40:07
 */
@Service
public class ImportService extends BaseService {
	
	@Autowired
	private CutUserService cutUserService;
	@Autowired
	private CutTaskService cutTaskService;
	@Autowired
	private CutStepService cutStepService;

	public String handleXlsFile(String userId, File file, String subject) throws Exception {
		Workbook book = null;
		try {
			book = Workbook.getWorkbook(file);
			return importData(userId, book, subject);
		} finally{
        	if(book != null){
        		book.close();
        		book = null;
        		file.delete();
        	}
        }
	}

	private String importData(String userId, Workbook book, String subject) throws Exception {
		String dataCount = "0";
		if("user".equals(subject)){ //用户
			dataCount = cutUserService.importCutUser(book);
		} else if("task".equals(subject)){//任务
			dataCount = cutTaskService.importTask(book);
		} else if("step".equals(subject)){//步骤
			dataCount = cutStepService.importStep(book);
		}
//		 else if("kpiIns".equals(subject)){//KPI实例
//			dataCount = kpiInsService.importKpiIns(userId, book);
//		}
		return dataCount;
	}
}
