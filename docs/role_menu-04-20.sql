prompt PL/SQL Developer import file
prompt Created on 2011年4月20日 by maxim
set feedback off
set define off
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

prompt Disabling triggers for CUT_ROLE_MENU...
alter table CUT_ROLE_MENU disable all triggers;
prompt Deleting CUT_ROLE_MENU...
delete from CUT_ROLE_MENU;
commit;
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
values (2, 2);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (11, 2);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (12, 2);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 3);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 3);
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
values (2, 120);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (11, 120);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (1, 130);
insert into CUT_ROLE_MENU (ROLE_ID, MENU_ID)
values (2, 130);
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
prompt 29 records loaded
prompt Enabling triggers for CUT_ROLE_MENU...
alter table CUT_ROLE_MENU enable all triggers;
set feedback on
set define on
prompt Done.
