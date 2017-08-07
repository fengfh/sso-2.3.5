if exists (select 1
            from  sysobjects
           where  id = object_id('SSO_APP_SPECIFIED_SECRET')
            and   type = 'U')
   drop table SSO_APP_SPECIFIED_SECRET
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SSO_CLIENT_HOST')
            and   type = 'U')
   drop table SSO_CLIENT_HOST
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SSO_TICKET')
            and   type = 'U')
   drop table SSO_TICKET
go

/*==============================================================*/
/* Table: SSO_APP_SPECIFIED_SECRET                              */
/*==============================================================*/
create table SSO_APP_SPECIFIED_SECRET (
   ID                   varchar(128)         not null,
   NAME                 varchar(128)         null,
   SECRET               varchar(1024)         null,
   USER_ID              varchar(128)         null,
   CLIENT_ID            varchar(128)         null,
   CREATE_TIME          datetime             null,
   LAST_USED_TIME       datetime             null,
   EXPIRES              varchar(128)         null,
   SECRET_UNIQUE        int                  null,
   constraint PK_SSO_APP_SPECIFIED_SECRET primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description',
   '应用专用密码',
   'user', @CurrentUser, 'table', 'SSO_APP_SPECIFIED_SECRET'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description',
   '主键',
   'user', @CurrentUser, 'table', 'SSO_APP_SPECIFIED_SECRET', 'column', 'ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description',
   '名称',
   'user', @CurrentUser, 'table', 'SSO_APP_SPECIFIED_SECRET', 'column', 'NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description',
   '应用专用密码',
   'user', @CurrentUser, 'table', 'SSO_APP_SPECIFIED_SECRET', 'column', 'SECRET'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description',
   '用户ID',
   'user', @CurrentUser, 'table', 'SSO_APP_SPECIFIED_SECRET', 'column', 'USER_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description',
   '客户端应用ID',
   'user', @CurrentUser, 'table', 'SSO_APP_SPECIFIED_SECRET', 'column', 'CLIENT_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description',
   '创建时间',
   'user', @CurrentUser, 'table', 'SSO_APP_SPECIFIED_SECRET', 'column', 'CREATE_TIME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description',
   '最后使用时间',
   'user', @CurrentUser, 'table', 'SSO_APP_SPECIFIED_SECRET', 'column', 'LAST_USED_TIME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description',
   '过期时间',
   'user', @CurrentUser, 'table', 'SSO_APP_SPECIFIED_SECRET', 'column', 'EXPIRES'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description',
   '应用专用密码是否唯一',
   'user', @CurrentUser, 'table', 'SSO_APP_SPECIFIED_SECRET', 'column', 'SECRET_UNIQUE'
go

/*==============================================================*/
/* Table: SSO_CLIENT_HOST                                       */
/*==============================================================*/
create table SSO_CLIENT_HOST (
   ID                   varchar(128)         not null,
   CODE                 varchar(128)         null,
   NAME                 varchar(128)         null,
   MEMO                 varchar(4000)        null,
   SECRET               varchar(128)         null,
   IP                   varchar(128)         null,
   HOME                 varchar(4000)        null,
   LOGOUT_URL           varchar(4000)        null,
   CLIENT_HOST_TYPE     varchar(128)         null,
   PRIVATE_KEY          varchar(4000)        null,
   PUBLIC_KEY           varchar(4000)        null,
   constraint PK_SSO_CLIENT_HOST primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description',
   'SSO客户端',
   'user', @CurrentUser, 'table', 'SSO_CLIENT_HOST'
go

/*==============================================================*/
/* Table: SSO_TICKET                                            */
/*==============================================================*/
create table SSO_TICKET (
   ID                   varchar(128)         not null,
   TICKET_ID            varchar(128)         null,
   TICKET               varbinary(max)       null,
   TICKET_TYPE          varchar(128)         null,
   CREATE_TIME          datetime             null,
   HOST_NAME            varchar(4000)        null,
   constraint PK_SSO_TICKET primary key nonclustered (ID)
)
go

/*==============================================================*/
/* Index: IDX_SSO_TICKET_TICKET_ID                              */
/*==============================================================*/
create unique index IDX_SSO_TICKET_TICKET_ID on SSO_TICKET (
TICKET_ID ASC
)
go

/*==============================================================*/
/* Table: SSO_LOGIN_LOG                                         */
/*==============================================================*/
create table SSO_LOGIN_LOG (
   ID                   varchar(128)         not null,
   TICKET_ID            varchar(128)         null,
   LOGIN_TIME           DATETIME             null,
   PRINCIPAL_ID         varchar(128)         null,
   AUTH_TYPE            varchar(256)         null,
   IS_DESKTOP_LOGIN     int                  null,
   RETURN_URL           varchar(4000)        null,
   CLIENT_ID            varchar(128)         null,
   HOST_NAME            varchar(4000)        null,
   USER_AGENT_ADDR      varchar(128)         null,
   constraint PK_SSO_LOGIN_LOG primary key nonclustered (ID)
)
go

/*==============================================================*/
/* Table: SSO_LOGOUT_LOG                                        */
/*==============================================================*/
create table SSO_LOGOUT_LOG (
   ID                   varchar(128)         not null,
   TICKET_ID            varchar(128)         null,
   LOGOUT_TIME          DATETIME             null,
   RETURN_URL           varchar(4000)        null,
   HOST_NAME            varchar(256)         null,
   USER_AGENT_ADDR      varchar(128)         null,
   constraint PK_SSO_LOGOUT_LOG primary key nonclustered (ID)
)
go

CREATE TABLE SSO_OPENID_ASSOCIATION
(
   assoc_handle     VARCHAR(128) NOT NULL,
   assoc_type       VARCHAR(128),
   mackey           VARCHAR(4000),
   expdate          DATETIME,
   constraint PK_SSO_OPENID_ASSOCIATION PRIMARY KEY (assoc_handle)
)
go
CREATE INDEX IDX_SSO_OPENID_ASSOCIATION_01 ON SSO_OPENID_ASSOCIATION
(
   expdate
)
go


/*==============================================================*/
/* Table: SSO_REMOTE_APP_TOKEN                                        */
/*==============================================================*/
CREATE TABLE SSO_REMOTE_APP_TOKEN(
  USER_ID VARCHAR(36) NOT NULL,
  TOKEN VARCHAR(150),
  LAST_UPDATED DATETIME,
  PRIMARY KEY (USER_ID)
)
go


CREATE TABLE sso_ticket_ex(
  ticket_id VARCHAR(128) NOT NULL,
  item_name VARCHAR(20) NOT NULL,
  item_value VARCHAR(500) NOT NULL,
  create_time DATETIME,
  PRIMARY KEY (ticket_id, item_name, item_value)
)
go
