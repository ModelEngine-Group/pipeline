-- 删除旧的模板数据

DELETE FROM "public"."app_builder_app" WHERE id = 'df87073b9bc85a48a9b01eccc9afccc4';
DELETE FROM "public"."app_builder_app" WHERE id = 'df87073b9bc85a48a9b01eccc9afccc3';
DELETE FROM "public"."app_builder_app" WHERE id = '4a1d6b117b7d4c8f8c5b6c3358608c9c';

DELETE FROM "public"."app_builder_config" WHERE id = '45515ca5da9d04428f41086e291b4d5d';
DELETE FROM "public"."app_builder_config" WHERE id = '45515ca5da9d04428f41086e291b4d5e';
DELETE FROM "public"."app_builder_config" WHERE id = 'af1528b4d4de4d9ebbaf2cc2c8703ac2';

DELETE FROM "public"."app_builder_config_property" WHERE id = '836f722491b476478dea2135d7f1d113';
DELETE FROM "public"."app_builder_config_property" WHERE id = '2045fe16f5fe854d884b2f272100d68d';
DELETE FROM "public"."app_builder_config_property" WHERE id = '56fe4b031156b049b14f26feedbb9c4d';
DELETE FROM "public"."app_builder_config_property" WHERE id = '2e48b8ccc78be34abdc18876eb649a6a';
DELETE FROM "public"."app_builder_config_property" WHERE id = 'dcdd0ee7dbb76b478bfe5686ee557441';
DELETE FROM "public"."app_builder_config_property" WHERE id = '56fe4b031156b049b14f26feedff534d';
DELETE FROM "public"."app_builder_config_property" WHERE id = '5c7c8c088dfa2a4dac24f2b289726b78';
DELETE FROM "public"."app_builder_config_property" WHERE id = '0b3677d53d8da544a82bbe900e9d536b';
DELETE FROM "public"."app_builder_config_property" WHERE id = '0b3677d53d8da544a82bbe900e9d536c';

DELETE FROM "public"."app_builder_form" WHERE id = 'b8986770a6ffef44bbf2a9f26d6fc1bc';
DELETE FROM "public"."app_builder_form" WHERE id = 'b8986770a6ffef44bbf2a9f26d6fc1bd';
DELETE FROM "public"."app_builder_form" WHERE id = 'dc92ba4fb47f4b13b4b8113aa5cfd99c';
DELETE FROM "public"."app_builder_form" WHERE id = 'df4ac19ba0bf437694cd3eb4011bf23c';
DELETE FROM "public"."app_builder_form" WHERE id = '3ec9ead2ad5a478e82241af9e521f201';
DELETE FROM "public"."app_builder_form" WHERE id = 'b729973429074ae784c9a699afb66d21';

DELETE FROM "public"."app_builder_form_property" WHERE id = '3073f4896620fb488d9fd3349ee23504';
DELETE FROM "public"."app_builder_form_property" WHERE id = 'd9fcb95f48d33648a4e12d629399d713';
DELETE FROM "public"."app_builder_form_property" WHERE id = '4df1cc408fb08b46842861dbfa3cb2ae';
DELETE FROM "public"."app_builder_form_property" WHERE id = '6269e12e4a908b4ba0d455c402ce8c3d';
DELETE FROM "public"."app_builder_form_property" WHERE id = 'b01af303ce27a544a45a3a9491aeb03e';
DELETE FROM "public"."app_builder_form_property" WHERE id = '46b39a9533bbb247a38e976d4af41eb0';
DELETE FROM "public"."app_builder_form_property" WHERE id = '9b3a72544963c64e806dc07d6fff5207';
DELETE FROM "public"."app_builder_form_property" WHERE id = '9b3a72544963c64e806dc07d6fff5208';
DELETE FROM "public"."app_builder_form_property" WHERE id = '9b3a72544963c64e806dc07d6fff5209';

DELETE FROM "public"."app_builder_form_property" WHERE id = '0a63fd81309a41389107b06fe7a07623';
DELETE FROM "public"."app_builder_form_property" WHERE id = '9813a18f395e4319830cb93d99db25d6';
DELETE FROM "public"."app_builder_form_property" WHERE id = 'ff550e312f834f3f98689a0469d64302';
DELETE FROM "public"."app_builder_form_property" WHERE id = '2f504207abaf4ad4a3196c8d5e22b76b';
DELETE FROM "public"."app_builder_form_property" WHERE id = '647276ba3b8845db887928658ec00b9c';
DELETE FROM "public"."app_builder_form_property" WHERE id = '5734350a031649fb9f7aaaaa17ebc090';
DELETE FROM "public"."app_builder_form_property" WHERE id = '1707ef2c0648400fad476082bcfbe1b6';
DELETE FROM "public"."app_builder_form_property" WHERE id = 'ef87e0eebe624db39c30f0e77ed4af22';

DELETE FROM "public"."app_builder_flow_graph" WHERE id = '9997f1555b41452b924d1a8b2229bde4';
DELETE FROM "public"."app_builder_flow_graph" WHERE id = '9997f1555b41452b924d1a8b2229bde3';
DELETE FROM "public"."app_builder_flow_graph" WHERE id = 'beefffd1168b4785a71f149a2a530d2f';
DELETE FROM "public"."app_builder_flow_graph" WHERE id = 'b2ecde0b919841f5867d2e89bb46095c';
DELETE FROM "public"."app_builder_flow_graph" WHERE id = '3bb39bed81f44549b84d20cc6e3b530b';


DELETE FROM "task" WHERE id = 'dc27c37e6a1143e9a628d41026dd6703';

DELETE FROM "flow_graph" WHERE id = 'beefffd1168b4785a71f149a2a530d2f';
DELETE FROM "flow_graph" WHERE id = '3bb39bed81f44549b84d20cc6e3b530b';

DELETE FROM "flow_definition" WHERE definition_id = '45befdde3d794a368e3619e2c464ddbc';
DELETE FROM "flow_definition" WHERE definition_id = '0a3bd341d945405bb4148f23c1748ddc';
DELETE FROM "flow_definition" WHERE definition_id = '79f90c063f144b90a4353b5f63510162';






-- app_builder_app 表结构更新
ALTER TABLE app_builder_app ADD COLUMN app_built_type varchar(8) not null default 'workflow';
ALTER TABLE app_builder_app ADD COLUMN app_category varchar(16) not null default 'chatbot';
ALTER TABLE app_builder_app ADD COLUMN app_type varchar(255) DEFAULT '';

-- 把所有app_type刷成通用的
UPDATE app_builder_app SET app_type = '4db152b24f94473ab683b1acbfe3c865';




