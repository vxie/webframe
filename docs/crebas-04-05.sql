prompt PL/SQL Developer import file
prompt Created on 2011年4月6日 by maxim
set feedback off
set define off
prompt Creating CUT_BASE_INFO...
create table CUT_BASE_INFO
(
  CUT_INFO_ID     NUMBER(12) not null,
  CUT_TITLE       VARCHAR2(100),
  CUT_BEGIN_TIME  VARCHAR2(20),
  CUT_TOTAL_TIME  NUMBER(4),
  CUT_STATUS      NUMBER(1),
  CUT_CUR_PERCENT NUMBER(3),
  CUT_MANAGER_ID  NUMBER(12)
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
comment on column CUT_BASE_INFO.CUT_TOTAL_TIME
  is '割接总时长（分钟）';
comment on column CUT_BASE_INFO.CUT_STATUS
  is '割接状态';
comment on column CUT_BASE_INFO.CUT_CUR_PERCENT
  is '割接当前百分比';
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

prompt Creating CUT_TASK...
create table CUT_TASK
(
  TASK_ID            NUMBER(12) not null,
  TASK_NAME          VARCHAR2(100) not null,
  TASK_OPERATER_ID   NUMBER(12) not null,
  TASK_CHECKER_ID    NUMBER(12),
  TASK_WEIGHT_VALUE  NUMBER(2),
  TASK_CUR_PERCENT   NUMBER(3),
  TASK_TIMES         NUMBER(4),
  STEP_ID            NUMBER(12) not null,
  TASK_SHELL_COMMAND VARCHAR2(200),
  TASK_INDEX         NUMBER(2),
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
comment on column CUT_TASK.TASK_WEIGHT_VALUE
  is '子任务权重';
comment on column CUT_TASK.TASK_CUR_PERCENT
  is '子任务完成百分比';
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
insert into CUT_BASE_INFO (CUT_INFO_ID, CUT_TITLE, CUT_BEGIN_TIME, CUT_TOTAL_TIME, CUT_STATUS, CUT_CUR_PERCENT, CUT_MANAGER_ID)
values (1, '珠海融合计费割接进度', '2011-5-30 00:00:00', 234, 1, 60, 1);
commit;
prompt 1 records loaded
prompt Loading CUT_MENU...
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (1, '总体进度', '/step/total', null, 1);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (2, '步骤进度', '/abc', null, 2);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (3, '任务信息', '/abc', null, 3);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (100, '割接配置', null, null, 2);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (110, '基本信息', '/baseinfo/list', 100, 1);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (120, '步骤配置', '/step/list', 100, 2);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX)
values (130, '任务配置', '/abc', 100, 3);
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
prompt 5 records loaded
prompt Loading CUT_ROLE_MENU...
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (3, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (4, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 2);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 2);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (3, 2);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 3);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (4, 3);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 100);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 100);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (4, 100);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 110);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 120);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 120);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 130);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 130);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (4, 130);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 200);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 210);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 220);
commit;
prompt 21 records loaded
prompt Loading CUT_STEP...
insert into CUT_STEP (STEP_ID, STEP_NAME, STEP_WEIGHT_VALUE, STEP_CUR_PERCENT, STEP_TIMES, STEP_OWNER_ID, STEP_CHECKER_ID, STEP_INDEX, STEP_STATUS)
values (1, '应用部署检查', 12, 0, 123, 1, 2, 1, null);
insert into CUT_STEP (STEP_ID, STEP_NAME, STEP_WEIGHT_VALUE, STEP_CUR_PERCENT, STEP_TIMES, STEP_OWNER_ID, STEP_CHECKER_ID, STEP_INDEX, STEP_STATUS)
values (2, '步骤123', 20, 0, 321, 2, 3, 2, null);
commit;
prompt 2 records loaded
prompt Loading CUT_TASK...
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_WEIGHT_VALUE, TASK_CUR_PERCENT, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (1, 'WebSphere配置准备', 1, 1, 1, 1, 1, 1, null, 1, null);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_WEIGHT_VALUE, TASK_CUR_PERCENT, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (2, 'HTTP Server配置准备', 1, 1, 1, 1, 1, 1, null, 2, null);
insert into CUT_TASK (TASK_ID, TASK_NAME, TASK_OPERATER_ID, TASK_CHECKER_ID, TASK_WEIGHT_VALUE, TASK_CUR_PERCENT, TASK_TIMES, STEP_ID, TASK_SHELL_COMMAND, TASK_INDEX, TASK_STATUS)
values (3, '营业后台应用检查', 1, 1, 1, 1, 1, 1, null, 3, null);
commit;
prompt 3 records loaded
prompt Loading CUT_USER...
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1, 'admin', 'admin', '91f9c8dfd08626d6dc23b137109b9da4', 'admin@abc.com');
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (2, 'abc', 'abc', '91f9c8dfd08626d6dc23b137109b9da4', 'abc@abc.com');
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (3, 'aaaa', 'aaa', '91f9c8dfd08626d6dc23b137109b9da4', 'aaa@abc.com');
commit;
prompt 3 records loaded
prompt Loading CUT_USER_ROLE...
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1, 1);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (2, 2);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (2, 4);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (3, 3);
insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (3, 5);
commit;
prompt 5 records loaded
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
prompt Enabling triggers for CUT_TASK...
alter table CUT_TASK enable all triggers;
prompt Enabling triggers for CUT_USER...
alter table CUT_USER enable all triggers;
prompt Enabling triggers for CUT_USER_ROLE...
alter table CUT_USER_ROLE enable all triggers;
set feedback on
set define on
prompt Done.
