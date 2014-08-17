package com.vxie.debut.tags;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.lang.reflect.Method;
import java.util.List;

public class SelectTag extends BodyTagSupport {
    private static final long serialVersionUID = -6891364924770628684L;
    protected static final Logger log = LoggerFactory.getLogger(SelectTag.class);

    /**
     * select的id属性
     */
    private String id;

    /**
     * select的name属性
     */
    private String name;

    /**
     * select的cssClass属性
     */
    private String cssClass;

    /**
     * select的styleCss属性
     */
    private String styleCss;

    /**
     * select的multiple属性
     */
    private String multiple;

    /**
     * select的onChange属性
     */
    private String onChange;

    /**
     * 页面传过来的List集合
     */
    private List<Object> items;

    /**
     * option的value对应的字段对应属性名
     */
    private String valueProperty;

    /**
     * option的text对应属性名
     */
    private String displayProperty;

    /**
     * option的当前值
     */
    private String currentValue;

    /**
     * option的默认显示
     */
    private String defaultDisplay = "全部";

    /**
     * option的默认值
     */
    private String defaultValue = "";


    public int doEndTag() throws JspException {
        StringBuilder sb = new StringBuilder("<select");
        PageContext pc = super.pageContext;
        try {
            if (!StringUtils.isBlank(id)) {
                sb.append(" id=\"").append(id).append("\" ");
            }
            if (!StringUtils.isBlank(name)) {
                sb.append(" name=\"").append(name).append("\" ");
            }
            if (!StringUtils.isBlank(cssClass)) {
                sb.append("class=\"").append(cssClass).append("\" ");
            }
            if (!StringUtils.isBlank(styleCss)) {
                sb.append("style=\"").append(styleCss).append("\" ");
            }
            if (!StringUtils.isBlank(multiple)) {
                sb.append(" multiple=\"").append(multiple).append("\"");
            }
            if (!StringUtils.isBlank(onChange)) {
                sb.append("onchange=\"").append(onChange).append("\"");
            }
            sb.append(">");
            if (defaultValue == null) {
                defaultValue = "";
            }
            sb.append("<option value = \"").append(defaultValue).append("\">").append(defaultDisplay).append("</option>");
            if (items != null && items.size() > 0) {
                for (Object object : items) {
                    String selected = " ";
                    Method optionMethod = object.getClass().getMethod("get" + upperFirstLetter(valueProperty));
                    Method dispayMethod = object.getClass().getMethod("get" + upperFirstLetter(displayProperty));
                    Object displayValue = dispayMethod.invoke(object);
                    Object optionValue = optionMethod.invoke(object);
                    if (currentValue != null && (currentValue.equals(optionValue.toString()))) {
                        selected = "selected";
                    }
                    sb.append("<option value=\"").append(optionValue.toString().trim()).append("\" ").append(selected).append(">").append(displayValue.toString()).append("</option>");
                }
            }
            sb.append("</select>");
            JspWriter out = pc.getOut();
            out.print(sb.toString());
        } catch (Exception e) {
            log.error("select标签输出出错", e);
        }
        return SKIP_BODY;
    }

    private String upperFirstLetter(String s) {
        if (StringUtils.isEmpty(s)) {
            return "";
        }
        return (s.charAt(0) + "").toUpperCase() + s.substring(1, s.length());
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCssClass() {
        return cssClass;
    }

    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }

    public String getStyleCss() {
        return styleCss;
    }

    public void setStyleCss(String styleCss) {
        this.styleCss = styleCss;
    }

    public String getMultiple() {
        return multiple;
    }

    public void setMultiple(String multiple) {
        this.multiple = multiple;
    }

    public String getOnChange() {
        return onChange;
    }

    public void setOnChange(String onChange) {
        this.onChange = onChange;
    }

    public List<Object> getItems() {
        return items;
    }

    public void setItems(List<Object> items) {
        this.items = items;
    }

    public String getValueProperty() {
        return valueProperty;
    }

    public void setValueProperty(String valueProperty) {
        this.valueProperty = valueProperty;
    }

    public String getDisplayProperty() {
        return displayProperty;
    }

    public void setDisplayProperty(String displayProperty) {
        this.displayProperty = displayProperty;
    }

    public String getCurrentValue() {
        return currentValue;
    }

    public void setCurrentValue(String currentValue) {
        this.currentValue = currentValue;
    }

    public String getDefaultDisplay() {
        return defaultDisplay;
    }

    public void setDefaultDisplay(String defaultDisplay) {
        this.defaultDisplay = defaultDisplay;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }
}
