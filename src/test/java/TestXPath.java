import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;


public class TestXPath {
	static final String coords = "coords";
	static final String href = "href";
	public static void main(String[] args) {
		
		Resource rs = new ClassPathResource("imgsetup.xhtml");
		if(rs.exists()){
			try {
				Document doc = new SAXReader().read(rs.getFile());
				List<Element> eles = doc.selectNodes("/html/body/map/area");
				for (Element el : eles) {
					el.attribute(coords).getValue();
					el.attribute(href).getValue();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}
}
