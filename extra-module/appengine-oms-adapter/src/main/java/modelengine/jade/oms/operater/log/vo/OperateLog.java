/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.operater.log.vo;

/**
 * 表示操作日志的实体。
 *
 * @author 易文渊
 * @since 2024-11-19
 */
public class OperateLog {
    /**
     * uuid。
     */
    private long sn;

    /**
     * 用户操作。
     */
    private String operation;

    /**
     * 日志类型 ：operation:操作日志 security 安全日志。
     */
    private String logType;

    /**
     * 用户名。
     */
    private String username;

    /**
     * 功能模块。
     */
    private String source;

    /**
     * 操作系统时间毫秒值。
     */
    private long datetime;

    /**
     * 终端 ip 地址。
     */
    private String terminal;

    /**
     * 操作结果：success, failed。
     */
    private String result;

    /**
     * 预留字段。
     */
    private String flag;

    /**
     * 详情。
     */
    private String detail;

    public long getSn() {
        return sn;
    }

    public void setSn(long sn) {
        this.sn = sn;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }

    public String getLogType() {
        return logType;
    }

    public void setLogType(String logType) {
        this.logType = logType;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public long getDatetime() {
        return datetime;
    }

    public void setDatetime(long datetime) {
        this.datetime = datetime;
    }

    public String getTerminal() {
        return terminal;
    }

    public void setTerminal(String terminal) {
        this.terminal = terminal;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }
}