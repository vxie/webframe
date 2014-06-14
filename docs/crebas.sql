/*==============================================================*/
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     2011-03-18 17:20:01                          */
/*==============================================================*/


drop table CUT_BASE_INFO cascade constraints;

drop table CUT_MENU cascade constraints;

drop table CUT_ROLE cascade constraints;

drop table CUT_ROLE_MENU cascade constraints;

drop table CUT_STEP cascade constraints;

drop table CUT_TASK cascade constraints;

drop index IDX_USER_LOGIN_NAME;

drop table CUT_USER cascade constraints;

drop table CUT_USER_ROLE cascade constraints;

/*==============================================================*/
/* Table: CUT_BASE_INFO                                         */
/*==============================================================*/
create table CUT_BASE_INFO  (
   CUT_INFO_ID          NUMBER(12)                      not null,
   CUT_TITLE            varchar2(100),
   CUT_BEGIN_TIME       varchar2(20),
   CUT_TOTAL_TIME       NUMBER(4),
   CUT_STATUS           NUMBER(1),
   CUT_CUR_PERCENT      NUMBER(3),
   CUT_MANAGER_ID       NUMBER(12),
   constraint PK_CUT_BASE_INFO primary key (CUT_INFO_ID)
);

comment on column CUT_BASE_INFO.CUT_INFO_ID is
'ID';

comment on column CUT_BASE_INFO.CUT_TITLE is
'割接标题';

comment on column CUT_BASE_INFO.CUT_BEGIN_TIME is
'割接开始时间';

comment on column CUT_BASE_INFO.CUT_TOTAL_TIME is
'割接总时长（分钟）';

comment on column CUT_BASE_INFO.CUT_STATUS is
'割接状态';

comment on column CUT_BASE_INFO.CUT_CUR_PERCENT is
'割接当前百分比';

comment on column CUT_BASE_INFO.CUT_MANAGER_ID is
'割接负责人';

/*==============================================================*/
/* Table: CUT_MENU                                              */
/*==============================================================*/
create table CUT_MENU  (
   MENU_ID              NUMBER(12)                      not null,
   MENU_NAME            varchar2(100)                   not null,
   MENU_URL             varchar2(100),
   MENU_PARENT_ID       NUMBER(12),
   constraint PK_CUT_MENU primary key (MENU_ID)
);

/*==============================================================*/
/* Table: CUT_ROLE                                              */
/*==============================================================*/
create table CUT_ROLE  (
   ROLE_ID              NUMBER(12)                      not null,
   ROLE_NAME            varchar2(100)                   not null,
   ROLE_MEMO            varchar2(100),
   constraint PK_CUT_ROLE primary key (ROLE_ID)
);

/*==============================================================*/
/* Table: CUT_ROLE_MENU                                         */
/*==============================================================*/
create table CUT_ROLE_MENU  (
   ROLE_ID              NUMBER(12)                      not null,
   MENU_ID              NUMBER(12)                      not null,
   constraint PK_CUT_ROLE_MENU primary key (MENU_ID, ROLE_ID)
);

/*==============================================================*/
/* Table: CUT_STEP                                              */
/*==============================================================*/
create table CUT_STEP  (
   STEP_ID              NUMBER(12)                      not null,
   STEP_NAME            VARCHAR2(200)                   not null,
   STEP_WEIGHT_VALUE    NUMBER(2)                       not null,
   STEP_CUR_PERCENT     NUMBER(3),
   STEP_TIMES           NUMBER(4),
   STEP_OWNER_ID        NUMBER(12),
   STEP_CHECKER_ID      NUMBER(12),
   constraint PK_CUT_STEP primary key (STEP_ID)
);

comment on column CUT_STEP.STEP_ID is
'步骤ID';

comment on column CUT_STEP.STEP_NAME is
'步骤名称';

comment on column CUT_STEP.STEP_WEIGHT_VALUE is
'步骤权重(占整个割接进度的)';

comment on column CUT_STEP.STEP_CUR_PERCENT is
'步骤当前百分比';

comment on column CUT_STEP.STEP_TIMES is
'步骤时长（分钟）';

comment on column CUT_STEP.STEP_OWNER_ID is
'步骤负责人ID';

comment on column CUT_STEP.STEP_CHECKER_ID is
'步骤检查人ID';

/*==============================================================*/
/* Table: CUT_TASK                                              */
/*==============================================================*/
create table CUT_TASK  (
   TASK_ID              NUMBER(12)                      not null,
   TASK_NAME            VARCHAR2(100)                   not null,
   TASK_OPERATER_ID     NUMBER(12)                      not null,
   TASK_CHECKER_ID      NUMBER(12),
   TASK_WEIGHT_VALUE    NUMBER(2),
   TASK_CUR_PERCENT     NUMBER(3),
   TASK_TIMES           NUMBER(4),
   STEP_ID              NUMBER(12)                      not null,
   TASK_SHELL_COMMAND   VARCHAR2(200),
   constraint PK_CUT_TASK primary key (TASK_ID)
);

comment on column CUT_TASK.TASK_ID is
'子任务ID';

comment on column CUT_TASK.TASK_NAME is
'子任务名称';

comment on column CUT_TASK.TASK_OPERATER_ID is
'操作人ID';

comment on column CUT_TASK.TASK_CHECKER_ID is
'检查人ID';

comment on column CUT_TASK.TASK_WEIGHT_VALUE is
'子任务权重';

comment on column CUT_TASK.TASK_CUR_PERCENT is
'子任务完成百分比';

comment on column CUT_TASK.TASK_TIMES is
'子任务计划时长（分钟）';

comment on column CUT_TASK.STEP_ID is
'步骤ID';

comment on column CUT_TASK.TASK_SHELL_COMMAND is
'子任务可执行Shell命令';

/*==============================================================*/
/* Table: CUT_USER                                              */
/*==============================================================*/
create table CUT_USER  (
   USER_ID              NUMBER(12)                      not null,
   USER_LOGIN_NAME      varchar2(50)                    not null,
   USER_REAL_NAME       varchar2(50)                    not null,
   USER_PASSWORD        varchar2(50),
   USER_MEMO            varchar2(100),
   constraint PK_CUT_USER primary key (USER_ID)
);

/*==============================================================*/
/* Index: IDX_USER_LOGIN_NAME                                   */
/*==============================================================*/
create unique index IDX_USER_LOGIN_NAME on CUT_USER (
   USER_LOGIN_NAME ASC
);

/*==============================================================*/
/* Table: CUT_USER_ROLE                                         */
/*==============================================================*/
create table CUT_USER_ROLE  (
   USER_ID              NUMBER(12)                      not null,
   ROLE_ID              NUMBER(12)                      not null,
   constraint PK_CUT_USER_ROLE primary key (USER_ID, ROLE_ID)
);

