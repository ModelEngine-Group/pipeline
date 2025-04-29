-- 流程相关
CREATE TABLE IF NOT EXISTS flow_definition
(
    definition_id VARCHAR(32) PRIMARY KEY,
    meta_id       VARCHAR(32)  NOT NULL,
    name          VARCHAR(256) NOT NULL,
    tenant        VARCHAR(32)  NOT NULL,
    version       VARCHAR(16)  NOT NULL,
    status        VARCHAR(32)  NOT NULL,
    graph         JSONB        NOT NULL,
    created_by    VARCHAR(32)  NOT NULL,
    created_at    timestamp without time zone NOT NULL
);

comment on table flow_definition is '流程定义';
comment on column flow_definition.definition_id is '表示流程定义的唯一标识。由32位16进制字符组成。';
comment on column flow_definition.meta_id is '表示流程定义的元数据标识。由32位16进制字符组成。';
comment on column flow_definition.name is '表示流程定义的元数据标识。';
comment on column flow_definition.tenant is '表示流程定义的租户标识。';
comment on column flow_definition.version is '表示流程定义的版本标识。';
comment on column flow_definition.status is '表示流程定义的状态标识。';
comment on column flow_definition.graph is '表示流程定义的元数据信息。';
comment on column flow_definition.created_by is '表示创建人。';
comment on column flow_definition.created_at is '表示创建时间。';

CREATE UNIQUE INDEX IF NOT EXISTS UK_FLOW_NAME_VERSION ON flow_definition (name, version);
CREATE UNIQUE INDEX IF NOT EXISTS UK_FLOW_META_ID_VERSION ON flow_definition (meta_id, version);

CREATE TABLE IF NOT EXISTS flow_context
(
    context_id    VARCHAR(32) NOT NULL PRIMARY KEY,
    trace_id      VARCHAR(32) NOT NULL,
    trans_id      VARCHAR(32) NOT NULL,
    root_id       VARCHAR(32) NOT NULL,
    stream_id     VARCHAR(64) NOT NULL,
    flow_data     JSONB       NOT NULL,
    position_id   VARCHAR(32) NOT NULL,
    joined        BOOLEAN,
    status        VARCHAR(10) NOT NULL,
    parallel      VARCHAR(32),
    parallel_mode VARCHAR(10),
    previous      VARCHAR(32),
    batch_id      VARCHAR(32),
    from_batch    VARCHAR(32),
    to_batch      VARCHAR(32),
    sent          BOOLEAN DEFAULT FALSE,
    create_at     timestamp without time zone NOT NULL,
    update_at     timestamp without time zone,
    archived_at   timestamp without time zone
);

comment on table flow_context is '流程实例上下文';
comment on column flow_context.context_id is '表示流程实例上下文的唯一标识';
comment on column flow_context.trace_id is '表示流程实例轨迹唯一标识。';
comment on column flow_context.trans_id is '表示流程实例运行唯一标识。';
comment on column flow_context.root_id is '表示流程实例根节点唯一标识。';
comment on column flow_context.stream_id is '表示流程元数据标识和版本唯一标识。';
comment on column flow_context.flow_data is '表示流程实例运行上下文数据。';
comment on column flow_context.position_id is '表示流程实例上下文所处节点位置。';
comment on column flow_context.joined is '表示流程实例上下文是否由平行节点合并。';
comment on column flow_context.status is '表示流程实例上下文状态。';
comment on column flow_context.parallel is '表示流程实例上下文处于哪个平行节点。';
comment on column flow_context.parallel_mode is '表示流程实例上下文所处平行节点状态。';
comment on column flow_context.previous is '表示流程实例上下文来源哪个上下文。';
comment on column flow_context.batch_id is '表示流程实例上下文所处批次标识。';
comment on column flow_context.from_batch is '表示流程实例上下文来源批次标识。';
comment on column flow_context.to_batch is '表示流程实例上下文指向批次标识。';
comment on column flow_context.sent is '表示流程实例上下文是否已被事件发送。';
comment on column flow_context.create_at is '表示流程实例上下文创建时间。';
comment on column flow_context.update_at is '表示流程实例上下文更新时间。';
comment on column flow_context.archived_at is '表示流程实例上下文完成时间。';

CREATE INDEX IF NOT EXISTS INDEX_FLOW_STREAM_ID ON flow_context (stream_id);
CREATE INDEX IF NOT EXISTS INDEX_FLOW_TRACE_ID ON flow_context (trace_id);
CREATE INDEX IF NOT EXISTS INDEX_FLOW_TRANS_ID_POSITION_ID ON flow_context (trans_id, position_id);
CREATE INDEX IF NOT EXISTS INDEX_FLOW_BATCH_ID ON flow_context (batch_id, from_batch, to_batch);

CREATE TABLE IF NOT EXISTS flow_trace
(
    trace_id         VARCHAR(32) NOT NULL PRIMARY KEY,
    stream_id        VARCHAR(64) NOT NULL,
    operator         VARCHAR(32) NOT NULL,
    application_name VARCHAR(32) NOT NULL,
    start_node       VARCHAR(32) NOT NULL,
    cur_nodes        TEXT        NOT NULL,
    start_time       timestamp without time zone NOT NULL,
    end_time         timestamp without time zone,
    merged_to        VARCHAR(32)
);