-- app_builder_form_property表结构更新
ALTER TABLE app_builder_form_property ADD COLUMN data_from      varchar(8);
ALTER TABLE app_builder_form_property ADD COLUMN in_group       varchar(8);
ALTER TABLE app_builder_form_property ADD COLUMN description    varchar(64);
ALTER TABLE app_builder_form_property ADD COLUMN default_index  int2 default 0;
comment on column app_builder_form_property.data_from is '数据来源';
comment on column app_builder_form_property.in_group is '应用所属的组';
comment on column app_builder_form_property.description is '应用描述';
comment on column app_builder_form_property.default_index is '属性的默认顺序';


-- 数据刷新
-- 根据app_id更新app_builder_form_property
DROP PROCEDURE IF EXISTS update_form_property;

CREATE OR REPLACE PROCEDURE update_form_property()
LANGUAGE plpgsql
AS
$$
DECLARE
    app_ids VARCHAR[];
	  app_id_tmp VARCHAR;
	  inspiration_default_value VARCHAR := '{"category":[{"title":"root","id":"root","children":[]}],"inspirations":[]}';
	  recommend_default_value VARCHAR := '{"showRecommend":false, "list":[]}';
	  property_num INT := 0;
BEGIN
    -- 从 app_builder_app 表中获取所有 type = 'app' 的 id 列表，排除初始化的小海
    SELECT array_agg(app_builder_app.id) INTO app_ids FROM app_builder_app WHERE type = 'app' AND id != '3a617d8aeb1d41a9ad7453f2f0f70d61' AND is_deleted = 0;

		-- 使用 FOREACH 遍历 app_ids 数组
	IF app_ids IS NOT NULL THEN
        FOREACH app_id_tmp IN ARRAY app_ids LOOP
		    -- 跳过模版数据
		    IF app_id_tmp = 'df87073b9bc85a48a9b01eccc9afccc4' THEN
				  CONTINUE;
				END IF;
			  IF app_id_tmp = 'df87073b9bc85a48a9b01eccc9afccc5' THEN
				  CONTINUE;
				END IF;
				IF app_id_tmp = '3a617d8aeb1d41a9ad7453f2f0f70d61' THEN
				  CONTINUE;
				END IF;
		    -- 重置数据
		    inspiration_default_value := '{"category":[{"title":"root","id":"root","children":[]}],"inspirations":[]}';
	      recommend_default_value := '{"showRecommend":false, "list":[]}';
		  				property_num := 0;

        RAISE NOTICE 'Processing: %', app_id_tmp;  -- 输出当前处理的 workflow
        -- 你可以在这里执行其他操作，比如插入数据，更新记录等
			  SELECT app_builder_form_property.default_value INTO inspiration_default_value FROM app_builder_form_property WHERE app_builder_form_property."app_id" = app_id_tmp AND app_builder_form_property."name" = 'inspiration';
				SELECT app_builder_form_property.default_value INTO recommend_default_value FROM app_builder_form_property WHERE app_builder_form_property."app_id" = app_id_tmp AND app_builder_form_property."name" = 'recommend';
				IF recommend_default_value IS NULL THEN
				  recommend_default_value := '{"showRecommend":false, "list":[]}';
				ELSE
				  recommend_default_value := '{"showRecommend":true, "list":' || recommend_default_value || '}';
				END IF;

				SELECT COUNT(*) INTO property_num FROM app_builder_form_property WHERE app_builder_form_property.app_id = app_id_tmp;
				IF property_num > 8 THEN
          DELETE FROM app_builder_config_property WHERE app_builder_config_property.form_property_id = (SELECT app_builder_form_property.id FROM app_builder_form_property WHERE app_builder_form_property.app_id = app_id_tmp AND app_builder_form_property."name" = 'recommend');
					DELETE FROM app_builder_form_property WHERE app_builder_form_property.app_id = app_id_tmp AND app_builder_form_property."name" = 'recommend';
          
				END IF;
				UPDATE app_builder_form_property SET name = 'workflow', data_type = 'String', default_value = 'null', data_from = 'none', in_group = 'null', description = 'i18n_appBuilder_{form_property_workflow}', default_index = 0 WHERE app_builder_form_property.app_id = app_id_tmp AND app_builder_form_property.name = 'model';
				UPDATE app_builder_form_property SET name = 'ability', data_type = 'String', default_value = 'null', data_from = 'none', in_group = 'workflow', description = 'i18n_appBuilder_{form_property_ability}', default_index = 1 WHERE app_builder_form_property.app_id = app_id_tmp AND app_builder_form_property.name = 'systemPrompt';
				UPDATE app_builder_form_property SET name = 'enterWorkflow', data_type = 'String', default_value = 'null', data_from = 'none', in_group = 'ability', description = 'i18n_appBuilder_{form_property_enterWorkflow}', default_index = 2 WHERE app_builder_form_property.app_id = app_id_tmp AND app_builder_form_property.name = 'workflows';
				UPDATE app_builder_form_property SET name = 'chat', data_type = 'String', default_value = 'null', data_from = 'none', in_group = 'workflow', description = 'i18n_appBuilder_{form_property_chat}', default_index = 3 WHERE app_builder_form_property.app_id = app_id_tmp AND app_builder_form_property.name = 'tools';
				UPDATE app_builder_form_property SET name = 'opening', data_type = 'String', default_value = (SELECT app_builder_app.attributes->'greeting' FROM app_builder_app WHERE id = app_id_tmp), data_from = 'input', in_group = 'chat', description = 'i18n_appBuilder_{form_property_opening}', default_index = 4 WHERE app_builder_form_property.app_id = app_id_tmp AND app_builder_form_property.name = 'temperature';
				UPDATE app_builder_form_property SET name = 'recommend', data_type = 'object', default_value = recommend_default_value, data_from = 'input', in_group = 'chat', description = 'i18n_appBuilder_{form_property_recommend}', default_index = 6 WHERE app_builder_form_property.app_id = app_id_tmp AND app_builder_form_property.name = 'memory';
				UPDATE app_builder_form_property SET name = 'memory', data_type = 'List<String>', default_value = '["jade6qm5eg", "memory"]', data_from = 'graph', in_group = 'chat', description = 'i18n_appBuilder_{form_property_memory}', default_index = 5 WHERE app_builder_form_property.app_id = app_id_tmp AND app_builder_form_property.name = 'knowledge';
				UPDATE app_builder_form_property SET name = 'inspiration', data_type = 'object', default_value = inspiration_default_value, data_from = 'input', in_group = 'chat', description = 'i18n_appBuilder_{form_property_inspiration}', default_index = 7 WHERE app_builder_form_property.app_id = app_id_tmp AND app_builder_form_property.name = 'inspiration';
        END LOOP;
    ELSE
    END IF;
