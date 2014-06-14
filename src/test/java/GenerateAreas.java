
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.sunrise.springext.dao.BaseDaoHibernateImpl;
import com.sunrise.springext.dao.IBaseDao;

public class GenerateAreas {
	public static ApplicationContext ac;
	public static IBaseDao dao;

	public static void main(String[] args) throws Exception {
		ac = new FileSystemXmlApplicationContext("file:WebRoot/WEB-INF/app-servlet.xml");

		dao = ac.getBean("dao", BaseDaoHibernateImpl.class);
		
		GenerateAreas.replaceAreaProperites(GenerateAreas.readStepInfos());
	}
	
	public static void replaceAreaProperites(Map<String, String> map){
		FileSystemResource resource = new FileSystemResource("file:WebRoot/../src/main/resources/imgsetup.xhtml");
		try {
			String headLine = "";
			if(resource.exists()){
				StringBuffer buff = new StringBuffer();
				BufferedReader reader = null;
				try {
	                 reader = new BufferedReader(new FileReader(resource.getFile()));
	                 headLine = reader.readLine()+"\n";
	                 String line = reader.readLine();
	            	 while(line != null){
	                     buff.append(line+"\n");
	                     line = reader.readLine();
	                 }
	 			} catch (Exception e) {
					e.printStackTrace();
				} finally{
					reader.close();
				}
				
				Document doc = DocumentHelper.parseText(buff.toString());
				Element body = doc.getRootElement().element("body");
				
				Set<String> set = new HashSet<String>();
				List<Element> eles = body.element("map").elements("area");
				for (Element el : eles) {
					String id = el.attributeValue("alt");
					if(set.contains(id)){
						System.out.println("Double key = " + id);
						System.exit(0);
					}
					set.add(id);
					el.attribute("href").setValue(map.get(id));
				}
				
				if(set.size()!=map.keySet().size()){
					System.out.println("The element area number["+set.size()+"] no equals db's number["+map.keySet().size()+"]!");
					System.exit(0);
				}

				FileWriter writer = new FileWriter(resource.getFile(), false);
				try {
		            writer.write(headLine+doc.asXML());
		            writer.flush();
				} catch (Exception e) {
			       e.printStackTrace();
				} finally{
					 writer.close();
				}
	            
				System.out.println("..............OK!");
				System.out.println("Done!");

			}else{
				System.out.println("..............ERROR!");
				System.out.println("The file[WebRoot/../src/main/resources/imgsetup.xhtml] not exits!");
				System.exit(0);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	

	public static Map<String, String> readStepInfos(){
		System.out.print("Initializing background image information ..............");

		final Map<String, String> map = new HashMap<String, String>();

		String sql = 
				" select t.step_id,t.task_id,s.step_index,t.task_index from cut_task t, cut_step s "+
				" where t.step_id=s.step_id "+
				" order by s.step_index,t.task_index ";
		
		dao.getSimpleJdbcTemplate().query(sql, new RowMapper<Object>() {
			public Object mapRow(ResultSet rs, int arg1) throws SQLException {
				map.put(rs.getInt(3)+"."+rs.getInt(4), rs.getInt(1)+","+rs.getInt(2));
				return null;
			}
		});
		
		return map;
	}
}
