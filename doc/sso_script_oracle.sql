
/*==============================================================*/
/* Table: SSO_TICKET                                            */
/*==============================================================*/
create table SSO_TICKET  (
   ID                   VARCHAR2(128)                   not null,
   TICKET_ID            VARCHAR2(128),
   TICKET               BLOB,
   TICKET_TYPE          VARCHAR2(128),
   CREATE_TIME          DATE,
   HOST_NAME            VARCHAR2(4000),
   constraint PK_SSO_TICKET primary key (ID)
);

/*==============================================================*/
/* Index: IDX_SSO_TICKET_TICKET_ID                              */
/*==============================================================*/
create unique index IDX_SSO_TICKET_TICKET_ID on SSO_TICKET (
   TICKET_ID ASC
);

/*==============================================================*/
/* Table: SSO_APP_SPECIFIED_SECRET                              */
/*==============================================================*/
create table SSO_APP_SPECIFIED_SECRET  (
   ID                   VARCHAR2(128)                   not null,
   NAME                 VARCHAR2(128),
   SECRET               VARCHAR2(1024),
   USER_ID              VARCHAR2(128),
   CLIENT_ID            VARCHAR2(128),
   CREATE_TIME          DATE,
   LAST_USED_TIME       DATE,
   EXPIRES              VARCHAR2(128),
   SECRET_UNIQUE        INT,
   constraint PK_SSO_APP_SPECIFIED_SECRET primary key (ID)
);

comment on table SSO_APP_SPECIFIED_SECRET is
'应用专用密码';

comment on column SSO_APP_SPECIFIED_SECRET.ID is
'主键';

comment on column SSO_APP_SPECIFIED_SECRET.NAME is
'名称';

comment on column SSO_APP_SPECIFIED_SECRET.SECRET is
'应用专用密码';

comment on column SSO_APP_SPECIFIED_SECRET.USER_ID is
'用户ID';

comment on column SSO_APP_SPECIFIED_SECRET.CLIENT_ID is
'客户端应用ID';

comment on column SSO_APP_SPECIFIED_SECRET.CREATE_TIME is
'创建时间';

comment on column SSO_APP_SPECIFIED_SECRET.LAST_USED_TIME is
'最后使用时间';

comment on column SSO_APP_SPECIFIED_SECRET.EXPIRES is
'过期时间';

comment on column SSO_APP_SPECIFIED_SECRET.SECRET_UNIQUE is
'应用专用密码是否唯一';

/*==============================================================*/
/* Table: SSO_CLIENT_HOST                                       */
/*==============================================================*/
create table SSO_CLIENT_HOST  (
   ID                   VARCHAR2(128)                   not null,
   CODE                 VARCHAR2(128),
   NAME                 VARCHAR2(128),
   MEMO                 VARCHAR2(4000),
   SECRET               VARCHAR2(128),
   IP                   VARCHAR2(128),
   HOME                 VARCHAR2(4000),
   LOGOUT_URL           VARCHAR2(4000),
   CLIENT_HOST_TYPE     VARCHAR2(128),
   PRIVATE_KEY          VARCHAR2(4000),
   PUBLIC_KEY           VARCHAR2(4000),
   constraint PK_SSO_CLIENT_HOST primary key (ID)
);

comment on table SSO_CLIENT_HOST is
'SSO客户端';

/*==============================================================*/
/* Table: SSO_LOGIN_LOG                                         */
/*==============================================================*/
create table SSO_LOGIN_LOG  (
   ID                   VARCHAR2(128)                   not null,
   TICKET_ID            VARCHAR2(128),
   LOGIN_TIME           DATE,
   PRINCIPAL_ID         VARCHAR2(128),
   AUTH_TYPE            VARCHAR2(256),
   IS_DESKTOP_LOGIN     INT,
   RETURN_URL           VARCHAR2(4000),
   CLIENT_ID            VARCHAR2(128),
   HOST_NAME            VARCHAR2(4000),
   USER_AGENT_ADDR      VARCHAR2(128),
   constraint PK_SSO_LOGIN_LOG primary key (ID)
);

/*==============================================================*/
/* Table: SSO_LOGOUT_LOG                                        */
/*==============================================================*/
create table SSO_LOGOUT_LOG  (
   ID                   VARCHAR2(128)                   not null,
   TICKET_ID            VARCHAR2(128),
   LOGOUT_TIME          DATE,
   RETURN_URL           VARCHAR2(4000),
   HOST_NAME            VARCHAR2(256),
   USER_AGENT_ADDR      VARCHAR2(128),
   constraint PK_SSO_LOGOUT_LOG primary key (ID)
);

CREATE TABLE SSO_OPENID_ASSOCIATION
(
   assoc_handle     VARCHAR2(128) NOT NULL,
   assoc_type       VARCHAR2(128),
   mackey           VARCHAR2(4000),
   expdate          DATE,
   constraint PK_SSO_OPENID_ASSOCIATION PRIMARY KEY (assoc_handle)
);
CREATE INDEX IDX_SSO_OPENID_ASSOCIATION_01 ON SSO_OPENID_ASSOCIATION
(
   expdate
);

/*==============================================================*/
/* Table: SSO_REMOTE_APP_TOKEN                                        */
/*==============================================================*/
CREATE TABLE SSO_REMOTE_APP_TOKEN(
  USER_ID VARCHAR(36) NOT NULL,
  TOKEN VARCHAR(150),
  LAST_UPDATED DATE,
  PRIMARY KEY (USER_ID)
) ;

CREATE TABLE sso_ticket_ex(
  ticket_id VARCHAR(128) NOT NULL,
  item_name VARCHAR(20) NOT NULL,
  item_value VARCHAR(500) NOT NULL,
  create_time DATE,
  PRIMARY KEY (ticket_id, item_name, item_value)
);
