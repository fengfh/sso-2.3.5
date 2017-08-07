drop table if exists SSO_APP_SPECIFIED_SECRET;

drop table if exists SSO_CLIENT_HOST;

drop table if exists SSO_TICKET;

/*==============================================================*/
/* Table: SSO_APP_SPECIFIED_SECRET                              */
/*==============================================================*/
create table SSO_APP_SPECIFIED_SECRET
(
   ID                   varchar(128) not null comment '主键',
   NAME                 varchar(128) comment '名称',
   SECRET               varchar(1024) comment '应用专用密码',
   USER_ID              varchar(128) comment '用户ID',
   CLIENT_ID            varchar(128) comment '客户端应用ID',
   CREATE_TIME          datetime comment '创建时间',
   LAST_USED_TIME       datetime comment '最后使用时间',
   EXPIRES              varchar(128) comment '过期时间',
   SECRET_UNIQUE        int comment '应用专用密码是否唯一',
   primary key (ID)
);

alter table SSO_APP_SPECIFIED_SECRET comment '应用专用密码';

/*==============================================================*/
/* Table: SSO_CLIENT_HOST                                       */
/*==============================================================*/
create table SSO_CLIENT_HOST
(
   ID                   varchar(128) not null,
   CODE                 varchar(128),
   NAME                 varchar(128),
   MEMO                 varchar(4000),
   SECRET               varchar(128),
   IP                   varchar(128),
   HOME                 varchar(4000),
   LOGOUT_URL           varchar(4000),
   CLIENT_HOST_TYPE     varchar(128),
   PRIVATE_KEY          varchar(4000),
   PUBLIC_KEY           varchar(4000),
   primary key (ID)
);

alter table SSO_CLIENT_HOST comment 'SSO客户端';

/*==============================================================*/
/* Table: SSO_TICKET                                            */
/*==============================================================*/
create table SSO_TICKET
(
   ID                   varchar(128) not null,
   TICKET_ID            varchar(128),
   TICKET               longblob,
   TICKET_TYPE          varchar(128),
   CREATE_TIME          datetime,
   HOST_NAME            varchar(4000),
   primary key (ID)
);

/*==============================================================*/
/* Index: IDX_SSO_TICKET_TICKET_ID                              */
/*==============================================================*/
create unique index IDX_SSO_TICKET_TICKET_ID on SSO_TICKET
(
   TICKET_ID
);

/*==============================================================*/
/* Table: SSO_LOGIN_LOG                                         */
/*==============================================================*/
create table SSO_LOGIN_LOG
(
   ID                   varchar(128) not null,
   TICKET_ID            varchar(128),
   LOGIN_TIME           datetime,
   PRINCIPAL_ID         varchar(128),
   AUTH_TYPE            varchar(256),
   IS_DESKTOP_LOGIN     int,
   RETURN_URL           varchar(4000),
   CLIENT_ID            varchar(128),
   HOST_NAME            varchar(4000),
   USER_AGENT_ADDR      varchar(128),
   primary key (ID)
);

/*==============================================================*/
/* Table: SSO_LOGOUT_LOG                                        */
/*==============================================================*/
create table SSO_LOGOUT_LOG
(
   ID                   varchar(128) not null,
   TICKET_ID            varchar(128),
   LOGOUT_TIME          datetime,
   RETURN_URL           varchar(4000),
   HOST_NAME            varchar(256),
   USER_AGENT_ADDR      varchar(128),
   primary key (ID)
);

CREATE TABLE SSO_OPENID_ASSOCIATION
(
   assoc_handle     VARCHAR(128) NOT NULL,
   assoc_type       VARCHAR(128),
   mackey           VARCHAR(4000),
   expdate          DATETIME,
   PRIMARY KEY (assoc_handle)
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
  LAST_UPDATED DATETIME,
  PRIMARY KEY (USER_ID)
) ;


CREATE TABLE sso_ticket_ex(
  ticket_id VARCHAR(36) NOT NULL,
  item_name VARCHAR(20) NOT NULL,
  item_value VARCHAR(250) NOT NULL,
  create_time DATETIME,
  PRIMARY KEY (ticket_id, item_name, item_value)
);

/**
 * 增加二维码登录支持
 */
CREATE TABLE `sso_qrcode_token` (
  `id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `login_ticket` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `nonce` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `confirm_url` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expired_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

/**
 * 2015-08-18
 * 增加用户锁定放到数据库
 */
CREATE TABLE sso_badauth_counter(
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `identity` VARCHAR(36) NOT NULL,
  `credentials_type` VARCHAR(30) NOT NULL,
  `count` INT NOT NULL DEFAULT 0,
  `locked_time` DATETIME DEFAULT NULL ,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UX_BADCOUNTER_ID_TYPE` (`identity`, `credentials_type`)
);
