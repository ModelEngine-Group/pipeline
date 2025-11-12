ALTER TABLE app_builder_app
    ALTER COLUMN user_group_id DROP NOT NULL;
ALTER TABLE app_builder_form
    ALTER COLUMN user_group_id DROP NOT NULL;
ALTER TABLE store_plugin
    ALTER COLUMN user_group_id DROP NOT NULL;
ALTER TABLE store_plugin_tool
    ALTER COLUMN user_group_id DROP NOT NULL;
ALTER TABLE store_app
    ALTER COLUMN user_group_id DROP NOT NULL;

-- 增加短链数据
UPDATE store_tool s
SET runnables =
        -- 先提取原APP节点，添加chatPath后，再替换回runnables
        jsonb_set(
                s.runnables::jsonb,
                '{APP}',  -- 直接操作APP节点
                (s.runnables::jsonb -> 'APP') ||  -- 原APP内容
                jsonb_build_object('chatPath', '/chat/' || TRIM(a.path))  -- 新增chatPath
        )
    FROM app_builder_app a
WHERE
    s.unique_name = a.unique_name
  AND jsonb_typeof(s.runnables::jsonb -> 'APP') = 'object'
  AND NOT (s.runnables::jsonb -> 'APP' ? 'chatPath')
  AND a.path IS NOT NULL
  AND TRIM(a.path) <> '';


-- 增加标签数据
INSERT INTO store_tag (
    tool_unique_name,
    name,
    created_time,
    updated_time,
    creator,
    modifier
)
-- 从s表自身查询基础数据，关联a表获取新name
SELECT
    s1.tool_unique_name,  -- 保留原s表的tool_unique_name
    a.app_type AS name,   -- 用a表的app_type替换原name
    s1.created_time,
    s1.updated_time,
    s1.creator,
    s1.modifier
FROM store_tag s1  -- s1代表s表自身，用于获取基础数据
-- 关联a表，通过unique_name和tool_unique_name匹配
         INNER JOIN app_builder_app a
                    ON a.unique_name = s1.tool_unique_name
                        AND a.unique_name IS NOT NULL
                        AND TRIM(a.unique_name) <> ''  -- 原有的非空校验
                        AND a.app_type IS NOT NULL     -- 新增：过滤a.app_type为null的记录
                        AND TRIM(a.app_type) <> ''     -- 新增：过滤a.app_type为空字符串的记录（可选，根据业务需求）
    ON CONFLICT (name, tool_unique_name)  DO NOTHING;

UPDATE "store_definition" SET schema = '{"name":"parallelTool","description":"用于并行执行工具","parameters":{"type":"object","properties":{"toolCalls":{"description":"并行调用的工具列表","name":"toolCalls","type":"array","items":{"type":"object","properties":{"uniqueName":{"type":"string"},"args":{"type":"object"},"outputName":{"type":"string"}}},"required":[]},"config":{"description":"并行调用的配置","name":"config","type":"object","properties":{"concurrency":{"type":"integer"}},"required":[]},"context":{"description":"调用时的上下文信息","name":"context","type":"object","required":[]}},"required":["toolCalls"]},"order":["toolCalls","config","context"],"parameterExtensions":null,"return":{"type":"object","convertor":""}}' WHERE name = 'parallelTool';
UPDATE "store_tool" SET schema = '{"name":"parallelTool","description":"用于并行执行工具","parameters":{"type":"object","properties":{"toolCalls":{"description":"并行调用的工具列表","name":"toolCalls","type":"array","items":{"type":"object","properties":{"uniqueName":{"type":"string"},"args":{"type":"object"},"outputName":{"type":"string"}}},"required":[]},"config":{"description":"并行调用的配置","name":"config","type":"object","properties":{"concurrency":{"type":"integer"}},"required":[]},"context":{"description":"调用时的上下文信息","name":"context","type":"object","required":[]}},"required":["toolCalls"]},"order":["toolCalls","config","context"],"parameterExtensions":null,"return":{"type":"object","convertor":""}}' WHERE unique_name = '1d0c8164-1aea-4264-879f-2c7898d13fb9';

UPDATE "store_definition" SET schema = '{"name":"loopTool","description":"用于循环执行工具","parameters":{"type":"object","properties":{"args":{"description":"循环调用工具时的入参","name":"args","type":"object"},"config":{"description":"循环调用的配置，指定循环的字段","name":"config","type":"object","properties":{"loopKeys":{"type":"array","items":{"type":"string"}}}},"toolInfo":{"description":"循环调用的工具信息","name":"toolInfo","type":"object","properties":{"uniqueName":{"type":"string"},"params":{"type":"array","items":{"type":"object","properties":{"name":{"type":"string"}}}}}},"context":{"description":"循环调用的上下文","name":"context","type":"object","properties":{}}},"required":["args","config","toolInfo"]},"order":["args","config","toolInfo","context"],"parameterExtensions":null,"return":{"type":"array","items":{"type":"object"},"convertor":""}}' WHERE name = 'loopTool';
UPDATE "store_tool" SET schema = '{"name":"loopTool","description":"用于循环执行工具","parameters":{"type":"object","properties":{"args":{"description":"循环调用工具时的入参","name":"args","type":"object"},"config":{"description":"循环调用的配置，指定循环的字段","name":"config","type":"object","properties":{"loopKeys":{"type":"array","items":{"type":"string"}}}},"toolInfo":{"description":"循环调用的工具信息","name":"toolInfo","type":"object","properties":{"uniqueName":{"type":"string"},"params":{"type":"array","items":{"type":"object","properties":{"name":{"type":"string"}}}}}},"context":{"description":"循环调用的上下文","name":"context","type":"object","properties":{}}},"required":["args","config","toolInfo"]},"order":["args","config","toolInfo","context"],"parameterExtensions":null,"return":{"type":"array","items":{"type":"object"},"convertor":""}}' WHERE unique_name = 'ec122366-4fd2-4e6f-b8ec-2c17706432f4';
