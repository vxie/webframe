prompt PL/SQL Developer import file
prompt Created on 2012��12��28�� by Administrator
set feedback off
set define off
prompt Dropping CUT_USER...
drop table CUT_USER cascade constraints;
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

prompt Disabling triggers for CUT_USER...
alter table CUT_USER disable all triggers;
prompt Loading CUT_USER...
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (101, 'ouyangyong', 'ŷ����', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (102, 'zenganyue', '������', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (103, 'liuxiangquan', '����ȫ', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (104, 'hongyu', '����', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (105, 'guodonghui', '������', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (106, 'liuzihui', '���ӻ�', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (107, 'yangdongcang', '���', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (108, 'lifeng', '���', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (109, 'laihuasheng', '������', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (110, 'luoanting', '�ް�ͥ', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (111, 'wuziming', '������', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (112, 'wangtao', '����', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (113, 'zhengbin', '֣��', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (114, 'zhangyasheng', '������', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (201, 'lizhen', '����', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (202, 'pangweihan', '��ά��', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (203, 'tanghui', '�ƻ�', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (204, 'fengyun', '����', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (205, 'zhangwei', '����', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (206, 'lidaqun', '���Ⱥ', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (207, 'zhangbinghua', '�ű���', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (208, 'qiaozhiyong', '��־��', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (209, 'zhujianxiang', '�콨��', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (210, 'lizhangqi', '�����', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (211, 'chenzhiheng', '��־��', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (212, 'wuyongbo', '���²�', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (213, 'lijialin', '�����', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (214, 'liaofeng', '�η�', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (215, 'wangxirui', '��ϲ��', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (216, 'qiuning', '����', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (217, 'binyunxing', '������', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1108, 'guest', 'guest', '91f9c8dfd08626d6dc23b137109b9da4', null);
insert into CUT_USER (USER_ID, USER_LOGIN_NAME, USER_REAL_NAME, USER_PASSWORD, USER_MEMO)
values (1, 'admin', 'admin', 'da93da52db01b5cf83ff6e67e140f768', null);
commit;
prompt 33 records loaded
prompt Enabling triggers for CUT_USER...
alter table CUT_USER enable all triggers;
set feedback on
set define on
prompt Done.