END;
$$;

CALL update_form_property();
-- 结束

-- 增加旧应用多模态配置，默认关闭
INSERT INTO "public"."app_builder_form_property" ("id", "form_id", "name", "data_type", "default_value", "is_deleted", "app_id", "data_from", "in_group", "description", "default_index")
SELECT DISTINCT ON (a.id)
generate_uuid_text(), abfp.form_id, 'multimodal', 'object', '{"useMultimodal": false}', 0, a.id, 'input', 'chat', '多模态', 8
FROM app_builder_app a JOIN app_builder_form_property abfp ON a.id = abfp.app_id
 WHERE a.is_deleted = 0
	AND a.id NOT IN (
	'df87073b9bc85a48a9b01eccc9afccc3',
  'df87073b9bc85a48a9b01eccc9afccc4',
	'df87073b9bc85a48a9b01eccc9afccc5')
				AND NOT EXISTS (
	SELECT 1
	FROM "public"."app_builder_form_property" abfp2 WHERE abfp2.app_id = a.id AND abfp2.name = 'multimodal'
);

INSERT INTO "public"."app_builder_config_property" ("id", "node_id", "form_property_id", "config_id", "is_deleted")
SELECT DISTINCT ON (a.config_id)
generate_uuid_text(), NULL, abfp.id, a.config_id, 0
FROM app_builder_app a JOIN app_builder_form_property abfp ON a.id = abfp.app_id WHERE a.is_deleted = 0
AND a.id NOT IN (
	'df87073b9bc85a48a9b01eccc9afccc3',
  'df87073b9bc85a48a9b01eccc9afccc4',
	'df87073b9bc85a48a9b01eccc9afccc5')
 AND NOT EXISTS (
	SELECT 1
	FROM "public"."app_builder_config_property" abcp WHERE abcp.form_property_id = abfp.id AND abcp.config_id = a.config_id
);



-- app_builder_runtime_info新增字段

ALTER TABLE app_builder_runtime_info ADD COLUMN next_position_id  varchar(64);




-- store相关
-- 涉及四层结构的更新：
ALTER TABLE store_tool
ALTER COLUMN created_time TYPE timestamp(9),
ALTER COLUMN updated_time TYPE timestamp(9),
ADD COLUMN IF NOT EXISTS group_name varchar(256),
ADD COLUMN IF NOT EXISTS definition_name varchar(256),
ADD COLUMN IF NOT EXISTS definition_group_name varchar(256);


ALTER TABLE store_plugin add COLUMN source VARCHAR(16) DEFAULT '';
ALTER TABLE store_plugin_tool add COLUMN source VARCHAR(16) DEFAULT '';
ALTER TABLE store_app add COLUMN source VARCHAR(16) DEFAULT '';

ALTER TABLE store_plugin add COLUMN icon text;
ALTER TABLE store_plugin_tool add COLUMN icon text;
ALTER TABLE store_app add COLUMN icon text;

ALTER TABLE store_tool ADD COLUMN extensions json default '{}'::json not null;

ALTER TABLE store_app add COLUMN app_category varchar(16) default 'chatbot';

UPDATE store_plugin_tool spt
SET source = st.source
FROM store_tool st
WHERE spt.tool_unique_name = st.unique_name;

UPDATE store_plugin sp
SET source = spt.source
FROM store_plugin_tool spt
WHERE spt.plugin_id = sp.plugin_id;


create table if not exists store_definition
(
    "id"             bigserial   primary key               not null,
    "created_time"   timestamp(9)   default current_timestamp not null,
    "updated_time"   timestamp(9)   default current_timestamp not null,
    "creator"        varchar(30) default 'system'          not null,
    "modifier"       varchar(30) default 'system'          not null,
    "name"           varchar(256)                          not null,
    "schema"         json        default '{}'::json        not null,
    "definition_group_name" varchar(256)                   not null,
    unique("definition_group_name", "name")
);


UPDATE store_tool
SET
    group_name = unique_name,
    definition_name = unique_name,
    definition_group_name = unique_name;


INSERT INTO store_definition (name, schema, definition_group_name)
SELECT definition_name, schema, definition_group_name
FROM store_tool ON CONFLICT ("definition_group_name", "name") DO NOTHING;


create table if not exists store_definition_group
(
    "id"             bigserial   primary key               not null,
    "created_time"   timestamp(9)   default current_timestamp not null,
    "updated_time"   timestamp(9)   default current_timestamp not null,
    "creator"        varchar(30) default 'system'          not null,
    "modifier"       varchar(30) default 'system'          not null,
    "name"           varchar(256)                          not null,
    "summary"        text        default 'no summary'      not null,
    "description"    text        default 'no desc'         not null,
    "extensions"     json        default '{}'::json        not null,
    unique("name")
    );

create table if not exists store_tool_group
(
    "id"             bigserial   primary key               not null,
    "created_time"   timestamp(9)   default current_timestamp not null,
    "updated_time"   timestamp(9)   default current_timestamp not null,
    "creator"        varchar(30) default 'system'          not null,
    "modifier"       varchar(30) default 'system'          not null,
    "name"           varchar(256)                          not null,
    "definition_group_name" varchar(256)                   not null,
    "summary"        text        default 'no summary'      not null,
    "description"    text        default 'no desc'         not null,
    "extensions"     json        default '{}'::json        not null,
    unique("name")
    );


INSERT INTO store_definition_group (name)
SELECT definition_group_name
FROM store_tool ON CONFLICT ("name") DO NOTHING;

INSERT INTO store_tool_group (name, definition_group_name)
SELECT group_name, definition_group_name
FROM store_tool ON CONFLICT ("name") DO NOTHING;



-- store 存量数据升级
ALTER TABLE store_tool
ALTER COLUMN source SET DEFAULT '',
ALTER COLUMN source DROP NOT NULL; -- 或 DROP NOT NULL
-- 根据tool_unique_name上移source和icon字段
DROP PROCEDURE IF EXISTS pull_up_icon_source;


CREATE OR REPLACE PROCEDURE pull_up_icon_source()
LANGUAGE plpgsql
AS
$$
DECLARE
    tool_unique_names VARCHAR[];
	tmp_tool_unique_name VARCHAR;
	  tmp_source VARCHAR;
	  tmp_icon VARCHAR;
	  tmp_creator VARCHAR;
	  tmp_modifier VARCHAR;
	  tmp_app_creator VARCHAR;
