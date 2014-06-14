prompt PL/SQL Developer import file
prompt Created on 2011年5月5日 by maxim
set feedback off
set define off
prompt Creating CUT_BASE_INFO...
create table CUT_BASE_INFO
(
  CUT_INFO_ID    NUMBER(12) not null,
  CUT_TITLE      VARCHAR2(100),
  CUT_BEGIN_TIME VARCHAR2(20),
  CUT_MANAGER_ID NUMBER(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column CUT_BASE_INFO.CUT_INFO_ID
  is 'ID';
comment on column CUT_BASE_INFO.CUT_TITLE
  is '割接标题';
comment on column CUT_BASE_INFO.CUT_BEGIN_TIME
  is '割接开始时间';
comment on column CUT_BASE_INFO.CUT_MANAGER_ID
  is '割接负责人';
alter table CUT_BASE_INFO
  add constraint PK_CUT_BASE_INFO primary key (CUT_INFO_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating CUT_MENU...
create table CUT_MENU
(
  MENU_ID        NUMBER(12) not null,
  MENU_NAME      VARCHAR2(100) not null,
  MENU_URL       VARCHAR2(100),
  MENU_PARENT_ID NUMBER(12),
  MENU_INDEX     NUMBER(2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table CUT_MENU
  add constraint PK_CUT_MENU primary key (MENU_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating CUT_ROLE...
create table CUT_ROLE
(
  ROLE_ID   NUMBER(12) not null,
  ROLE_NAME VARCHAR2(100) not null,
  ROLE_MEMO VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table CUT_ROLE
  add constraint PK_CUT_ROLE primary key (ROLE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating CUT_ROLE_MENU...
create table CUT_ROLE_MENU
(
  ROLE_ID NUMBER(12) not null,
  MENU_ID NUMBER(12) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table CUT_ROLE_MENU
  add constraint PK_CUT_ROLE_MENU primary key (MENU_ID, ROLE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating CUT_STEP...
create table CUT_STEP
(
  STEP_ID           NUMBER(12) not null,
  STEP_NAME         VARCHAR2(100) not null,
  STEP_WEIGHT_VALUE NUMBER(2) not null,
  STEP_CUR_PERCENT  NUMBER(3),
  STEP_TIMES        NUMBER(4),
  STEP_OWNER_ID     NUMBER(12),
  STEP_CHECKER_ID   NUMBER(12),
  STEP_INDEX        NUMBER(2),
  STEP_STATUS       NUMBER(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column CUT_STEP.STEP_ID
  is '步骤ID';
comment on column CUT_STEP.STEP_NAME
  is '步骤名称';
comment on column CUT_STEP.STEP_WEIGHT_VALUE
  is '步骤权重(占整个割接进度的)';
comment on column CUT_STEP.STEP_CUR_PERCENT
  is '步骤当前百分比';
comment on column CUT_STEP.STEP_TIMES
  is '步骤时长（分钟）';
comment on column CUT_STEP.STEP_OWNER_ID
  is '步骤负责人ID';
comment on column CUT_STEP.STEP_CHECKER_ID
  is '步骤检查人ID';
alter table CUT_STEP
  add constraint PK_CUT_STEP primary key (STEP_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating CUT_STEP_USER...
create table CUT_STEP_USER
(
  STEP_ID NUMBER(12) not null,
  USER_ID NUMBER(12) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table CUT_STEP_USER
  add constraint PK_CUT_STEP_USER primary key (STEP_ID, USER_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating CUT_TASK...
create table CUT_TASK
(
  TASK_ID            NUMBER(12) not null,
  TASK_NAME          VARCHAR2(100) not null,
  TASK_OPERATER_ID   NUMBER(12) not null,
  TASK_CHECKER_ID    NUMBER(12),
  TASK_TIMES         NUMBER(4),
  STEP_ID            NUMBER(12) not null,
  TASK_SHELL_COMMAND VARCHAR2(3000),
  TASK_INDEX         NUMBER(3),
  TASK_STATUS        NUMBER(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column CUT_TASK.TASK_ID
  is '子任务ID';
comment on column CUT_TASK.TASK_NAME
  is '子任务名称';
comment on column CUT_TASK.TASK_OPERATER_ID
  is '操作人ID';
comment on column CUT_TASK.TASK_CHECKER_ID
  is '检查人ID';
comment on column CUT_TASK.TASK_TIMES
  is '子任务计划时长（分钟）';
comment on column CUT_TASK.STEP_ID
  is '步骤ID';
comment on column CUT_TASK.TASK_SHELL_COMMAND
  is '子任务可执行Shell命令';
alter table CUT_TASK
  add constraint PK_CUT_TASK primary key (TASK_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating CUT_USER...
create table CUT_USER
(
  USER_ID         NUMBER(12) not null,
  USER_LOGIN_NAME VARCHAR2(50) not null,
  USER_REAL_NAME  VARCHAR2(50) not null,
  USER_PASSWORD   VARCHAR2(50),
  USER_MEMO       VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table CUT_USER
  add constraint PK_CUT_USER primary key (USER_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
create unique index IDX_USER_LOGIN_NAME on CUT_USER (USER_LOGIN_NAME)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating CUT_USER_ROLE...
create table CUT_USER_ROLE
(
  USER_ID NUMBER(12) not null,
  ROLE_ID NUMBER(12) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table CUT_USER_ROLE
  add constraint PK_CUT_USER_ROLE primary key (USER_ID, ROLE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Disabling triggers for CUT_BASE_INFO...
alter table CUT_BASE_INFO disable all triggers;
prompt Disabling triggers for CUT_MENU...
alter table CUT_MENU disable all triggers;
prompt Disabling triggers for CUT_ROLE...
alter table CUT_ROLE disable all triggers;
prompt Disabling triggers for CUT_ROLE_MENU...
alter table CUT_ROLE_MENU disable all triggers;
prompt Disabling triggers for CUT_STEP...
alter table CUT_STEP disable all triggers;
prompt Disabling triggers for CUT_STEP_USER...
alter table CUT_STEP_USER disable all triggers;
prompt Disabling triggers for CUT_TASK...
alter table CUT_TASK disable all triggers;
prompt Disabling triggers for CUT_USER...
alter table CUT_USER disable all triggers;
prompt Disabling triggers for CUT_USER_ROLE...
alter table CUT_USER_ROLE disable all triggers;
prompt Deleting CUT_USER_ROLE...
delete from CUT_USER_ROLE;
commit;
prompt Deleting CUT_USER...
delete from CUT_USER;
commit;
prompt Deleting CUT_TASK...
delete from CUT_TASK;
commit;
prompt Deleting CUT_STEP_USER...
delete from CUT_STEP_USER;
commit;
prompt Deleting CUT_STEP...
delete from CUT_STEP;
commit;
prompt Deleting CUT_ROLE_MENU...
delete from CUT_ROLE_MENU;
commit;
prompt Deleting CUT_ROLE...
delete from CUT_ROLE;
commit;
prompt Deleting CUT_MENU...
delete from CUT_MENU;
commit;
prompt Deleting CUT_BASE_INFO...
delete from CUT_BASE_INFO;
commit;
prompt Loading CUT_BASE_INFO...
insert into CUT_BASE_INFO (CUT_INFO_ID, CUT_TITLE, CUT_BEGIN_TIME, CUT_MANAGER_ID)
values (1, '珠海融合计费割接进度', '2011-06-30 09:30:41', 1100);
commit;
prompt 1 records loaded
prompt Loading CUT_MENU...
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (1, '总体进度', '/progress/list', null, 1);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (2, '步骤执行', '/progress/steps/exec', null, 2);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (3, '任务执行', '/progress/tasks/exec', null, 3);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (100, '割接配置', null, null, 2);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (110, '基本信息', '/baseinfo/set', 100, 1);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (120, '步骤配置', '/step/set', 100, 2);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (130, '任务配置', '/task/set', 100, 3);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (200, '系统管理', null, null, 3);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (210, '用户管理', '/user/list', 200, 1);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (220, '角色管理', '/role/list', 200, 2);
commit;
prompt 10 records loaded
prompt Loading CUT_ROLE...
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (1, '系统管理员', null);
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (2, '割接总负责人', null);
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (3, '总体进度观察', null);
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (11, '步骤负责人', null);
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (12, '步骤检查人', null);
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (21, '子任务操作人', null);
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (22, '子任务检查人', null);
commit;
prompt 7 records loaded
prompt Loading CUT_ROLE_MENU...
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (3, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 2);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (11, 2);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (12, 2);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 3);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (21, 3);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (22, 3);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 100);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 100);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (11, 100);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (21, 100);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 110);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 110);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 120);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (11, 120);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 130);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (11, 130);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (21, 130);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 200);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 200);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 210);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 210);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 220);
commit;
prompt 25 records loaded
prompt Loading CUT_STEP...
insert into CUT_STEP (STEP_ID, STEP_NAME, STEP_WEIGHT_VALUE, STEP_CUR_PERCENT, STEP_TIMES, STEP_OWNER_ID, STEP_CHECKER_ID, STEP_INDEX, STEP_STATUS)
values (1118, '离线计费话单挂起', 30, 0, 110, 1103, 1113, 3, 0);
insert into CUT_STEP (STEP_ID, STEP_NAME, STEP_WEIGHT_VALUE, STEP_CUR_PERCENT, STEP_TIMES, STEP_OWNER_ID, STEP_CHECKER_ID, STEP_INDEX, STEP_STATUS)
values (1119, '周边系统配合割接', 30, 0, 120, 1113, 1113, 4, 0);
insert into CUT_STEP (STEP_ID, STEP_NAME, STEP_WEIGHT_VALUE, STEP_CUR_PERCENT, STEP_TIMES, STEP_OWNER_ID, STEP_CHECKER_ID, STEP_INDEX, STEP_STATUS)
values (1116, '应用部署检查', 10, 85, 200, 1101, 1102, 1, 1);
insert into CUT_STEP (STEP_ID, STEP_NAME, STEP_WEIGHT_VALUE, STEP_CUR_PERCENT, STEP_TIMES, STEP_OWNER_ID, STEP_CHECKER_ID, STEP_INDEX, STEP_STATUS)
values (1117, '基础数据检查', 30, 0, 140, 1111, 1104, 2, 0);
commit;
prompt 4 records loaded
prompt Loading CUT_STEP_USER...
insert into CUT_STEP_USER (STEP_ID, USER_ID)
values (1116, 1101);
insert into CUT_STEP_USER (STEP_ID, USER_ID)
values (1116, 1102);
insert into CUT_STEP_USER (STEP_ID, USER_ID)
values (1116, 1112);
insert into CUT_STEP_USER (STEP_ID, USER_ID)
values (1117, 1104);
insert into CUT_STEP_USER (STEP_ID, USER_ID)
values (1117, 1111);
insert into CUT_STEP_USER (STEP_ID, USER_ID)
values (1117, 1114);
insert into CUT_STEP_USER (STEP_ID, USER_ID)
values (1118, 1103);
insert into CUT_STEP_USER (STEP_ID, USER_ID)
values (1118, 1105);
insert into CUT_STEP_USER (STEP_ID, USER_ID)
values (1118, 1113);
insert into CUT_STEP_USER (STEP_ID, USER_ID)
values (1119, 1107);
insert into CUT_STEP_USER (STEP_ID, USER_ID)
values (1119, 1112);
insert into CUT_STEP_USER (STEP_ID, USER_ID)
values (1119, 1113);
commit;
prompt 12 records loaded
prompt Loading CUT_TASK...
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1123, '营业后台应用检查', 1112, 1112, 20, 1116, 'ps -ef|grep 程序名' || chr(13) || '' || chr(10) || '', 3, 2);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1124, '系统与网络环境检查(包括接口机网络、文件的检查)', 1112, 1112, 30, 1116, null, 4, 2);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1125, 'MQ状态检查', 1112, 1112, 30, 1116, null, 5, 2);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1121, 'WebSphere配置准备', 1112, 1112, 30, 1116, '1、分别登录三个控制台：' || chr(13) || '' || chr(10) || 'http://10.243.208.86:9060/ibm/console' || chr(13) || '' || chr(10) || 'http://10.243.208.88:9060/ibm/console' || chr(13) || '' || chr(10) || 'http://10.243.208.90:9060/ibm/console' || chr(13) || '' || chr(10) || 'http://10.243.208.92:9060/ibm/console' || chr(13) || '' || chr(10) || '2、检查所有cluster、server的状态是否正常。' || chr(13) || '' || chr(10) || '3、从资源—〉JDBC提供程序—〉集群—〉Cluster1 —〉Oracle JDBC Driver —〉数据源 菜单中测试所有jdbc的连接是否正常。', 1, 4);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1126, 'TT状态检查', 1112, 1112, 30, 1116, null, 6, 2);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1122, 'HTTP Server配置准备', 1112, 1112, 30, 1116, '"1、分别登录web服务器：' || chr(13) || '' || chr(10) || 'S1_E_YZ_WEB        10.243.210.97' || chr(13) || '' || chr(10) || 'S2_E_YZ_WEB        10.243.210.98' || chr(13) || '' || chr(10) || 'S3_E_YZ_WEB        10.243.210.99' || chr(13) || '' || chr(10) || 'S4_E_YZ_WEB        10.243.210.100' || chr(13) || '' || chr(10) || 'S6_E_YZ_WEB        10.243.210.1' || chr(13) || '' || chr(10) || 'S7_E_YZ_WEB        10.243.210.2' || chr(13) || '' || chr(10) || 'S8_E_YZ_WEB        10.243.210.3' || chr(13) || '' || chr(10) || '2、用命令ps -ef|grep httpd检查HTTP的服务进程是否存在。"' || chr(13) || '' || chr(10) || '', 2, 2);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1127, '离线话单配置检查', 1112, 1112, 30, 1116, null, 7, 1);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1128, '屏蔽语音流程、播放割接通告', 1112, 1112, 30, 1119, null, 1, 0);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1129, '自助终端系统、网站系统、短信营业厅系统（全品牌）', 1112, 1112, 30, 1119, null, 2, 0);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1130, '屏蔽业务流程、上挂割接通告', 1112, 1112, 60, 1119, null, 3, 0);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1131, '明确了割接日期和时间后,修改msi表，shift表', 1105, 1115, 30, 1118, '"rise41' || chr(13) || '' || chr(10) || '目录：/home1/devis/_chx/_huig/_poc' || chr(13) || '' || chr(10) || '1、设置ims表：把割接号段旧资料截止到2010-01-27 23:29:59，从2010-01-27 23:30:00开始用新的用户类型；' || chr(13) || '' || chr(10) || '2、设置shift表： shift表中插入割接号段和开始割接时间点，割接状态标志设为割接中。' || chr(13) || '' || chr(10) || '3、设置msi_oscp表：中山此次割接到两个OCE，如下 ' || chr(13) || '' || chr(10) || 'oscp_name=？ gt=？ scp_ename=？  vc_chg_point = ？（稍后补充）' || chr(13) || '' || chr(10) || 'GT码以现场提供为准，现场不能提供时可以选择一个默认值。' || chr(13) || '' || chr(10) || '详见：GMCC OCE提供Rchg充值文件离线计费处理需求分析说明书.doc' || chr(13) || '' || chr(10) || '4、同步ezfp0ims和ezfp0msi_oscp表到新旧系统生产机，同步sysp1_inf_shift到旧系统；' || chr(13) || '' || chr(10) || '108 目录：/gpsfapp/ndb1/_ziliao/_Gejie/_poc/' || chr(13) || '' || chr(10) || '1）截停sysp1_inf_ims和sysp1_inf_msi的旧用户类型记录，新增新用户类型记录' || chr(13) || '' || chr(10) || '运行msi.sql，检查msi.log；' || chr(13) || '' || chr(10) || '2）更新syps1_inf_msi_scp表：' || chr(13) || '' || chr(10) || 'oscp_name=？ gt=？ scp_ename=？  vc_chg_point = ？（稍后补充）' || chr(13) || '' || chr(10) || '3）设置sysp1_inf_shift表：插入割接号段和开始割接时间点，割接状态标志设为割接中。' || chr(13) || '' || chr(10) || '4）通知检查、并启程序。"' || chr(13) || '' || chr(10) || '', 1, 0);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1132, '重起一批程序', 1105, 1115, 30, 1118, '从监控界面停一批进程；' || chr(13) || '' || chr(10) || '监控界面启一批程序；' || chr(13) || '' || chr(10) || '重启后，一批应有8个进程。', 2, 0);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1133, '停Tso的grps和billgen进程，不再向scp送gprs和billgen话单', 1105, 1115, 20, 1118, '停Tso的gprs和billgen进程', 3, 0);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1134, '重启新旧用户状态中心库statebase', 1105, 1106, 30, 1118, null, 4, 0);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1135, '割接程序目录部署检查', 1114, 1114, 20, 1117, '"cd /gpfs1/oce ' || chr(13) || '' || chr(10) || './bin' || chr(13) || '' || chr(10) || './cfg' || chr(13) || '' || chr(10) || './newdata' || chr(13) || '' || chr(10) || './olddata' || chr(13) || '' || chr(10) || './log' || chr(13) || '' || chr(10) || './temp"' || chr(13) || '' || chr(10) || '', 1, 0);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1136, '割接程序及配置文件部署检查', 1114, 1114, 30, 1117, null, 2, 0);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1137, '割接环境变量检查', 1114, 1114, 30, 1117, null, 3, 0);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1138, '数据入库脚本检查', 1114, 1114, 30, 1117, null, 4, 0);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1139, '产品配置数据检查', 1114, 1114, 30, 1117, null, 5, 0);
commit;
prompt 19 records loaded
prompt Loading CUT_USER...
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1102, 'xiejitong', '谢轶彤', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1103, 'binyunxing', '宾云兴', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1104, 'wangfeng', '王锋', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1105, 'wenruyan', '温如燕', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1106, 'lijiongli', '李炯立', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1107, 'yangguirong', '杨桂荣', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1108, 'tanghui', '唐辉', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1109, 'wujiancheng', '吴建成', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1110, 'wuchangguang', '吴常光', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1111, 'sunguohui', '孙国辉', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1, 'admin', 'admin', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1100, 'zhangzhiyuan', '张志远', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1101, 'wujinhui', '吴锦辉', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1112, 'chenweizhao', '陈威兆', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1113, 'zhanglei', '张磊', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1114, 'chenjianhong', '陈剑洪', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1115, 'lilimei', '李丽梅', '91f9c8dfd08626d6dc23b137109b9da4', null);
commit;
prompt 17 records loaded
prompt Loading CUT_USER_ROLE...
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1, 1);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1100, 2);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1100, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1101, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1101, 11);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1102, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1102, 12);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1103, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1103, 11);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1104, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1104, 12);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1105, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1105, 21);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1106, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1106, 22);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1107, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1107, 21);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1108, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1109, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1109, 22);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1110, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1110, 21);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1110, 22);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1111, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1111, 11);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1111, 12);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1112, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1112, 21);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1112, 22);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1113, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1113, 11);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1113, 12);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1114, 2);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1114, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1114, 21);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1114, 22);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1115, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1115, 21);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1115, 22);
commit;
prompt 39 records loaded
prompt Enabling triggers for CUT_BASE_INFO...
alter table CUT_BASE_INFO enable all triggers;
prompt Enabling triggers for CUT_MENU...
alter table CUT_MENU enable all triggers;
prompt Enabling triggers for CUT_ROLE...
alter table CUT_ROLE enable all triggers;
prompt Enabling triggers for CUT_ROLE_MENU...
alter table CUT_ROLE_MENU enable all triggers;
prompt Enabling triggers for CUT_STEP...
alter table CUT_STEP enable all triggers;
prompt Enabling triggers for CUT_STEP_USER...
alter table CUT_STEP_USER enable all triggers;
prompt Enabling triggers for CUT_TASK...
alter table CUT_TASK enable all triggers;
prompt Enabling triggers for CUT_USER...
alter table CUT_USER enable all triggers;
prompt Enabling triggers for CUT_USER_ROLE...
alter table CUT_USER_ROLE enable all triggers;
set feedback on
set define on
prompt Done.
