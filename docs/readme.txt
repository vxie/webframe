需要局方提供的东东：
1. 割接总体操作步骤， 一般为Excel格式
2. 割接总体操作步骤的流程图，即底图。 一般为jpg格式，由visio生成

操作步骤：(先在本机处理所有文件和数据，到时一起上传到应用环境，数据用导出脚本的方式在应用环境上创建）
一 本地操作
1. jpg格式的图片改名为cutshow-bk.jpg, 并另存到WebRoot/WEB-INF/app/resources/images/下。
2. excel文件改名为cutshow.xlsx(如果是.xls文件，需要转换成.xlsx), 并另存到WebRoot\WEB-INF\classes下。（cutshow.xlsx是在initDB.java生成步骤数据和任务数据时用到）
3. 把src\main\resources\initdb.sql copy到 WebRoot\WEB-INF\classes 目录下，
   执行src/test/initDB.java （根据cutshow.xlsx生成步骤数据(CUT_STEP)和任务数据(CUT_TASK))
   数据检查：
    select s.step_index,t.task_index, t.step_id,t.task_id, task_name from cut_task t, cut_step s
               where t.step_id=s.step_id
               order by s.step_index,t.task_index

4. 参考src/main/resources/imgsetup_template.xhtml在相同目录下新建imgsetup.xhtml, 用Macromedia Dreamweaver 8打开，添加并调整图片上的热点 (生成imgsetup.xhtml中的area节点，并确定位置)
5. 执行src/test/GenerateAreas.java (根据步骤数据(CUT_STEP)和任务数据(CUT_TASK)填充area节点的href属性)。
6. 把GenerateAreas.java执行修改好的imgsetup.xhtml拷贝到WebRoot\WEB-INF\classes目录下。
经过以上步骤已经可以在本地启动jetty运行。


打包与解包：
zip -r cutshow_st.zip ./cutshow
unzip -o -d /home cutshow_st.zip

zip -r cutshow_0715.zip ./


命令行启动/关闭jetty:
启动：
nohup java -DSTOP.PORT=9999 -DSTOP.KEY=oam -jar start.jar >/dev/null &
可以加上更多的参数：
nohup java -Xms512m -Xmx512m -XX:MaxNewSize=256m -XX:MaxPermSize=256m -DSTOP.PORT=9999 -Djetty.port=8000 -DSTOP.KEY=cutshow -jar start.jar >/dev/null &

关闭：
java -DSTOP.PORT=9999 -DSTOP.KEY=oam -jar start.jar --stop



startup.sh 的正确写法是：
#!/bin/bash
nohup /usr/java/jdk1.6.0_01/jre/bin/java -DSTOP.PORT=9999 -DSTOP.KEY=oam -jar start.jar >/home/cutshow/webserver/jetty6/cutshow.log &

需要注意的：
1. nohup 不能去掉，在redhat下测试发现没有nohup的时候一关闭终端jetty就会关闭。（250那台机器没用nohup，不过退出终端后jetty还正常运行，尚不清楚原因）
2. 使用nohup之后可以把jetty的日志重定向到自定义的文件/home/cutshow/webserver/jetty6/logs/cutshow.log。