comment on table flow_trace is '流程轨迹';
comment on column flow_trace.trace_id is '表示流程轨迹的唯一标识';
comment on column flow_trace.stream_id is '表示流程轨迹所处的流程标识';
comment on column flow_trace.operator is '表示流程的发起人';
comment on column flow_trace.application_name is '表示流程启动的应用';
comment on column flow_trace.start_node is '表示流程启动的开始节点';
comment on column flow_trace.cur_nodes is '表示流程实例当前所处节点';
comment on column flow_trace.start_time is '表示流程实例启动时间';
comment on column flow_trace.end_time is '表示流程实例结束时间';
comment on column flow_trace.merged_to is '表示流程实例合并到哪个流程实例';

CREATE INDEX IF NOT EXISTS INDEX_FLOW_TRACE_STREAM_ID ON flow_trace (stream_id);
CREATE INDEX IF NOT EXISTS INDEX_FLOW_TRACE_MERGE_ID ON flow_trace (trace_id, merged_to);

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'flow_trace' AND column_name = 'status'
    ) THEN
        -- 如果不存在，则执行 ALTER TABLE 语句
ALTER TABLE flow_trace ADD COLUMN status VARCHAR(32) NOT NULL DEFAULT 'ARCHIVED';
END IF;
END $$;

CREATE TABLE IF NOT EXISTS fitable_usage
(
    fitable_id      VARCHAR(128) NOT NULL,
    definition_id   VARCHAR(32) NOT NULL,
    PRIMARY KEY (fitable_id, definition_id)
);

ALTER TABLE flow_context ALTER COLUMN trace_id TYPE TEXT;
ALTER TABLE flow_trace ALTER COLUMN cur_nodes SET DEFAULT 'default_node';
ALTER TABLE flow_trace ADD COLUMN IF NOT EXISTS context_pool TEXT;

