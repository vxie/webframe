delete from CUT_BASE_INFO;
delete from CUT_MENU;
delete from CUT_ROLE;


insert into CUT_BASE_INFO (CUT_INFO_ID, CUT_TITLE, CUT_BEGIN_TIME, CUT_MANAGER_ID)
values (1, 'NGBOSS全省推广珠海项目割接', '2012-09-21 18:00:00', 212);
commit;

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
commit;

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
commit;

