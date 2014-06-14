
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import com.sunrise.cutshow.business.CutUserService;
import com.sunrise.cutshow.model.CutBaseInfo;
import com.sunrise.cutshow.model.CutStep;
import com.sunrise.cutshow.model.CutTask;
import com.sunrise.cutshow.model.CutUser;
import com.sunrise.cutshow.utils.MD5Encoder;
import com.sunrise.springext.dao.BaseDaoHibernateImpl;
import com.sunrise.springext.dao.IBaseDao;

public class InitDB {
	public static final String DEFAULT_PWD = MD5Encoder.encode("12345");
	public static ApplicationContext ac;
	public static IBaseDao dao;

	public static void main(String[] args) throws Exception {
        try {
            if (args.length == 0) {
                ac = new FileSystemXmlApplicationContext(
                        "file:WebRoot/WEB-INF/app-servlet.xml");
            } else {
                ac = new FileSystemXmlApplicationContext("file:" + args[0]);
            }
            dao = ac.getBean("dao", BaseDaoHibernateImpl.class);

            ClassPathResource resource = new ClassPathResource("cutshow.xlsx");
            if (!resource.exists()) {
                System.out.println("File[cutshow.xlsx] is not found!");
                System.exit(0);
            }
            XSSFWorkbook workbook = new XSSFWorkbook(new FileInputStream(
                    resource.getFile()));
            Sheet sheet = null;
            for (XSSFSheet xssfsheet : workbook) {
                if(xssfsheet.getSheetName().indexOf("总体步骤")>-1){ //选择指定工作表
                    sheet = xssfsheet;
                    break;
                }
            }
            if(sheet==null){
                System.out.println("Main sheet of workbook is not found!");
                System.exit(0);
            }
            int n = findCol(sheet.getRow(0), "负责人"); //局方负责人

            if(n>-1){
                init();

                String totalOwnerName = "李达群";
                String cutshowTitle = "NGBOSS汕头区域割接总体割接流程";
                String cutshowTime = "2013-03-15 09:00:00";

                handleUsers(sheet, n, totalOwnerName,cutshowTitle, cutshowTime);
                handleSteps(sheet, n);

            }else{
                System.out.println("Owner's column is not found!");
                System.exit(0);
            }
        } catch (Exception e) {
            System.out.println("Init database fail!!!");
            e.printStackTrace();
        }
    }

