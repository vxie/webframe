2014-08-15：
1. 会员管理
   a.新建/编辑会员时，“病历附件”作为一个文件选择框，用于上传病历图片(保存路径可配置)。传件名称保存在 t_user.filename 字段。
   b.点击查询列表中的“病历附件”提供预览功能(word,pdf,图片).
   c.病历表t_medicalRecord不再使用。
   d.去掉“编辑病历”功能。
2. 方案管理
   a.新增方案时，对每个字段增加该字段是否可以编辑的开关，对于开关不打开的字段，在编辑方案的时候disabled。t_plan需要
     增加对应的开关字段。
   b."制定计划"菜单可以去掉。
3. 主界面管理
   a.增加系统参数，用来限制 t_layout.useing 为0(显示) 的最大记录数。
   b.新增/编辑t_layout记录的时候增加选择图片的文件选择框，用于上传病历图片(保存路径可配置),并将图片的名称登记到t_layout.picName字段。
   c.list页面增加预览图片功能。





// globalConfig.getStringItemByArea("SYSTEM_PARAM", "medical_record_path");


MySQLURL:   jdbc:mysql://192.168.0.101:3306/devdb

连接报错: (Access denied for user 'root'@'xxx' (using password: YES))
解决办法：
grant all on *.* to root@"%" Identified by "123456";



















