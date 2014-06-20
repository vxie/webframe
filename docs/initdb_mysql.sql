create table CUT_BASE_INFO  (
   CUT_INFO_ID          int not null primary key,
   CUT_TITLE            varchar(100),
   CUT_BEGIN_TIME       varchar(20),
   CUT_TOTAL_TIME       int,
   CUT_STATUS           int,
   CUT_CUR_PERCENT      int,
   CUT_MANAGER_ID       int,
   CUT_DURATION         VARCHAR(50)
);


create table CUT_MENU
(
  MENU_ID        int not null primary key,
  MENU_NAME      VARCHAR(100) not null,
  MENU_URL       VARCHAR(100),
  MENU_PARENT_ID int,
  MENU_INDEX     int,
  MENU_GRADE     int
);


create table CUT_ROLE
(
  ROLE_ID   int not null primary key,
  ROLE_NAME VARCHAR(100) not null,
  ROLE_MEMO VARCHAR(100)
);


create table CUT_ROLE_MENU
(
  ROLE_ID int not null,
  MENU_ID int not null,
  primary key(ROLE_ID,MENU_ID)
);


create table CUT_STEP
(
  STEP_ID           int not null primary key,
  STEP_NAME         VARCHAR(100) not null,
  STEP_WEIGHT_VALUE int not null,
  STEP_CUR_PERCENT  int,
  STEP_TIMES        int,
  STEP_OWNER_ID     int,
  STEP_CHECKER_ID   int,
  STEP_INDEX        int,
  STEP_STATUS       int,
  START_TIME        VARCHAR(20),
  FINISH_TIME       VARCHAR(20)
);


create table CUT_STEP_USER
(
  STEP_ID int not null,
  USER_ID int not null,
  primary key(STEP_ID,USER_ID)
);


create table CUT_TASK
(
  TASK_ID            int not null  primary key,
  TASK_NAME          VARCHAR(200) not null,
  TASK_OPERATER_ID   int not null,
  TASK_CHECKER_ID    int,
  TASK_TIMES         int,
  STEP_ID            int not null,
  TASK_SHELL_COMMAND VARCHAR(2000),
  TASK_INDEX         int,
  TASK_STATUS        int,
  START_TIME         VARCHAR(20),
  FINISH_TIME        VARCHAR(20)
);


create table CUT_USER
(
  USER_ID         int not null primary key,
  USER_LOGIN_NAME VARCHAR(50) not null,
  USER_REAL_NAME  VARCHAR(50) not null,
  USER_PASSWORD   VARCHAR(50),
  USER_MEMO       VARCHAR(100)
);

create table CUT_USER_ROLE
(
  USER_ID int not null,
  ROLE_ID int not null,
  primary key(USER_ID,ROLE_ID)
);


commit;