	@Transactional
	public static void init() {
		
		System.out.print("Initializing tables constructor ..............");
		ClassPathResource resource = new ClassPathResource("initdb.sql");
		if (!resource.exists()) {
			System.out.println("File[initdb.sql] is not found!");
			System.exit(0);
		}
		BufferedReader reader = null;
		StringBuffer buff = new StringBuffer();
		try {
			reader = new BufferedReader(new FileReader(resource.getFile()));
			String line = reader.readLine();
			while (line != null) {
				buff.append(line);
				line = reader.readLine();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				reader.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			
		}
		
		String[] sqls = buff.toString().split(";");
		try {
			if(dao.getSimpleJdbcTemplate().queryForInt("select count(*) from user_tables where table_name=upper('CUT_BASE_INFO')")>0){
				String[] s = 
			   ("drop table CUT_BASE_INFO cascade constraints;"
			   +"drop table CUT_MENU cascade constraints;"
			   +"drop table CUT_ROLE cascade constraints;"
			   +"drop table CUT_ROLE_MENU cascade constraints;"
			   +"drop table CUT_STEP cascade constraints;"
			   +"drop table CUT_STEP_USER cascade constraints;"
			   +"drop table CUT_TASK cascade constraints;"
			   +"drop table CUT_USER cascade constraints;"
			   +"drop table CUT_USER_ROLE cascade constraints").split(";");
				dao.getSimpleJdbcTemplate().getJdbcOperations().batchUpdate(s);
			}
			dao.getSimpleJdbcTemplate().getJdbcOperations().batchUpdate(sqls);
		}catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("..............OK!");
	}

	@Transactional
	public static void handleUsers(Sheet sheet, int n, String cutowner, String cutshowTitle, String cutshowTime)
			throws Exception {
        //n--局方负责人所在的列下标
		System.out.print("Initializing users information ..............");
		dao.getSimpleJdbcTemplate().update(
				"delete from cut_user_role where user_id<>1");
		dao.getSimpleJdbcTemplate().update(
				"delete from cut_user where user_login_name<>'admin'");

		Map<String, String> map = new HashMap<String, String>();
		map.put(getPingYin(cutowner), cutowner);

		if (n > -1) {
			int i = 1;  //第1个步骤所在的行下标，从0开始
			Row r = sheet.getRow(i);
			while (r != null) {
				String value = getCellText(r.getCell(n));
				if (!StringUtils.isEmpty(value)) {
					value = value.replaceAll("，", ",").replaceAll("/", ",").replaceAll("、", ",");
					if (value.indexOf(",") > -1) {
						String[] vals = value.split(",");
						for (String v : vals) {
							map.put(getPingYin(v), v);
						}
					} else {
						map.put(getPingYin(value), value);
					}

				}

				++i;
				r = sheet.getRow(i);
			}
		}

		Long id = 1001L;
		for (Entry<String, String> entry : map.entrySet()) {
			CutUser cutUser = new CutUser();
			if (entry.getValue().equals(cutowner)) {
				cutUser.setUserId(99L);
			} else {
				cutUser.setUserId(id++);
			}

			cutUser.setUserLoginName(entry.getKey());
			cutUser.setUserRealName(entry.getValue());
			cutUser.setUserPassword(DEFAULT_PWD);
			dao.save(cutUser);
			if (entry.getValue().equals(cutowner)) {
				dao.getSimpleJdbcTemplate()
						.update("insert into cut_user_role(user_id, role_id) values(?, ?)",
								cutUser.getUserId(), 2);
			} else {
				dao.getSimpleJdbcTemplate()
						.update("insert into cut_user_role(user_id, role_id) values(?, ?)",
								cutUser.getUserId(), 21); //子任务负责人
				dao.getSimpleJdbcTemplate()
						.update("insert into cut_user_role(user_id, role_id) values(?, ?)",
								cutUser.getUserId(), 22); //子任务检查人
			}
		}
		
		CutBaseInfo info = new CutBaseInfo();
		info.setCutInfoId(1L);
		info.setCutManagerId(99L);
		info.setCutBeginTime(cutshowTime);
		info.setCutTitle(cutshowTitle);
		dao.saveOrUpdate(info);

		System.out.println("...............OK!");
	}

	@Transactional
	public static void handleSteps(Sheet sheet, int n) throws Exception {
		System.out.print("Initializing steps and tasks information ..............");
		
		dao.getSimpleJdbcTemplate().update("delete from cut_task");
		dao.getSimpleJdbcTemplate().update("delete from cut_step_user");
		dao.getSimpleJdbcTemplate().update("delete from cut_step");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:00");
		Long sid = 1L;
		List<CutStep> list = new ArrayList<CutStep>();
		int i = 1;  //第1个步骤所在的行下标，从0开始
		Row r = sheet.getRow(i);
		long x = 0L;
		long tid = 1L;
		long tindex = 1L;
		CutStep c = null;
		while (r != null) {
			if (isStep(r.getCell(1))) {//新文档的章节号在第2列
				String weightValue = getCellText(r.getCell(3)); //权重在第4列
                //修改前一个step的耗时
//				if (c != null) {
//					c.setStepTimes(x); //分种
//					dao.update(c);
//				}

				x = 0L;
				tindex = 1L;
				c = new CutStep();
				c.setStepId(sid++);
				c.setStepWeightValue(Float.valueOf(weightValue).longValue());
				c.setStepIndex(c.getStepId());
				c.setStepName(getCellText(r.getCell(2))); //任务名称在第3列
				c.setStepOwnerId(99L);  //步骤负责人指定“李达群”

                //步骤时间
                Date startTime = r.getCell(7).getDateCellValue();
                Date endTime = r.getCell(8).getDateCellValue();
                Long stepTimes = findTimes(startTime, endTime); //分钟
                c.setStepTimes(stepTimes);

				dao.save(c);

				String value = getCellText(r.getCell(n));
				if (!StringUtils.isEmpty(value)) {
					value = value.replaceAll("，", ",").replaceAll("、", ",");
					if (value.indexOf(",") > -1) {
						String[] vals = value.split(",");
						for (String v : vals) {
							Long userId = findUserId(getPingYin(v));
							if (userId != null) {
								dao.getSimpleJdbcTemplate()
										.update("insert into cut_step_user(step_id, user_id) values(?, ?)",
												c.getStepId(), userId);
							}
						}
					} else {
						Long userId = findUserId(getPingYin(value));
						if (userId != null) {
							dao.getSimpleJdbcTemplate()
									.update("insert into cut_step_user(step_id, user_id) values(?, ?)",
											c.getStepId(), userId);
						}
					}
				}
			} else {
				CutTask t = new CutTask();

				Date startTime = r.getCell(7).getDateCellValue();
				Date endTime = r.getCell(8).getDateCellValue();
//				x += findTimes(startTime, endTime);
                Long taskTimes = findTimes(startTime, endTime);
                t.setTaskTimes(taskTimes);

				// t.setStartTime(startTime==null?null:sdf.format(startTime));
				// t.setFinishTime(endTime==null?null:sdf.format(endTime));
				t.setTaskIndex(tindex++);
				t.setTaskId(tid++);
				t.setTaskName(getCellText(r.getCell(2)));

				String value = getCellText(r.getCell(n));
				if (!StringUtils.isEmpty(value)) {
					value = value.replaceAll("，", ",").replaceAll("、", ",");
					if (value.indexOf(",") > -1) {
						value = value.split(",")[0];
					}
					Long userId = findUserId(getPingYin(value));
					t.setTaskOperaterId(userId == null ? 1L : userId);
				} else {
                    t.setTaskOperaterId(99L); //当负责人为空时，插入“李达群”
                }

                if (c != null) {
                    t.setStepId(c.getStepId());
                }

				dao.save(t);
			}
			++i;
			r = sheet.getRow(i);
		}
		System.out.println(".....OK!");

		System.out.println("Done!");
	}

	private static long findTimes(Date startTime, Date endTime) {
		if (startTime != null && endTime != null) {
			try {
				return (endTime.getTime() - startTime.getTime()) / (1000 * 60);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return 0;
	}

	private static Long findUserId(String loginName) {
		List<CutUser> list = (List<CutUser>) dao.find(
				"from CutUser u where u.userLoginName=?", loginName);
		if (!list.isEmpty()) {
			return list.get(0).getUserId();
		}
		return null;
	}

	private static Long Double2Long(String v) {
		String s = v + "";
		int i = s.indexOf(".");
		if (!StringUtils.isEmpty(s) && i > 0) {
			return Long.parseLong(s.substring(0, i));
		}
		return 0L;
	}

	private static boolean isStep(Cell cell) {
		String s = getCellText(cell);
		return s.endsWith(".0") || s.indexOf(".") == -1;
	}

	private static String getCellText(Cell cell) {
		if (cell.getCellType() == XSSFCell.CELL_TYPE_STRING) {
			return cell.getStringCellValue().trim();
		} else if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
			return cell.getNumericCellValue() + "";
		} else if (cell.getCellType() == XSSFCell.CELL_TYPE_FORMULA) {
			return cell.getCellFormula().trim();
		}
		return "";
	}

	private static int findCol(Row row, String title) {
		for (Iterator iter = row.cellIterator(); iter.hasNext();) {
			Cell cell = (Cell) iter.next();
			String s = getCellText(cell);
			if (s.equals(title)) {
				return cell.getColumnIndex();
			}
		}
		return -1;
	}

	private static String getPingYin(String src) {
		char[] t1 = null;
		t1 = src.toCharArray();
		String[] t2 = new String[t1.length];
		HanyuPinyinOutputFormat t3 = new HanyuPinyinOutputFormat();
		t3.setCaseType(HanyuPinyinCaseType.LOWERCASE);
		t3.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		t3.setVCharType(HanyuPinyinVCharType.WITH_V);
		String t4 = "";
		int t0 = t1.length;
		try {
			for (int i = 0; i < t0; i++) {
				// 判断是否为汉字字符
				if (java.lang.Character.toString(t1[i]).matches(
						"[\u4E00-\u9FA5]+")) {
					t2 = PinyinHelper.toHanyuPinyinStringArray(t1[i], t3);
					t4 += t2[0];
				} else
					t4 += java.lang.Character.toString(t1[i]);
			}
			// System.out.println(t4);
			return t4;
		} catch (BadHanyuPinyinOutputFormatCombination e1) {
			e1.printStackTrace();
		}
		return t4;
	}
}
