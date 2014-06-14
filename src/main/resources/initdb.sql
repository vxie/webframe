create table CUT_BASE_INFO
(
  CUT_INFO_ID    NUMBER(12) not null,
  CUT_TITLE      VARCHAR2(100),
  CUT_BEGIN_TIME VARCHAR2(20),
  CUT_MANAGER_ID NUMBER(12),
  CUT_DURATION   VARCHAR2(50)
);
alter table CUT_BASE_INFO
  add constraint PK_CUT_BASE_INFO primary key (CUT_INFO_ID)using index;

create table CUT_MENU
(
  MENU_ID        NUMBER(12) not null,
  MENU_NAME      VARCHAR2(100) not null,
  MENU_URL       VARCHAR2(100),
  MENU_PARENT_ID NUMBER(12),
  MENU_INDEX     NUMBER(2),
  MENU_GRADE     NUMBER(2)
);
alter table CUT_MENU
  add constraint PK_CUT_MENU primary key (MENU_ID)using index;

create table CUT_ROLE
(
  ROLE_ID   NUMBER(12) not null,
  ROLE_NAME VARCHAR2(100) not null,
  ROLE_MEMO VARCHAR2(100)
);
alter table CUT_ROLE
  add constraint PK_CUT_ROLE primary key (ROLE_ID)using index;


create table CUT_ROLE_MENU
(
  ROLE_ID NUMBER(12) not null,
  MENU_ID NUMBER(12) not null
);
alter table CUT_ROLE_MENU
  add constraint PK_CUT_ROLE_MENU primary key (MENU_ID, ROLE_ID)using index;

create table CUT_STEP
(
  STEP_ID           NUMBER(12) not null,
  STEP_NAME         VARCHAR2(100) not null,
  STEP_WEIGHT_VALUE NUMBER(2) not null,
  STEP_CUR_PERCENT  NUMBER(3),
  STEP_TIMES        NUMBER(9),
  STEP_OWNER_ID     NUMBER(12),
  STEP_CHECKER_ID   NUMBER(12),
  STEP_INDEX        NUMBER(2),
  STEP_STATUS       NUMBER(1),
  START_TIME        VARCHAR2(20),
  FINISH_TIME       VARCHAR2(20)
);

alter table CUT_STEP
  add constraint PK_CUT_STEP primary key (STEP_ID)
  using index;
  
create table CUT_STEP_USER
(
  STEP_ID NUMBER(12) not null,
  USER_ID NUMBER(12) not null
);
alter table CUT_STEP_USER
  add constraint PK_CUT_STEP_USER primary key (STEP_ID, USER_ID)
  using index;

create table CUT_TASK
(
  TASK_ID            NUMBER(12) not null,
  TASK_NAME          VARCHAR2(200) not null,
  TASK_OPERATER_ID   NUMBER(12) not null,
  TASK_CHECKER_ID    NUMBER(12),
  TASK_TIMES         NUMBER(9),
  STEP_ID            NUMBER(12) not null,
  TASK_SHELL_COMMAND VARCHAR2(3000),
  TASK_INDEX         NUMBER(3),
  TASK_STATUS        NUMBER(1),
  START_TIME         VARCHAR2(20),
  FINISH_TIME        VARCHAR2(20)
);

alter table CUT_TASK
  add constraint PK_CUT_TASK primary key (TASK_ID)
  using index;

create table CUT_USER
(
  USER_ID         NUMBER(12) not null,
  USER_LOGIN_NAME VARCHAR2(50) not null,
  USER_REAL_NAME  VARCHAR2(50) not null,
  USER_PASSWORD   VARCHAR2(50),
  USER_MEMO       VARCHAR2(100)
);
alter table CUT_USER
  add constraint PK_CUT_USER primary key (USER_ID)
  using index;
create unique index IDX_USER_LOGIN_NAME on CUT_USER (USER_LOGIN_NAME);

create table CUT_USER_ROLE
(
  USER_ID NUMBER(12) not null,
  ROLE_ID NUMBER(12) not null
);
alter table CUT_USER_ROLE
  add constraint PK_CUT_USER_ROLE primary key (USER_ID, ROLE_ID)
  using index;

insert into CUT_BASE_INFO (CUT_INFO_ID, CUT_TITLE, CUT_BEGIN_TIME, CUT_MANAGER_ID)
values (1, 'NGBOSS全省推广珠海项目割接', '2012-09-21 18:00:00', 212);


insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (1, '总体进度', '/progress/list', null, 1, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (2, '步骤执行', '/progress/steps/exec', null, 2, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (3, '任务执行', '/progress/tasks/exec', null, 3, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (100, '割接配置', null, null, 2, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (110, '基本信息', '/baseinfo/set', 100, 1, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (120, '步骤配置', '/step/set', 100, 2, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (130, '任务配置', '/task/set', 100, 3, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (200, '系统管理', null, null, 3, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (210, '用户管理', '/user/list', 200, 1, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (220, '角色管理', '/role/list', 200, 2, null);


insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (1, '系统管理员', '可以执行全部功能');
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (2, '割接总协调人', '可以对用户进行管理，可以配置割接基本信息；可浏览总体割接进度；');
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (3, '来宾', '仅可以浏览总体割接进度');
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (11, '步骤负责人', '可以对步骤、任务做配置和执行；可浏览总体割接进度；');
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (12, '步骤检查人', '仅可以对步骤完成情况做检查；可浏览总体割接进度；');
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (21, '子任务负责人', '可以对任务做配置和执行操作；可浏览总体割接进度；');
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (22, '子任务检查人', '仅可以对任务执行情况做检查；可浏览总体割接进度；');


insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (3, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (11, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (12, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (21, 1);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (22, 1);
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

insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1, 'admin', 'admin', '91f9c8dfd08626d6dc23b137109b9da4', null);


insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1, 1);
commit;