BEGIN
    -- 从 store_app 表中获取所有 tool_unique_name 列表
    SELECT array_agg(store_app.tool_unique_name) INTO tool_unique_names FROM store_app;

	-- 使用 FOREACH 遍历 app_ids 数组
	IF tool_unique_names IS NOT NULL THEN
        FOREACH tmp_tool_unique_name IN ARRAY tool_unique_names LOOP
		    -- 跳过模版数据
            RAISE NOTICE 'Processing: %', tmp_tool_unique_name;  -- 输出当前处理的 tool
            -- 你可以在这里执行其他操作，比如插入数据，更新记录等
			  SELECT store_tool.source INTO tmp_source FROM store_tool WHERE store_tool."unique_name" = tmp_tool_unique_name;
				SELECT store_tool.icon INTO tmp_icon FROM store_tool WHERE store_tool."unique_name" = tmp_tool_unique_name;
				SELECT store_tool.creator INTO tmp_creator FROM store_tool WHERE store_tool."unique_name" = tmp_tool_unique_name;
				SELECT store_tool.modifier INTO tmp_modifier FROM store_tool WHERE store_tool."unique_name" = tmp_tool_unique_name;
				IF tmp_source = 'Builtin' THEN
				  CONTINUE;
				END IF;

			UPDATE store_app SET source = tmp_source, icon = tmp_icon WHERE store_app."tool_unique_name" = tmp_tool_unique_name;
			SELECT store_app.creator INTO tmp_app_creator FROM store_app WHERE store_app."tool_unique_name" = tmp_tool_unique_name;
				IF tmp_app_creator = 'system' AND tmp_creator != 'system'THEN
				  UPDATE store_app SET creator = tmp_creator, modifier = tmp_modifier WHERE store_app."tool_unique_name" = tmp_tool_unique_name;
				END IF;

        END LOOP;
    ELSE
    END IF;
END;
$$;

CALL pull_up_icon_source();
-- 结束


-- 删除store_tool里的source
ALTER TABLE store_tool DROP COLUMN source;
ALTER TABLE store_tool DROP COLUMN icon;



-- 新增表
-- 新增system config表
CREATE TABLE aipp_system_config(
    id serial PRIMARY KEY,
    config_key VARCHAR(64)NOT NULL,
    config_value JSONB NOT NULL,
    config_group VARCHAR(64)NOT NULL,
    config_parent VARCHAR(64)DEFAULT NULL);

CREATE INDEX config_key_index ON aipp_system_config(config_key);
CREATE UNIQUE INDEX group_key_unique_index ON aipp_system_config(config_group, config_key);


-- 增加执行一下初始化sql

INSERT INTO aipp_system_config(config_key, config_value, config_group, config_parent)VALUES('system', '{"template": "You ara a prompt generator, Your job is to generate prompt from the input of the user.\n\nThe Prompt must follow the style of the example below:\n\n###\ninput:\n生活助手\n\noutput:\n角色：你是一个智能生活助手。\n背景：作为一款集成多种智能功能的应用程序，你需要熟悉各种智能家居设备、日程安排、健康数据等相关知识。\n技能：智能家居控制照明、温控、安防、日程管理（提醒、安排等）、健康监测（睡眠、运行、饮食等）、信息查询、语音交互等。\n目标：为用户提供便捷。\n限制：你可以访问用户的智能家居设备、日历、健康数据等相关信息，并根据需要进行协作和响应。\n###\n\n**DO NOT GENERATE ANY OTHER CONTENT EXCEPT OF THE PROMPT TEMPLATE**\n\ninput: {{input}}"}', 'template', NULL);

--app_builder_app_type
-- 应用业务分类表
create table if not exists app_builder_app_type
(
    id         varchar(64) not null primary key,
    name       varchar(255) not null,
    tenant_id  varchar(255) not null,
    create_at  timestamp    not null default current_timestamp,
    update_at  timestamp    not null default current_timestamp,
    CONSTRAINT "app_builder_app_type_name_tenant_id_key" UNIQUE ("name", "tenant_id")
);


-- app_chat_num
create table if not exists app_chat_num (
      id varchar(32) primary key,
      app_id varchar(32) not null,
      chat_mode varchar(8) not null, --true\false
      chat_num int check (chat_num <= 16)
);
create unique index if not exists idx_app_chat_mode on app_chat_num("app_id", "chat_mode");



-- app_template
-- 应用模板表
create table if not exists app_template (
     id varchar(64) not null primary key,
     name varchar(255) not null,
     built_type varchar(8) not null,
     category varchar(16) not null,
     attributes json not null default '{}'::json,
     app_type varchar(255) not null,
     "like" int8 not null default 0,
     collection int8 not null default 0,
     usage int8 not null default 0,
     version varchar(255),
     config_id varchar(255) not null,
     flow_graph_id varchar(255) not null,
     create_by varchar(64) not null,
     create_at timestamp(6) not null default CURRENT_TIMESTAMP,
     update_by varchar(64) not null,
     update_at timestamp(6) not null default CURRENT_TIMESTAMP,
     is_deleted int2 not null default 0
);

--user_custom_inspiration
create table if not exists user_custom_inspiration
(
    id         bigserial not null primary key,
    parent_id        varchar(255) not null,
    category_id   varchar(255)  not null,
    value      json not null,
    create_user varchar(255) not null,
    aipp_id varchar(255) not null,
    inspiration_id varchar(255) not null
    );


--conversation_record
create table if not exists conversation_record
(
    id          bigserial
        primary key,
    app_id      varchar(255),
    question    text,
    answer      text,
    create_user varchar(255),
    create_time timestamp,
    finish_time timestamp,
    instance_id varchar(255)
);


--metrics_access

create table if not exists metrics_access
(
    id           bigserial
        primary key,
    app_id       varchar(255),
    total_access bigint,
    create_time  timestamp
);


--usr_feedback_info
CREATE TABLE IF NOT EXISTS usr_feedback_info
(
    id bigserial NOT NULL PRIMARY KEY,
    usr_feedback_text text,
    usr_feedback integer,
    instance_id varchar(255) NOT NULL
);



-- usr_collection_info ？这个需要吗
CREATE TABLE IF NOT EXISTS usr_collection_info
(
    id bigserial NOT NULL PRIMARY KEY,
    app_id varchar(255) NOT NULL,
    usr_info varchar(64)  NOT NULL
);

-- user_info ？这个表需要吗
CREATE TABLE IF NOT EXISTS user_info
(
    id bigserial NOT NULL PRIMARY KEY,
    default_app varchar(255) NOT NULL,
    user_name varchar(64) NOT NULL UNIQUE
);

-- 用户自定义模型相关表
create table if not exists t_app_engine_model
(
    "id" bigserial primary key                           not null,
    "created_at" timestamp(9) default current_timestamp  not null,
    "updated_at" timestamp(9) default current_timestamp  not null,
    "created_by" varchar(64) default 'system'            not null,
    "updated_by" varchar(64) default 'system'            not null,
    "model_id" varchar(255)                              not null,
    "name" varchar(255)                                  not null,
    "tag" varchar(255)                                   not null,
    "base_url" varchar(255)                              not null,
    "type" varchar(255) default 'chat_completions'       not null
    );
