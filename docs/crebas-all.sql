create table CUT_BASE_INFO
(
  CUT_INFO_ID    NUMBER(12) not null,
  CUT_TITLE      VARCHAR2(100),
  CUT_BEGIN_TIME VARCHAR2(20),
  CUT_MANAGER_ID NUMBER(12)
)
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table CUT_BASE_INFO
  add constraint PK_CUT_BASE_INFO primary key (CUT_INFO_ID)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

create table CUT_MENU
(
  MENU_ID        NUMBER(12) not null,
  MENU_NAME      VARCHAR2(100) not null,
  MENU_URL       VARCHAR2(100),
  MENU_PARENT_ID NUMBER(12),
  MENU_INDEX     NUMBER(2),
  MENU_GRADE     NUMBER(2)
)
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
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

create table CUT_ROLE
(
  ROLE_ID   NUMBER(12) not null,
  ROLE_NAME VARCHAR2(100) not null,
  ROLE_MEMO VARCHAR2(100)
)
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
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

create table CUT_ROLE_MENU
(
  ROLE_ID NUMBER(12) not null,
  MENU_ID NUMBER(12) not null
)
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
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

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
)
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

alter table CUT_STEP
  add constraint PK_CUT_STEP primary key (STEP_ID)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

create table CUT_STEP_USER
(
  STEP_ID NUMBER(12) not null,
  USER_ID NUMBER(12) not null
)
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
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

create table CUT_TASK
(
  TASK_ID            NUMBER(12) not null,
  TASK_NAME          VARCHAR2(200) not null,
  TASK_OPERATER_ID   NUMBER(12) not null,
  TASK_CHECKER_ID    NUMBER(12),
  TASK_TIMES         NUMBER(4),
  STEP_ID            NUMBER(12) not null,
  TASK_SHELL_COMMAND VARCHAR2(3000),
  TASK_INDEX         NUMBER(3),
  TASK_STATUS        NUMBER(1),
  START_TIME         VARCHAR2(20),
  FINISH_TIME        VARCHAR2(20)
)
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

alter table CUT_TASK
  add constraint PK_CUT_TASK primary key (TASK_ID)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

create table CUT_USER
(
  USER_ID         NUMBER(12) not null,
  USER_LOGIN_NAME VARCHAR2(50) not null,
  USER_REAL_NAME  VARCHAR2(50) not null,
  USER_PASSWORD   VARCHAR2(50),
  USER_MEMO       VARCHAR2(100)
)
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
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

create table CUT_USER_ROLE
(
  USER_ID NUMBER(12) not null,
  ROLE_ID NUMBER(12) not null
)
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
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

insert into CUT_BASE_INFO (CUT_INFO_ID, CUT_TITLE, CUT_BEGIN_TIME, CUT_MANAGER_ID)
values (1, 'NGBOSSȫʡ�ƹ��麣��Ŀ���', '2012-09-21 18:00:00', 212);
commit;

insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (1, '�������', '/progress/list', null, 1, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (2, '����ִ��', '/progress/steps/exec', null, 2, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (3, '����ִ��', '/progress/tasks/exec', null, 3, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (100, '�������', null, null, 2, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (110, '������Ϣ', '/baseinfo/set', 100, 1, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (120, '��������', '/step/set', 100, 2, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (130, '��������', '/task/set', 100, 3, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (200, 'ϵͳ����', null, null, 3, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (210, '�û�����', '/user/list', 200, 1, null);
insert into CUT_MENU (MENU_ID, MENU_NAME, MENU_URL, MENU_PARENT_ID, MENU_INDEX, MENU_GRADE)
values (220, '��ɫ����', '/role/list', 200, 2, null);
commit;

insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (1, 'ϵͳ����Ա', '����ִ��ȫ������');
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (2, '�����Э����', '���Զ��û����й����������ø�ӻ�����Ϣ������������ӽ��ȣ�');
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (3, '����', '��������������ӽ���');
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (11, '���踺����', '���ԶԲ��衢���������ú�ִ�У�����������ӽ��ȣ�');
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (12, '��������', '�����ԶԲ�������������飻����������ӽ��ȣ�');
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (21, '����������', '���Զ����������ú�ִ�в���������������ӽ��ȣ�');
insert into CUT_ROLE (ROLE_ID, ROLE_NAME, ROLE_MEMO)
values (22, '����������', '�����Զ�����ִ���������飻����������ӽ��ȣ�');
commit;


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
commit;



insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1, 'admin', 'admin', '91f9c8dfd08626d6dc23b137109b9da4', null);
commit;

insert into CUT_USER_ROLE (USER_ID, ROLE_ID)
values (1, 1);
commit;

/*
create sequence SEQ_CUT_SHOW
minvalue 1000
maxvalue 9999999999
start with 1001
increment by 1
cache 20;
commit;
*/