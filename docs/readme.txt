2014-07-19：
1. 会员管理
   a.新建/编辑会员时，“病历附件”作为一个文件选择框，用于上传病历图片(保存路径可配置)。保存会员时同时新增或更新病历表中的对应记录。
   b.t_user filename 字段弃用，留空; 病历表待完善。
   c.list页面增加“编辑病历”链接。
2. 方案管理
   a.新增方案时，对每个字段增加该字段是否可以编辑的开关，对于开关不打开的字段，在编辑方案的时候disabled。t_plan需要
     增加对应的开关字段。
   b."制定计划"菜单可以去掉。
3. 主界面管理
   a.增加系统参数，用来限制 t_layout.useing 为0(显示) 的最大记录数。
   b.新增/编辑t_layout记录的时候增加选择图片的文件选择框，用于上传病历图片(保存路径可配置),并将图片的名称登记到t_layout.picName字段。
   c.list页面增加预览图片功能。





// globalConfig.getStringItemByArea("SYSTEM_PARAM", "medical_record_path");



