create unique index if not exists model_id_index on t_app_engine_model("model_id");
comment on table t_app_engine_model is '模型信息表';
comment on column t_app_engine_model.id is '主键';
comment on column t_app_engine_model.created_at is '模型信息创建时间';
comment on column t_app_engine_model.updated_at is '模型信息修改时间';
comment on column t_app_engine_model.created_by is '模型信息创建者';
comment on column t_app_engine_model.updated_by is '模型信息最近更新者';
comment on column t_app_engine_model.name is '模型名字';
comment on column t_app_engine_model.tag is '模型标签';
comment on column t_app_engine_model.base_url is '模型访问接口地址';
comment on column t_app_engine_model.type is '模型类型';

create table if not exists t_app_engine_user_model
(
    "id" bigserial primary key                           not null,
    "created_at" timestamp(9) default current_timestamp  not null,
    "updated_at" timestamp(9) default current_timestamp  not null,
    "created_by" varchar(64) default 'system'            not null,
    "updated_by" varchar(64) default 'system'            not null,
    "user_id" varchar(255)                               not null,
    "model_id" varchar(255)                              not null,
    "api_key" varchar(255)                               not null,
    "is_default" smallint default 0                      not null
    );
create unique index if not exists user_model_id_index on t_app_engine_user_model("user_id", "model_id");
comment on table t_app_engine_user_model is '用户模型关系表';
comment on column t_app_engine_user_model.id is '主键';
comment on column t_app_engine_user_model.created_at is '用户模型关系创建时间';
comment on column t_app_engine_user_model.updated_at is '用户模型关系修改时间';
comment on column t_app_engine_user_model.created_by is '用户模型关系创建者';
comment on column t_app_engine_user_model.updated_by is '用户模型关系最近更新者';
comment on column t_app_engine_user_model.user_id is '用户id';
comment on column t_app_engine_user_model.model_id is '模型id';
comment on column t_app_engine_user_model.api_key is '用户访问token';
comment on column t_app_engine_user_model.is_default is '是否为默认模型';





-- 应用评估相关表
create table if not exists t_app_engine_eval_dataset
(
    "id"          bigserial primary key                 not null,
    "name"        varchar(30)                           not null,
    "description" varchar(100)                          not null,
    "schema"      text                                  not null,
    "created_at"  timestamp   default current_timestamp not null,
    "updated_at"  timestamp   default current_timestamp not null,
    "created_by"  varchar(10) default 'system'          not null,
    "updated_by"  varchar(10) default 'system'          not null,
    "app_id"      varchar(255)                          not null
);

comment on table t_app_engine_eval_dataset is '评估数据表';
comment on column t_app_engine_eval_dataset.id is '主键';
comment on column t_app_engine_eval_dataset.name is '数据集名字';
comment on column t_app_engine_eval_dataset.description is '数据集描述';
comment on column t_app_engine_eval_dataset.schema is '数据集 schema';
comment on column t_app_engine_eval_dataset.created_at is '数据集创建时间';
comment on column t_app_engine_eval_dataset.updated_at is '数据集修改时间';
comment on column t_app_engine_eval_dataset.created_by is '数据集创建者';
comment on column t_app_engine_eval_dataset.updated_by is '数据集最近更新者';
comment on column t_app_engine_eval_dataset.app_id is '外键，关联应用 ID';

create table if not exists t_app_engine_eval_data
(
    "id"              bigserial primary key                       not null,
    "content"         text                                        not null,
    "created_version" bigint                                      not null,
    "expired_version" bigint      default 9223372036854775807     not null,
    "created_at"      timestamp   default current_timestamp       not null,
    "updated_at"      timestamp   default current_timestamp       not null,
    "created_by"      varchar(10) default 'system'                not null,
    "updated_by"      varchar(10) default 'system'                not null,
    "dataset_id"      bigint references t_app_engine_eval_dataset not null
);

create index if not exists idx_ds_id_created_version_expired_version on t_app_engine_eval_data ("dataset_id", "created_version", "expired_version");

comment on table t_app_engine_eval_data is '评估数据表';
comment on column t_app_engine_eval_data.id is '主键';
comment on column t_app_engine_eval_data.content is '评估内容';
comment on column t_app_engine_eval_data.created_version is '创建版本，只在首次插入时写';
comment on column t_app_engine_eval_data.expired_version is '过期版本';
comment on column t_app_engine_eval_data.created_at is '创建时间，只在首次插入时写';
comment on column t_app_engine_eval_data.updated_at is '更新时间';
comment on column t_app_engine_eval_data.created_by is '创建者';
comment on column t_app_engine_eval_data.updated_by is '更新者';
comment on column t_app_engine_eval_data.dataset_id is '外键，关联评估数据集';



create table if not exists t_app_engine_eval_task
(
    "id"          bigserial primary key                  not null,
    "name"        varchar(64)                            not null,
    "description" varchar(512)                           not null,
    "status"      varchar(32)                            not null,
    "created_at"  timestamp(9) default current_timestamp not null,
    "updated_at"  timestamp(9) default current_timestamp not null,
    "created_by"  varchar(64)  default 'system'          not null,
    "updated_by"  varchar(64)  default 'system'          not null,
    "app_id"      varchar(255)                           not null,
    "workflow_id" varchar(32)                            not null
);

comment on table t_app_engine_eval_task is '评估任务表';
comment on column t_app_engine_eval_task.id is '主键';
comment on column t_app_engine_eval_task.name is '评估任务名字';
comment on column t_app_engine_eval_task.description is '评估任务描述';
comment on column t_app_engine_eval_task.status is '评估任务状态';
comment on column t_app_engine_eval_task.created_at is '评估任务创建时间';
comment on column t_app_engine_eval_task.updated_at is '评估任务修改时间';
comment on column t_app_engine_eval_task.created_by is '评估任务创建者';
comment on column t_app_engine_eval_task.updated_by is '评估任务最近更新者';
comment on column t_app_engine_eval_task.app_id is '应用 ID';
comment on column t_app_engine_eval_task.workflow_id is '工作流 ID';

create table if not exists t_app_engine_eval_report
(
    "id"            bigserial primary key not null,
    "node_id"       varchar(64)           not null,
    "average_score" real                  not null,
    "histogram"     varchar(512)          not null,
    "instance_id"   bigint                not null
);

