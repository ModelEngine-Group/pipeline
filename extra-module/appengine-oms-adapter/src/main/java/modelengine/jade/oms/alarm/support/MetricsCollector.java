/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.alarm.support;

import modelengine.fitframework.annotation.Component;
import modelengine.fitframework.log.Logger;
import modelengine.jade.oms.alarm.util.Constants;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 表示监控指标收集器。
 *
 * @author 何嘉斌
 * @since 2024-12-05
 */
@Component
public class MetricsCollector {
    private static final Logger log = Logger.get(MetricsCollector.class);

    private final Runtime runtime;

    public MetricsCollector() {
        this.runtime = Runtime.getRuntime();
    }

    private List<String> executeCommand(String command) throws IOException {
        List<String> lines = new ArrayList<>();
        Process process = runtime.exec(command);
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream(),
                StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                lines.add(line);
            }
        }
        return lines;
    }

    /**
     * 获取文件系统存储使用率。
     *
     * @return 表示 PVC 挂载路径与 usage 键值表的 {@link Map}{@code <}{@link String}{@code , }{@link Integer}{@code >}。
     */
    public Map<String, Integer> getStorageUsage() {
        HashMap<String, Integer> fileSystemUsage = new HashMap<>();
        try {
            List<String> lines = executeCommand(Constants.LIST_USAGE_COMMAND);
            lines.forEach(line -> {
                String[] tokens = line.split(Constants.SPACE_REGEX);
                if (tokens.length != Constants.USAGE_COMMAND_OUTPUT_LENGTH) {
                    return;
                }
                int usage = Integer.parseInt(tokens[4].replace("%", ""));
                fileSystemUsage.put(tokens[5], usage);
            });
            return fileSystemUsage;
        } catch (IOException ex) {
            log.error("Failed to obtain the file system usage.", ex);
            return Collections.emptyMap();
        }
    }
}