-- 任务中心相关
CREATE TABLE IF NOT EXISTS task_tag
(
    tag_id VARCHAR(32) PRIMARY KEY,
    name   VARCHAR(64)  NOT NULL,
    tenant VARCHAR(255) NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_NAME_TENANT ON task_tag (name, tenant);

INSERT INTO task_tag(tag_id, name, tenant)
VALUES ('41d00a31a9b34aa39b606d80fc426c2e', '未开始', 'public') ON CONFLICT (tag_id) DO NOTHING;
INSERT INTO task_tag(tag_id, name, tenant)
VALUES ('8d038441b7514f5b99ea18992126cfa8', '进行中', 'public') ON CONFLICT (tag_id) DO NOTHING;
INSERT INTO task_tag(tag_id, name, tenant)
VALUES ('4c4ddb220bfe4fe98374aff710afb3eb', '已完成', 'public') ON CONFLICT (tag_id) DO NOTHING;
INSERT INTO task_tag(tag_id, name, tenant)
VALUES ('ad31edc774e24bfbb15e87084744e259', '有风险', 'public') ON CONFLICT (tag_id) DO NOTHING;
INSERT INTO task_tag(tag_id, name, tenant)
VALUES ('e72a94b24e704e5abcffc920394f4a19', '无风险', 'public') ON CONFLICT (tag_id) DO NOTHING;


CREATE TABLE IF NOT EXISTS task_source_schedule
(
    id         CHAR(32) PRIMARY KEY,
    fitable_id CHAR(32)     NOT NULL,
    "interval" INTEGER      NOT NULL,
    filter     VARCHAR(512) NOT NULL
);

CREATE TABLE IF NOT EXISTS task_source
(
    id      CHAR(32) PRIMARY KEY,
    task_id CHAR(32)    NOT NULL,
    name    VARCHAR(64) NOT NULL,
    app     VARCHAR(64) NOT NULL,
    type    VARCHAR(32) NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_SOURCE ON task_source (task_id, name, app);
CREATE INDEX IF NOT EXISTS IDX_TASK_SOURCE_TASK ON task_source (task_id);

CREATE TABLE IF NOT EXISTS task_property_trigger
(
    id               CHAR(32) PRIMARY KEY,
    task_source_id   CHAR(32) NOT NULL,
    task_property_id CHAR(32) NOT NULL,
    fitable_id       CHAR(32) NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_PROPERTY_TRIGGER ON task_property_trigger (task_source_id, task_property_id, fitable_id);
CREATE INDEX IF NOT EXISTS IDX_TASK_PROPERTY_TRIGGER_SOURCE ON task_property_trigger (task_source_id);
CREATE INDEX IF NOT EXISTS IDX_TASK_PROPERTY_TRIGGER_PROPERTY ON task_property_trigger (task_property_id);
CREATE INDEX IF NOT EXISTS IDX_TASK_PROPERTY_TRIGGER_FITABLE ON task_property_trigger (fitable_id);

CREATE TABLE IF NOT EXISTS task_property
(
    id           CHAR(32) PRIMARY KEY,
    task_id      CHAR(32)     NOT NULL,
    name         VARCHAR(64)  NOT NULL,
    required     BOOLEAN      NOT NULL,
    identifiable BOOLEAN      NOT NULL,
    description  VARCHAR(512) NOT NULL,
    scope        VARCHAR(16)  NOT NULL,
    data_type    VARCHAR(16)  NOT NULL,
    sequence     INTEGER      NOT NULL,
    appearance   JSON         NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_PROPERTY ON task_property (task_id, name);
CREATE INDEX IF NOT EXISTS IDX_TASK_PROPERTY_TASK ON task_property (task_id);

CREATE TABLE IF NOT EXISTS task
(
    id         CHAR(32) PRIMARY KEY,
    name       VARCHAR(255) NOT NULL,
    tenant_id  CHAR(32)    NOT NULL,
    attributes JSON        NOT NULL DEFAULT '{}',
    created_by VARCHAR(127) NOT NULL,
    created_at TIMESTAMP   NOT NULL,
    updated_by VARCHAR(127) NOT NULL,
    updated_at TIMESTAMP   NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS idx_task_id_name ON task (id, name);

CREATE TABLE IF NOT EXISTS task_instance_wide
(
    id           CHAR(32) PRIMARY KEY,
    task_id      CHAR(32) NOT NULL,
    task_type_id CHAR(32) NOT NULL,
    source_id    CHAR(32) NOT NULL,
    text_1       TEXT,
    text_2       TEXT,
    text_3       TEXT,
    text_4       TEXT,
    text_5       TEXT,
    text_6       TEXT,
    text_7       TEXT,
    text_8       TEXT,
    text_9       TEXT,
    text_10      TEXT,
    text_11      TEXT,
    text_12      TEXT,
    text_13      TEXT,
    text_14      TEXT,
    text_15      TEXT,
    text_16      TEXT,
    text_17      TEXT,
    text_18      TEXT,
    text_19      TEXT,
    text_20      TEXT,
    text_21      TEXT,
    text_22      TEXT,
    text_23      TEXT,
    text_24      TEXT,
    text_25      TEXT,
    text_26      TEXT,
    text_27      TEXT,
    text_28      TEXT,
    text_29      TEXT,
    text_30      TEXT,
    text_31      TEXT,
    text_32      TEXT,
    text_33      TEXT,
    text_34      TEXT,
    text_35      TEXT,
    text_36      TEXT,
    text_37      TEXT,
    text_38      TEXT,
    text_39      TEXT,
    text_40      TEXT,
    text_41      TEXT,
    text_42      TEXT,
    text_43      TEXT,
    text_44      TEXT,
    text_45      TEXT,
    text_46      TEXT,
    text_47      TEXT,
    text_48      TEXT,
    text_49      TEXT,
    text_50      TEXT,
    integer_1    INTEGER,
    integer_2    INTEGER,
    integer_3    INTEGER,
    integer_4    INTEGER,
    integer_5    INTEGER,
    integer_6    INTEGER,
    integer_7    INTEGER,
    integer_8    INTEGER,
    integer_9    INTEGER,
    integer_10   INTEGER,
    integer_11   INTEGER,
    integer_12   INTEGER,
    integer_13   INTEGER,
    integer_14   INTEGER,
    integer_15   INTEGER,
    integer_16   INTEGER,
    integer_17   INTEGER,
    integer_18   INTEGER,
    integer_19   INTEGER,
    integer_20   INTEGER,
    datetime_1   TIMESTAMP,
    datetime_2   TIMESTAMP,
    datetime_3   TIMESTAMP,
    datetime_4   TIMESTAMP,
    datetime_5   TIMESTAMP,
    datetime_6   TIMESTAMP,
    datetime_7   TIMESTAMP,
    datetime_8   TIMESTAMP,
    datetime_9   TIMESTAMP,
    datetime_10  TIMESTAMP,
    datetime_11  TIMESTAMP,
    datetime_12  TIMESTAMP,
    datetime_13  TIMESTAMP,
    datetime_14  TIMESTAMP,
    datetime_15  TIMESTAMP,
    datetime_16  TIMESTAMP,
    datetime_17  TIMESTAMP,
    datetime_18  TIMESTAMP,
    datetime_19  TIMESTAMP,
    datetime_20  TIMESTAMP,
    boolean_1    BOOLEAN,
    boolean_2    BOOLEAN,
    boolean_3    BOOLEAN,
    boolean_4    BOOLEAN,
    boolean_5    BOOLEAN,
    boolean_6    BOOLEAN,
    boolean_7    BOOLEAN,
    boolean_8    BOOLEAN,
    boolean_9    BOOLEAN,
    boolean_10   BOOLEAN,
    boolean_11   BOOLEAN,
    boolean_12   BOOLEAN,
    boolean_13   BOOLEAN,
    boolean_14   BOOLEAN,
    boolean_15   BOOLEAN,
    boolean_16   BOOLEAN,
    boolean_17   BOOLEAN,
    boolean_18   BOOLEAN,
    boolean_19   BOOLEAN,
    boolean_20   BOOLEAN
);

CREATE INDEX IF NOT EXISTS IDX_TASK_INSTANCE_TASK ON task_instance_wide (task_id);
CREATE INDEX IF NOT EXISTS IDX_TASK_INSTANCE_SOURCE ON task_instance_wide (source_id);

CREATE TABLE IF NOT EXISTS task_type
(
    id         CHAR(32) PRIMARY KEY,
    tree_id    CHAR(32)    NOT NULL,
    parent_id  CHAR(32)    NOT NULL,
    name       VARCHAR(255) NOT NULL,
    created_by VARCHAR(127) NOT NULL,
    created_at TIMESTAMP   NOT NULL,
    updated_by VARCHAR(127) NOT NULL,
    updated_at TIMESTAMP   NOT NULL,
    task_id    CHAR(32)
);
CREATE INDEX IF NOT EXISTS IDX_TASK_TYPE_TREE ON task_type (tree_id);
CREATE INDEX IF NOT EXISTS IDX_TASK_TYPE_PARENT ON task_type (parent_id);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_TYPE_NAME ON task_type (task_id, name);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_TYPE_TREE_NAME ON task_type (tree_id, name);

CREATE TABLE IF NOT EXISTS tag
(
    id          CHAR(32) PRIMARY KEY,
    name        VARCHAR(64)  NOT NULL,
    description VARCHAR(512) NOT NULL,
    created_by  VARCHAR(127)  NOT NULL,
    created_at  TIMESTAMP    NOT NULL,
    updated_by  VARCHAR(127)  NOT NULL,
    updated_at  TIMESTAMP    NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TAG ON tag (name);

CREATE TABLE IF NOT EXISTS tag_usage
(
    id          CHAR(32) PRIMARY KEY,
    tag_id      CHAR(32)    NOT NULL,
    object_type VARCHAR(16) NOT NULL,
    object_id   CHAR(32)    NOT NULL,
    created_by  VARCHAR(127) NOT NULL,
    created_at  TIMESTAMP   NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TAG_USAGE ON tag_usage (tag_id, object_id, object_type);
CREATE INDEX IF NOT EXISTS IDX_TAG_OBJECT_ID ON tag_usage (object_id);

CREATE TABLE IF NOT EXISTS task_category_trigger
(
    "id"          CHAR(32) PRIMARY KEY,
    "task_id"     CHAR(32) NOT NULL,
    "category_id" CHAR(32) NOT NULL,
    "fitable_id"  CHAR(32) NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS "UK_TASK_CATEGORY_TRIGGER" ON task_category_trigger ("task_id", "category_id", "fitable_id");
CREATE INDEX IF NOT EXISTS "IDX_TASK_CATEGORY_TRIGGER_TASK" ON task_category_trigger ("task_id");

CREATE TABLE IF NOT EXISTS category_group
(
    id          CHAR(32) PRIMARY KEY,
    name        VARCHAR(64)  NOT NULL,
    description VARCHAR(512) NOT NULL,
    created_by  VARCHAR(127)  NOT NULL,
    created_at  TIMESTAMP    NOT NULL,
    updated_by  VARCHAR(127)  NOT NULL,
    updated_at  TIMESTAMP    NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_CATEGORY_GROUP_NAME ON category_group (name);

CREATE TABLE IF NOT EXISTS category
(
    id                CHAR(32) PRIMARY KEY,
    category_group_id CHAR(32)     NOT NULL,
    name              VARCHAR(64)  NOT NULL,
    description       VARCHAR(512) NOT NULL,
    created_by        VARCHAR(127)  NOT NULL,
    created_at        TIMESTAMP    NOT NULL,
    updated_by        VARCHAR(127)  NOT NULL,
    updated_at        TIMESTAMP    NOT NULL
);
comment on table category is '类目';
comment on column category.id is '表示类目的唯一标识。由32位16进制字符组成。';
comment on column category.category_group_id is '表示类目组的唯一标识。';
comment on column category.name is '表示类目的名称类型。';
comment on column category.description is '表示类目的描述信息。';
comment on column category.created_by is '表示创建人。';
comment on column category.created_at is '表示创建时间。';
comment on column category.updated_by is '表示最近的修改人。未被修改时与创建人相同。';
comment on column category.updated_at is '表示最近的修改时间。未被修改时与创建时间相同。';

CREATE INDEX IF NOT EXISTS IDX_CATEGORY_GROUP ON category (category_group_id);
CREATE UNIQUE INDEX IF NOT EXISTS UK_CATEGORY_NAME ON category (name);

CREATE TABLE IF NOT EXISTS category_matcher
(
    id          CHAR(32) PRIMARY KEY,
    category_id CHAR(32) NOT NULL,
    property_id CHAR(32) NOT NULL,
    "value"     TEXT     NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_CATEGORY_MATCHER ON category_matcher (category_id, property_id, "value");
CREATE INDEX IF NOT EXISTS IDX_CATEGORY_MATCHER_CATEGORY ON category_matcher (category_id);
CREATE INDEX IF NOT EXISTS IDX_CATEGORY_MATCHER_PROPERTY ON category_matcher (property_id);

CREATE TABLE IF NOT EXISTS task_instance_event (
                                     id CHAR(32) PRIMARY KEY,
                                     source_id CHAR(32) NOT NULL,
                                     event_type VARCHAR(16) NOT NULL,
                                     fitable_id CHAR(32) NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_INSTANCE_EVENT ON task_instance_event(source_id, event_type, fitable_id);
CREATE INDEX IF NOT EXISTS IDX_TASK_INSTANCE_EVENT_SOURCE ON task_instance_event(source_id);

CREATE TABLE IF NOT EXISTS tenant
(
    id          CHAR(32) PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    description TEXT,
    avatar_id   CHAR(32),
    created_by  VARCHAR(127) NOT NULL,
    updated_by  VARCHAR(127),
    created_at  timestamp without time zone NOT NULL,
    updated_at  timestamp without time zone
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TENANT ON tenant (name);

CREATE TABLE IF NOT EXISTS tenant_member
(
    id         CHAR(32) PRIMARY KEY,
    tenant_id  CHAR(32)     NOT NULL,
    user_id    VARCHAR(127) NOT NULL,
    created_by VARCHAR(127) NOT NULL,
    created_at timestamp without time zone NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TENANT_ID_USER_ID ON tenant_member (tenant_id, user_id);
CREATE INDEX IF NOT EXISTS IDX_TENANT_ID_TENANT_MEMBER ON tenant_member (tenant_id);

CREATE TABLE IF NOT EXISTS file
(
    id         CHAR(32) PRIMARY KEY,
    name       VARCHAR(127) NOT NULL,
    content    BYTEA        NOT NULL,
    created_by VARCHAR(127) NOT NULL,
    created_at timestamp without time zone NOT NULL
);

CREATE
OR REPLACE FUNCTION generate_uuid_text()
RETURNS CHAR(32) AS $$
BEGIN
RETURN md5(random()::text || clock_timestamp()::text);
END;
$$
LANGUAGE plpgsql;

CREATE
OR REPLACE FUNCTION now_utc()
RETURNS TIMESTAMP AS $$
BEGIN
RETURN CURRENT_TIMESTAMP AT TIME ZONE 'UTC';
END;
$$
LANGUAGE plpgsql;

INSERT INTO category_group(id, name, description, created_by, created_at, updated_by, updated_at)
VALUES (generate_uuid_text(), 'status', '表示系统级别的状态定义。', 'admin', now_utc(), 'admin', now_utc()),
       (generate_uuid_text(), 'health', '表示系统级别的健康度定义。', 'admin', now_utc(), 'admin', now_utc()) ON CONFLICT (name) DO NOTHING;

INSERT INTO category(id, category_group_id, name, description, created_by, created_at, updated_by,
                     updated_at)
VALUES (generate_uuid_text(), (SELECT id FROM category_group WHERE name = 'status'), '未开始',
        '表示任务尚未开始处理。', 'admin', now_utc(), 'admin', now_utc()),
       (generate_uuid_text(), (SELECT id FROM category_group WHERE name = 'status'), '处理中',
        '表示任务正在处理中。', 'admin', now_utc(), 'admin', now_utc()),
       (generate_uuid_text(), (SELECT id FROM category_group WHERE name = 'status'), '已完成',
        '表示任务已闭环完成。', 'admin', now_utc(), 'admin', now_utc()),
       (generate_uuid_text(), (SELECT id FROM category_group WHERE name = 'health'), '无风险',
        '表示当前任务的进展不存在风险。', 'admin', now_utc(), 'admin', now_utc()),
       (generate_uuid_text(), (SELECT id FROM category_group WHERE name = 'health'), '风险',
        '表示当前任务存在风险。', 'admin', now_utc(), 'admin', now_utc()) ON CONFLICT (name) DO NOTHING;

CREATE TABLE IF NOT EXISTS task_tree_task
(
    id      CHAR(32) PRIMARY KEY,
    tree_id CHAR(32) NOT NULL,
    task_id CHAR(32) NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_TREE_TASK_TREE_TASK ON task_tree_task (tree_id, task_id);
CREATE INDEX IF NOT EXISTS IDX_TASK_TREE_TASK_TREE ON task_tree_task (tree_id);
CREATE INDEX IF NOT EXISTS IDX_TASK_TREE_TASK_TASK ON task_tree_task (task_id);

CREATE TABLE IF NOT EXISTS task_tree_v2
(
    id         char(32) PRIMARY KEY,
    name       varchar(64)  NOT NULL,
    created_by varchar(127)  NOT NULL,
    created_at timestamp(6) NOT NULL,
    updated_by varchar(127)  NOT NULL,
    updated_at timestamp(6) NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_TREE_NAME ON task_tree_v2 (name);

CREATE TABLE IF NOT EXISTS task_node_source
(
    id         CHAR(32) PRIMARY KEY,
    node_id    CHAR(32)    NOT NULL,
    source_id  CHAR(32)    NOT NULL,
    created_by VARCHAR(127) NOT NULL,
    created_at TIMESTAMP   NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_NODE_SOURCE ON task_node_source (node_id, source_id);
CREATE INDEX IF NOT EXISTS IDX_TASK_NODE_SOURCE_NODE ON task_node_source (node_id);
CREATE INDEX IF NOT EXISTS IDX_TASK_NODE_SOURCE_SOURCE ON task_node_source (source_id);

CREATE TABLE IF NOT EXISTS "index"
(
    "id" char(32) COLLATE "pg_catalog"."default" NOT NULL,
    "task_id" char(32) COLLATE "pg_catalog"."default" NOT NULL,
    "name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
    "created_by" varchar(127) COLLATE "pg_catalog"."default" NOT NULL,
    "created_at" timestamp(6) NOT NULL,
    "updated_by" varchar(127) COLLATE "pg_catalog"."default" NOT NULL,
    "updated_at" timestamp(6) NOT NULL,
    PRIMARY KEY ("id")
)
;

CREATE TABLE IF NOT EXISTS task_instance_deleted
(
    id           CHAR(32) PRIMARY KEY,
    task_id      CHAR(32) NOT NULL,
    task_type_id CHAR(32) NOT NULL,
    source_id    CHAR(32) NOT NULL,
    text_1       TEXT,
    text_2       TEXT,
    text_3       TEXT,
    text_4       TEXT,
    text_5       TEXT,
    text_6       TEXT,
    text_7       TEXT,
    text_8       TEXT,
    text_9       TEXT,
    text_10      TEXT,
    text_11      TEXT,
    text_12      TEXT,
    text_13      TEXT,
    text_14      TEXT,
    text_15      TEXT,
    text_16      TEXT,
    text_17      TEXT,
    text_18      TEXT,
    text_19      TEXT,
    text_20      TEXT,
    text_21      TEXT,
    text_22      TEXT,
    text_23      TEXT,
    text_24      TEXT,
    text_25      TEXT,
    text_26      TEXT,
    text_27      TEXT,
    text_28      TEXT,
    text_29      TEXT,
    text_30      TEXT,
    text_31      TEXT,
    text_32      TEXT,
    text_33      TEXT,
    text_34      TEXT,
    text_35      TEXT,
    text_36      TEXT,
    text_37      TEXT,
    text_38      TEXT,
    text_39      TEXT,
    text_40      TEXT,
    text_41      TEXT,
    text_42      TEXT,
    text_43      TEXT,
    text_44      TEXT,
    text_45      TEXT,
    text_46      TEXT,
    text_47      TEXT,
    text_48      TEXT,
    text_49      TEXT,
    text_50      TEXT,
    integer_1    INTEGER,
    integer_2    INTEGER,
    integer_3    INTEGER,
    integer_4    INTEGER,
    integer_5    INTEGER,
    integer_6    INTEGER,
    integer_7    INTEGER,
    integer_8    INTEGER,
    integer_9    INTEGER,
    integer_10   INTEGER,
    integer_11   INTEGER,
    integer_12   INTEGER,
    integer_13   INTEGER,
    integer_14   INTEGER,
    integer_15   INTEGER,
    integer_16   INTEGER,
    integer_17   INTEGER,
    integer_18   INTEGER,
    integer_19   INTEGER,
    integer_20   INTEGER,
    datetime_1   TIMESTAMP,
    datetime_2   TIMESTAMP,
    datetime_3   TIMESTAMP,
    datetime_4   TIMESTAMP,
    datetime_5   TIMESTAMP,
    datetime_6   TIMESTAMP,
    datetime_7   TIMESTAMP,
    datetime_8   TIMESTAMP,
    datetime_9   TIMESTAMP,
    datetime_10  TIMESTAMP,
    datetime_11  TIMESTAMP,
    datetime_12  TIMESTAMP,
    datetime_13  TIMESTAMP,
    datetime_14  TIMESTAMP,
    datetime_15  TIMESTAMP,
    datetime_16  TIMESTAMP,
    datetime_17  TIMESTAMP,
    datetime_18  TIMESTAMP,
    datetime_19  TIMESTAMP,
    datetime_20  TIMESTAMP,
    boolean_1    BOOLEAN,
    boolean_2    BOOLEAN,
    boolean_3    BOOLEAN,
    boolean_4    BOOLEAN,
    boolean_5    BOOLEAN,
    boolean_6    BOOLEAN,
    boolean_7    BOOLEAN,
    boolean_8    BOOLEAN,
    boolean_9    BOOLEAN,
    boolean_10   BOOLEAN,
    boolean_11   BOOLEAN,
    boolean_12   BOOLEAN,
    boolean_13   BOOLEAN,
    boolean_14   BOOLEAN,
    boolean_15   BOOLEAN,
    boolean_16   BOOLEAN,
    boolean_17   BOOLEAN,
    boolean_18   BOOLEAN,
    boolean_19   BOOLEAN,
    boolean_20   BOOLEAN
    );

CREATE TABLE IF NOT EXISTS operation_record
(
    id            char(32) PRIMARY KEY,
    object_type   varchar(25)  NOT NULL,
    object_id     char(32)     NOT NULL,
    operator      varchar(127) NOT NULL,
    operated_time timestamp without time zone,
    message       TEXT         NOT NULL,
    operate       char(7)      NOT NULL
    );

CREATE TABLE IF NOT EXISTS flow_retry
(
    entity_id       VARCHAR(32) NOT NULL,
    entity_type     VARCHAR(32) NOT NULL,
    next_retry_time timestamp without time zone NOT NULL,
    last_retry_time timestamp without time zone,
    retry_count     INTEGER NOT NULL,
    version         INTEGER NOT NULL,
    PRIMARY KEY (entity_id)
    );

comment on table flow_retry is '流程节点执行异常重试记录';
comment on column flow_retry.entity_id is '表示任务重试的上下文实体ID';
comment on column flow_retry.entity_type is '表示任务重试的上下文实体类型';
comment on column flow_retry.next_retry_time is '表示任务重试的下次时间';
comment on column flow_retry.last_retry_time is '表示上次执行的任务重试时间';
comment on column flow_retry.retry_count is '表示到目前为止的任务重试次数';
comment on column flow_retry.version is '表示当前重试的版本号';

CREATE TABLE IF NOT EXISTS flow_lock
(
    lock_key VARCHAR(100) NOT NULL PRIMARY KEY,
    expired_at timestamp without time zone,
    locked_client VARCHAR(50)
    );

comment on table flow_lock is '流程锁';
comment on column flow_lock.lock_key is '锁名称';
comment on column flow_lock.expired_at is '锁过期时间';
comment on column flow_lock.locked_client is '上锁的客户端IP';

ALTER TABLE task ADD COLUMN IF NOT EXISTS template_id CHAR(32) NOT NULL DEFAULT '00000000000000000000000000000000';
ALTER TABLE task ADD COLUMN IF NOT EXISTS category VARCHAR(32) NOT NULL DEFAULT 'TASK';
ALTER TABLE file ADD COLUMN IF NOT EXISTS type VARCHAR(32);
ALTER TABLE task_property ADD COLUMN IF NOT EXISTS template_id CHAR(32) NOT NULL DEFAULT '00000000000000000000000000000000';
ALTER TABLE tenant ADD COLUMN IF NOT EXISTS access_level VARCHAR(32);


CREATE TABLE IF NOT EXISTS task_source_refresh_in_time (
    id CHAR(32) PRIMARY KEY,
    metadata JSONB NOT NULL,
    create_fitable_id CHAR(32) NOT NULL,
    patch_fitable_id CHAR(32) NOT NULL,
    delete_fitable_id CHAR(32) NOT NULL,
    retrieve_fitable_id CHAR(32) NOT NULL,
    list_fitable_id CHAR(32) NOT NULL
    );

CREATE TABLE IF NOT EXISTS "category_usage" (
    "id" CHAR(32) PRIMARY KEY,
    "object_type" VARCHAR(16) NOT NULL,
    "object_id" CHAR(32) NOT NULL,
    "category_group_id" CHAR(32) NOT NULL,
    "category_id" CHAR(32) NOT NULL,
    "created_by" VARCHAR(127) NOT NULL,
    "created_at" TIMESTAMP NOT NULL,
    "updated_by" VARCHAR(127) NOT NULL,
    "updated_at" TIMESTAMP NOT NULL
    );
CREATE UNIQUE INDEX IF NOT EXISTS "UK_CATEGORY_USAGE" ON "category_usage"("object_id", "category_group_id", "object_type");
CREATE INDEX IF NOT EXISTS "IDX_CATEGORY_USAGE_OBJECT_ID" ON "category_usage"("object_id");

/* 创建任务模板表 */
CREATE TABLE IF NOT EXISTS task_template
(
    id          CHAR(32) PRIMARY KEY,
    name        VARCHAR(255)  NOT NULL,
    description VARCHAR(512) NOT NULL,
    "tenant_id" char(32) NOT NULL DEFAULT '00000000000000000000000000000000'
    );
CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_TEMPLATE_NAME ON task_template (name);
COMMENT on column task_template.id is '主键Id';
COMMENT on column task_template.name is '任务模板名称';
COMMENT on column task_template.description is '任务模板描述';

/* 创建任务模板属性表 */
CREATE TABLE IF NOT EXISTS task_template_property
(
    id               CHAR(32) PRIMARY KEY,
    task_template_id CHAR(32)    NOT NULL,
    name             VARCHAR(64) NOT NULL,
    data_type        VARCHAR(16) NOT NULL,
    sequence         INTEGER     NOT NULL
    );
CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_TEMPLATE_PROPERTY_NAME ON task_template_property (task_template_id, name);
CREATE UNIQUE INDEX IF NOT EXISTS UK_TASK_TEMPLATE_PROPERTY_COLUMN ON task_template_property (task_template_id, data_type, sequence);

COMMENT on column task_template_property.id is '主键Id';
COMMENT on column task_template_property.task_template_id is '任务模板Id';
COMMENT on column task_template_property.name is '任务模板属性名称';
COMMENT on column task_template_property.data_type is '任务模板属性数据类型';
COMMENT on column task_template_property.sequence is '任务模板属性在当前数据类型中的序号';

CREATE TABLE IF NOT EXISTS "index" (
                         "id" CHAR(32) PRIMARY KEY,
                         "task_id" CHAR(32) NOT NULL,
                         "name" VARCHAR(128) NOT NULL,
                         "created_by" VARCHAR(127) NOT NULL,
                         "created_at" TIMESTAMP NOT NULL,
                         "updated_by" VARCHAR(127) NOT NULL,
                         "updated_at" TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS "index_property" (
                                  "id" CHAR(32) PRIMARY KEY,
                                  "index_id" CHAR(32) NOT NULL,
                                  "property_id" CHAR(32) NOT NULL
);
CREATE INDEX IF NOT EXISTS "idx_index_property_index" ON "index_property"("index_id");

CREATE TABLE IF NOT EXISTS "index_text" (
                              "id" CHAR(32) PRIMARY KEY,
                              "instance_id" CHAR(32) NOT NULL,
                              "property_id" CHAR(32) NOT NULL,
                              "value" TEXT
);
CREATE INDEX IF NOT EXISTS "idx_index_text_instance" ON "index_text"("instance_id");
CREATE INDEX IF NOT EXISTS "idx_index_text_property" ON "index_text"("property_id");
CREATE INDEX IF NOT EXISTS "idx_index_text_value" ON "index_text"("value");

CREATE TABLE IF NOT EXISTS "index_integer" (
                                 "id" CHAR(32) PRIMARY KEY,
                                 "instance_id" CHAR(32) NOT NULL,
                                 "property_id" CHAR(32) NOT NULL,
                                 "value" BIGINT
);
CREATE INDEX IF NOT EXISTS "idx_index_integer_instance" ON "index_integer"("instance_id");
CREATE INDEX IF NOT EXISTS "idx_index_integer_property" ON "index_integer"("property_id");
CREATE INDEX IF NOT EXISTS "idx_index_integer_value" ON "index_integer"("value");

CREATE TABLE IF NOT EXISTS "index_datetime" (
                                  "id" CHAR(32) PRIMARY KEY,
                                  "instance_id" CHAR(32) NOT NULL,
                                  "property_id" CHAR(32) NOT NULL,
                                  "value" TIMESTAMP
);
CREATE INDEX IF NOT EXISTS "idx_index_datetime_instance" ON "index_datetime"("instance_id");
CREATE INDEX IF NOT EXISTS "idx_index_datetime_property" ON "index_datetime"("property_id");
CREATE INDEX IF NOT EXISTS "idx_index_datetime_value" ON "index_datetime"("value");

CREATE TABLE IF NOT EXISTS "list_text" (
                             "id" CHAR(32) PRIMARY KEY,
                             "instance_id" CHAR(32) NOT NULL,
                             "property_id" CHAR(32) NOT NULL,
                             "index" BIGINT NOT NULL,
                             "value" TEXT
);
CREATE INDEX IF NOT EXISTS "IDX_LIST_TEXT_INSTANCE" ON "list_text"("instance_id");
CREATE INDEX IF NOT EXISTS "IDX_LIST_TEXT_PROPERTY" ON "list_text"("property_id");

-- 任务关联表
CREATE TABLE IF NOT EXISTS jane_relation (
    id CHAR(32) PRIMARY KEY,
    object_id1 CHAR(32) NOT NULL,
    object_type1 VARCHAR(16) NOT NULL,
    object_id2 CHAR(32) NOT NULL,
    object_type2 VARCHAR(16) NOT NULL,
    relation_type VARCHAR(16) NOT NULL,
    created_by VARCHAR(127) NOT NULL,
    created_at TIMESTAMP NOT NULL
    );
CREATE INDEX IF NOT EXISTS IDX_JANE_RELATION_OBJECT_ID1 ON jane_relation(object_id1);
CREATE INDEX IF NOT EXISTS IDX_JANE_RELATION_OBJECT_ID2 ON jane_relation(object_id2);
CREATE UNIQUE INDEX IF NOT EXISTS UK_IDX_JANE_RELATION_OBJECT_ID1_OBJECT_ID2 ON jane_relation(object_id1,object_id2);

--模板继承表
CREATE TABLE IF NOT EXISTS extend_table
(
    id    VARCHAR(32) PRIMARY KEY,
    parent_id  VARCHAR(32) NOT NULL
    );

--根据子任务查询所有父任务的id
CREATE OR REPLACE FUNCTION find_template_parents(input_id varchar)
  RETURNS TABLE(template_parents_id varchar) AS $BODY$
BEGIN
RETURN QUERY WITH RECURSIVE dump_parents(id, parent_id) AS (
		SELECT id, parent_id FROM extend_table WHERE id = input_id
		UNION ALL
		SELECT p.id, p.parent_id FROM dump_parents AS c, extend_table AS p WHERE c.parent_id = p.id
		)
SELECT input_id
UNION ALL
SELECT parent_id FROM dump_parents WHERE parent_id IS NOT NULL
                                     AND parent_id != '00000000000000000000000000000000';
RETURN;
END;
  $BODY$
LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

--根据父任务查询所有子任务的id
CREATE OR REPLACE FUNCTION find_template_children(input_id varchar)
  RETURNS TABLE(children_template_id varchar) AS $BODY$
BEGIN
RETURN QUERY WITH RECURSIVE dump_children(id) AS (
          SELECT id FROM extend_table WHERE parent_id = input_id
          UNION ALL
          SELECT c.id FROM dump_children AS p, extend_table AS c WHERE c.parent_id = p.id
            )
SELECT input_id
UNION ALL
SELECT id FROM dump_children;
RETURN;
END;
  $BODY$
LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

CREATE TABLE IF NOT EXISTS flow_graph
(
    id               VARCHAR(32) NOT NULL,
    version          VARCHAR(16) NOT NULL,
    tenant           VARCHAR(32) NOT NULL,
    status           VARCHAR(32) NOT NULL,
    name             VARCHAR(256),
    data             TEXT,
    created_by       VARCHAR(32) NOT NULL,
    created_at       timestamp without time zone NOT NULL,
    updated_by       VARCHAR(32) NOT NULL,
    updated_at       timestamp without time zone NOT NULL,
    previous         VARCHAR(50),
    is_deleted       BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id, version)
    );

DROP INDEX IF EXISTS task_template_name_idx;
CREATE UNIQUE INDEX IF NOT EXISTS task_template_name_tenant_idx ON task_template ("name","tenant_id");