comment on table t_app_engine_eval_report is '评估报告表';
comment on column t_app_engine_eval_report.id is '主键';
comment on column t_app_engine_eval_report.node_id is '评估节点 ID';
comment on column t_app_engine_eval_report.average_score is '评估报告算法平均得分';
comment on column t_app_engine_eval_report.histogram is '评估报告直方图';
comment on column t_app_engine_eval_report.instance_id is '评估任务实例 ID';

create table if not exists t_app_engine_eval_task_case
(
    "id"          bigserial primary key not null,
    "pass"        boolean               not null,
    "instance_id" bigint                not null
);

comment on table t_app_engine_eval_task_case is '评估任务用例表';
comment on column t_app_engine_eval_task_case.id is '主键';
comment on column t_app_engine_eval_task_case.pass is '评估用例结果';
comment on column t_app_engine_eval_task_case.instance_id is '评估任务实例 ID';

create table if not exists t_app_engine_eval_record
(
    "id"           bigserial primary key not null,
    "input"        text                  not null,
    "node_id"      varchar(64)           not null,
    "node_name"    varchar(64)           not null,
    "score"        real                  not null,
    "task_case_id" bigint                not null
);

comment on table t_app_engine_eval_record is '评估任务用例评估结果表';
comment on column t_app_engine_eval_record.id is '主键';
comment on column t_app_engine_eval_record.input is '用例输入';
comment on column t_app_engine_eval_record.node_id is '评估节点 ID';
comment on column t_app_engine_eval_record.node_name is '评估节点名称';
comment on column t_app_engine_eval_record.score is '用例评估得分';
comment on column t_app_engine_eval_record.task_case_id is '评估任务用例 ID';

create table if not exists t_app_engine_eval_instance
(
    "id"          bigserial    primary key               not null,
    "status"      varchar(32)  default 'RUNNING'         not null,
    "pass_rate"   smallint     default -1                not null,
    "pass_count"  smallint     default 0                 not null,
    "created_by"  varchar(64)  default 'system'          not null,
    "created_at"  timestamp(9) default current_timestamp not null,
    "updated_at"  timestamp(9) default current_timestamp not null,
    "finished_at" timestamp(9) default current_timestamp not null,
    "trace_id"    varchar(32)                            not null,
    "task_id"     bigint                                 not null
);

comment on table t_app_engine_eval_instance is '评估任务实例表';
comment on column t_app_engine_eval_instance.id is '主键';
comment on column t_app_engine_eval_instance.status is '评估任务实例状态';
comment on column t_app_engine_eval_instance.pass_rate is '评估任务实例用例通过率';
comment on column t_app_engine_eval_instance.pass_count is '评估任务实例用例通过数量';
comment on column t_app_engine_eval_instance.created_at is '评估任务实例创建时间';
comment on column t_app_engine_eval_instance.updated_at is '评估任务实例修改时间';
comment on column t_app_engine_eval_instance.finished_at is '评估任务实例完成时间';
comment on column t_app_engine_eval_instance.created_by is '评估任务实例创建者';
comment on column t_app_engine_eval_instance.trace_id is '评估任务实例运行 ID';
comment on column t_app_engine_eval_instance.task_id is '评估任务 ID';

create table if not exists t_app_engine_eval_algorithm
(
    "id"               bigserial primary key not null,
    "node_id"          varchar(64)           not null,
    "node_name"        varchar(32)           not null,
    "algorithm_schema" text                  not null,
    "pass_score"       real                  not null,
    "task_id"          bigint                not null
);

comment on table t_app_engine_eval_algorithm is '评估任务算法表';
comment on column t_app_engine_eval_algorithm.id is '主键';
comment on column t_app_engine_eval_algorithm.node_id is '评估节点 ID';
comment on column t_app_engine_eval_algorithm.node_name is '评估节点名称';
comment on column t_app_engine_eval_algorithm.algorithm_schema is '评估算法格式规范';
comment on column t_app_engine_eval_algorithm.pass_score is '评估算法及格分';
comment on column t_app_engine_eval_algorithm.task_id is '评估任务 ID';




-- 去jober新增的表
-- 新增 task_new, task_instance_new
CREATE TABLE IF NOT EXISTS task_new (
    "id" char(32)  NOT NULL PRIMARY KEY,
    "name" varchar(255)  NOT NULL,
    "version" varchar(64) NOT NULL,
    "template_id" char(32) NOT NULL,
    "tenant_id" char(32) NOT NULL,
    "attributes" json NOT NULL DEFAULT '{}'::json,
    "created_by" varchar(127) NOT NULL,
    "created_at" timestamp(6) NOT NULL,
    "updated_by" varchar(127) NOT NULL,
    "updated_at" timestamp(6) NOT NULL,
    "is_deleted" int2 NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS task_instance_new (
    "id" char(32) NOT NULL PRIMARY KEY,
    "task_id" char(32) NOT NULL,
    "task_name" varchar(255),
    "creator" varchar(127),
    "create_time" timestamp(6),
    "modify_by" varchar(127),
    "modify_time" timestamp(6),
    "finish_time" timestamp(6),
    "flow_instance_id" char(32),
    "curr_form_id" char(32),
    "curr_form_version" varchar(127),
    "curr_form_data" text,
    "smart_form_time" timestamp(6),
    "instance_status" varchar(32),
    "instance_progress" varchar(127),
    "instance_agent_result" text,
    "instance_child_instance_id" char(32),
    "instance_curr_node_id" varchar(127),
    "is_deleted" int2 NOT NULL DEFAULT 0,
    "resume_duration" varchar(127)
);

-- 同步task数据到task_new
INSERT INTO task_new (ID, template_id, created_by, NAME, VERSION, is_deleted, ATTRIBUTES, created_at, updated_by, updated_at, tenant_id)
SELECT ID,
  template_id,
  created_by,
  SPLIT_PART(NAME, '|', 1) AS NAME,
  SPLIT_PART(NAME, '|', 2) AS VERSION,
  0 AS is_deleted,
  ATTRIBUTES,
  created_at,
  updated_by,
  updated_at,
  tenant_id
FROM
  task;






-- 需要修改的数据

-- 以下数据的更新可以通过执行初始化sql完成
-- 模板数据
-- 国际化数据
-- 内置tool数据



-- 去华为属性导致的改动

UPDATE app_builder_flow_graph SET appearance = REPLACE ( appearance, 'com.huawei.fit.jober.aipp.fitable.AippFlowEndCallback', 'modelengine.fit.jober.aipp.fitable.AippFlowEndCallback' ) WHERE appearance LIKE '%com.huawei.fit.jober.aipp.fitable.AippFlowEndCallback%';
UPDATE app_builder_flow_graph SET appearance = REPLACE ( appearance, 'com.huawei.fit.jober.fitable.FlowInfoCallback', 'modelengine.fit.jober.fitable.FlowInfoCallback' ) WHERE appearance LIKE '%com.huawei.fit.jober.fitable.FlowInfoCallback%';
UPDATE app_builder_flow_graph SET appearance = REPLACE ( appearance, 'com.huawei.fit.jober.fitable.FlowInfoException', 'modelengine.fit.jober.fitable.FlowInfoException' ) WHERE appearance LIKE '%com.huawei.fit.jober.fitable.FlowInfoException%';
UPDATE app_builder_flow_graph SET appearance = REPLACE ( appearance, 'com.huawei.fit.jober.aipp.fitable.AippFlowExceptionHandler', 'modelengine.fit.jober.aipp.fitable.AippFlowExceptionHandler' ) WHERE appearance LIKE '%com.huawei.fit.jober.aipp.fitable.AippFlowExceptionHandler%';
UPDATE app_builder_flow_graph SET appearance = REPLACE ( appearance, 'com.huawei.fit.jober.aipp.fitable.LLMComponent', 'modelengine.fit.jober.aipp.fitable.LLMComponent' ) WHERE appearance LIKE '%com.huawei.fit.jober.aipp.fitable.LLMComponent%';


UPDATE flow_definition
SET graph = REPLACE(graph::text,
       'com.huawei.fit.jober.aipp.fitable.AippFlowEndCallback',
       'modelengine.fit.jober.aipp.fitable.AippFlowEndCallback')::jsonb
WHERE graph::text LIKE '%com.huawei.fit.jober.aipp.fitable.AippFlowEndCallback%';
UPDATE flow_definition
SET graph = REPLACE(graph::text,
       'com.huawei.fit.jober.fitable.FlowInfoCallback',
       'modelengine.fit.jober.fitable.FlowInfoCallback')::jsonb
WHERE graph::text LIKE '%com.huawei.fit.jober.fitable.FlowInfoCallback%';
UPDATE flow_definition
SET graph = REPLACE(graph::text,
       'com.huawei.fit.jober.fitable.FlowInfoException',
       'modelengine.fit.jober.fitable.FlowInfoException')::jsonb
WHERE graph::text LIKE '%com.huawei.fit.jober.fitable.FlowInfoException%';
UPDATE flow_definition
SET graph = REPLACE(graph::text,
       'com.huawei.fit.jober.aipp.fitable.AippFlowExceptionHandler',
       'modelengine.fit.jober.aipp.fitable.AippFlowExceptionHandler')::jsonb
WHERE graph::text LIKE '%com.huawei.fit.jober.aipp.fitable.AippFlowExceptionHandler%';
UPDATE flow_definition
SET graph = REPLACE(graph::text,
       'com.huawei.fit.jober.aipp.fitable.LLMComponent',
       'modelengine.fit.jober.aipp.fitable.LLMComponent')::jsonb
WHERE graph::text LIKE '%com.huawei.fit.jober.aipp.fitable.LLMComponent%';

-- 更新store表
-- store相关

INSERT INTO "public"."store_tool" ("name", "schema", "runnables", "unique_name", "group_name", "definition_name", "definition_group_name")
VALUES ('代码', '{"name":"代码","description":"执行用户定义的代码，生成用户定义的配置","parameters":{"type":"object","properties":{"args":{"type":"object","description":"代码节点引用的流程中的参数。"},"code":{"type":"string","description":"用户定义的数据处理代码"},"language":{"type":"string", "description":"用户代码语言"}, "output":{"type":"object","description":"代码节点返参校验规范。"}},"required":["args","code","language","output"]},"order":["args","code","language","output"],"return":{"type":"object"}}','{"FIT":{"fitableId":"default","genericableId":"modelengine.fit.jober.aipp.code.execute"}}','e147f301-957a-4335-a155-1e86d1a45ae5', 'code-group-name', 'code-def-name', 'code-def-group-name')
ON CONFLICT ("unique_name", "version") DO UPDATE SET "name" = EXCLUDED.name, "schema" = EXCLUDED.schema, "runnables" = EXCLUDED.runnables, "unique_name" = EXCLUDED.unique_name, "group_name" = EXCLUDED.group_name, "definition_name" = EXCLUDED.definition_name, "definition_group_name" = EXCLUDED.definition_group_name;
INSERT INTO "public"."store_definition" ( "name", "schema", "definition_group_name" )
VALUES( 'code-def-name', '{"name":"代码","description":"执行用户定义的代码，生成用户定义的配置","parameters":{"type":"object","properties":{"args":{"type":"object","description":"代码节点引用的流程中的参数。"},"code":{"type":"string","description":"用户定义的数据处理代码"},"language":{"type":"string", "description":"用户代码语言"}, "output":{"type":"object","description":"代码节点返参校验规范。"}},"required":["args","code","language","output"]},"order":["args","code","language","output"],"return":{"type":"object"}}', 'code-def-group-name')
ON CONFLICT ("definition_group_name", "name") DO UPDATE SET "name" = EXCLUDED.name, "schema" = EXCLUDED.schema, "definition_group_name" = EXCLUDED.definition_group_name;
INSERT INTO "public"."store_tag" ("tool_unique_name", "name")
VALUES ('e147f301-957a-4335-a155-1e86d1a45ae5', 'FIT')
ON CONFLICT ("tool_unique_name", "name") DO UPDATE SET "tool_unique_name" = EXCLUDED.tool_unique_name, "name" = EXCLUDED.name;
INSERT INTO "public"."store_tag" ("tool_unique_name", "name")
VALUES ('e147f301-957a-4335-a155-1e86d1a45ae5', 'CODENODESTATE')
ON CONFLICT ("tool_unique_name", "name") DO UPDATE SET "tool_unique_name" = EXCLUDED.tool_unique_name, "name" = EXCLUDED.name;
INSERT INTO "public"."store_plugin" ("plugin_id", "plugin_name", "extension", "is_builtin") VALUES ('6789dfcef2355b7b4e76dc53626a98a4b863c3e33c12c43221d03907c025bce0', '代码', '{"name":"代码","version":"1.0.0","type":"python","description":"","pluginFullName":"python_plugin3.zip"}', FALSE)
ON CONFLICT ("plugin_id") DO UPDATE SET "plugin_id" = EXCLUDED.plugin_id, "plugin_name" = EXCLUDED.plugin_name, "extension" = EXCLUDED.extension, "is_builtin" = EXCLUDED.is_builtin;
INSERT INTO "public"."store_plugin_tool" ("tool_name", "plugin_id", "tool_unique_name") VALUES ('代码', '6789dfcef2355b7b4e76dc53626a98a4b863c3e33c12c43221d03907c025bce0', 'e147f301-957a-4335-a155-1e86d1a45ae5')
ON CONFLICT ("plugin_id", "tool_unique_name") DO UPDATE SET "tool_name" = EXCLUDED.tool_name, "plugin_id" = EXCLUDED.plugin_id, "tool_unique_name" = EXCLUDED.tool_unique_name;

INSERT INTO "public"."store_tool" ("name", "schema", "runnables", "unique_name", "group_name", "definition_name", "definition_group_name")
VALUES ('知识检索', '{"name":"知识检索","description":"通过用户问题和知识库配置检索知识文档。","parameters":{"properties":{"query":{"description":"用户问题","oneOf":[{"type":"array","items":{"type":"string"}},{"type":"string"}]},"knowledgeRepos":{"description":"知识库标识","type":"array","items":{"type":"object"}},"option":{"description":"检索参数配置","type":"object","properties":{"indexType":{"type":"object","properties":{"type":{"description":"检索方式类型","type":"string"},"name":{"description":"检索方式名称","type":"string"},"description":{"description":"检索方式描述","type":"string"}}},"referenceLimit":{"type":"object","properties":{"type":{"description":"引用上限类型","type":"string"},"value":{"description":"引用上限数值","type":"integer"}}},"similarityThreshold":{"type":"number","description":"检索相似度阈值"},"apiKey":{"type":"string","description":"用户标识"},"rerankParam":{"type":"object","properties":{"enableRerank":{"description":"重排使能标记","type":"boolean"},"model":{"description":"重排模型的名称","type":"string"},"baseUri":{"description":"重排模型的资源标识符","type":"string"},"topK":{"description":"重排后保留最相关的文档数量","type":"integer"}}}}}},"required":["query","knowledgeRepos","option"],"type":"object"},"return":{"type":"array","items":{"type":"object","description":"知识文档","properties":{"id":{"description":"文档标识","type":"string"},"text":{"description":"文档内容","type":"string"},"score":{"description":"文档分数","type":"number"},"metadata":{"type":"object","description":"知识文档","properties":{"fileName":{"description":"文档名称","type":"string"}}}}}}}', '{"FIT":{"fitableId":"knowledge.service.invoke","genericableId":"modelengine.jade.knowledge.service.retrieve"}}','25887d76-e358-4121-800c-31eb3390fdbd', 'knowledge-retrieval-group-name', 'knowledge-retrieval-def-name', 'knowledge-retrieval-def-group-name')
ON CONFLICT ("unique_name", "version") DO UPDATE SET "name" = EXCLUDED.name, "schema" = EXCLUDED.schema, "runnables" = EXCLUDED.runnables, "unique_name" = EXCLUDED.unique_name, "group_name" = EXCLUDED.group_name, "definition_name" = EXCLUDED.definition_name, "definition_group_name" = EXCLUDED.definition_group_name;
INSERT INTO "public"."store_definition" ( "name", "schema", "definition_group_name" )
VALUES( 'knowledge-retrieval-def-name', '{"name":"知识检索","description":"通过用户问题和知识库配置检索知识文档。","parameters":{"properties":{"query":{"description":"用户问题","oneOf":[{"type":"array","items":{"type":"string"}},{"type":"string"}]},"knowledgeRepos":{"description":"知识库标识","type":"array","items":{"type":"object"}},"option":{"description":"检索参数配置","type":"object","properties":{"indexType":{"type":"object","properties":{"type":{"description":"检索方式类型","type":"string"},"name":{"description":"检索方式名称","type":"string"},"description":{"description":"检索方式描述","type":"string"}}},"referenceLimit":{"type":"object","properties":{"type":{"description":"引用上限类型","type":"string"},"value":{"description":"引用上限数值","type":"integer"}}},"similarityThreshold":{"type":"number","description":"检索相似度阈值"},"apiKey":{"type":"string","description":"用户标识"},"rerankParam":{"type":"object","properties":{"enableRerank":{"description":"重排使能标记","type":"boolean"},"model":{"description":"重排模型的名称","type":"string"},"baseUri":{"description":"重排模型的资源标识符","type":"string"},"topK":{"description":"重排后保留最相关的文档数量","type":"integer"}}}}}},"required":["query","knowledgeRepos","option"],"type":"object"},"return":{"type":"array","items":{"type":"object","description":"知识文档","properties":{"id":{"description":"文档标识","type":"string"},"text":{"description":"文档内容","type":"string"},"score":{"description":"文档分数","type":"number"},"metadata":{"type":"object","description":"知识文档","properties":{"fileName":{"description":"文档名称","type":"string"}}}}}}}', 'knowledge-retrieval-def-group-name')
ON CONFLICT ("definition_group_name", "name") DO UPDATE SET "name" = EXCLUDED.name, "schema" = EXCLUDED.schema, "definition_group_name" = EXCLUDED.definition_group_name;
INSERT INTO "public"."store_tag" ("tool_unique_name", "name")
VALUES ('25887d76-e358-4121-800c-31eb3390fdbd', 'FIT')
ON CONFLICT ("tool_unique_name", "name") DO UPDATE SET "tool_unique_name" = EXCLUDED.tool_unique_name, "name" = EXCLUDED.name;
INSERT INTO "public"."store_tag" ("tool_unique_name", "name")
VALUES ('25887d76-e358-4121-800c-31eb3390fdbd', 'KNOWLEDGERETRIEVALNODESTATE')
ON CONFLICT ("tool_unique_name", "name") DO UPDATE SET "tool_unique_name" = EXCLUDED.tool_unique_name, "name" = EXCLUDED.name;
INSERT INTO "public"."store_plugin" ("plugin_id", "plugin_name", "extension", "is_builtin") VALUES ('a125dfcef2355b7b4e76dc53626a98a4b863c3e33c12c43221d03907c025bce0', '知识检索', '{"name":"知识检索","version":"1.0.0","type":"java","description":"","pluginFullName":"java_plugin3.zip"}', FALSE)
ON CONFLICT ("plugin_id") DO UPDATE SET "plugin_id" = EXCLUDED.plugin_id, "plugin_name" = EXCLUDED.plugin_name, "extension" = EXCLUDED.extension, "is_builtin" = EXCLUDED.is_builtin;
INSERT INTO "public"."store_plugin_tool" ("tool_name", "plugin_id", "tool_unique_name") VALUES ('知识检索', 'a125dfcef2355b7b4e76dc53626a98a4b863c3e33c12c43221d03907c025bce0', '25887d76-e358-4121-800c-31eb3390fdbd')
ON CONFLICT ("plugin_id", "tool_unique_name") DO UPDATE SET "tool_name" = EXCLUDED.tool_name, "plugin_id" = EXCLUDED.plugin_id, "tool_unique_name" = EXCLUDED.tool_unique_name;