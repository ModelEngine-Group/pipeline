/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.operater.log.stub;

import modelengine.fitframework.util.StringUtils;

import io.opentelemetry.api.common.AttributeKey;
import io.opentelemetry.api.common.Attributes;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.SpanContext;
import io.opentelemetry.api.trace.SpanKind;
import io.opentelemetry.api.trace.StatusCode;
import io.opentelemetry.sdk.common.InstrumentationLibraryInfo;
import io.opentelemetry.sdk.internal.AttributesMap;
import io.opentelemetry.sdk.resources.Resource;
import io.opentelemetry.sdk.trace.ReadableSpan;
import io.opentelemetry.sdk.trace.data.EventData;
import io.opentelemetry.sdk.trace.data.LinkData;
import io.opentelemetry.sdk.trace.data.SpanData;
import io.opentelemetry.sdk.trace.data.StatusData;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 表示 {@link Span} 的打桩。
 *
 * @author 易文渊
 * @since 2024-11-20
 */
public class SpanStub implements Span, ReadableSpan {
    private final AttributesMap attributes = AttributesMap.create(1024, 1024);
    private String name = StringUtils.EMPTY;
    private final SpanData spanData;

    public SpanStub() {
        this.spanData = new SpanDataStub();
    }

    public <T> T getAttribute(AttributeKey<T> key) {
        return this.attributes.get(key);
    }

    @Override
    public <T> Span setAttribute(AttributeKey<T> key, T value) {
        this.attributes.put(key, value);
        return this;
    }

    @Override
    public Span addEvent(String name, Attributes attributes) {
        return this;
    }

    @Override
    public Span addEvent(String name, Attributes attributes, long timestamp, TimeUnit unit) {
        return this;
    }

    @Override
    public Span setStatus(StatusCode statusCode, String description) {
        return this;
    }

    @Override
    public Span recordException(Throwable exception, Attributes additionalAttributes) {
        return this;
    }

    @Override
    public Span updateName(String name) {
        this.name = name;
        return this;
    }

    @Override
    public void end() {

    }

    @Override
    public void end(long timestamp, TimeUnit unit) {

    }

    @Override
    public SpanContext getSpanContext() {
        return null;
    }

    @Override
    public SpanContext getParentSpanContext() {
        return null;
    }

    @Override
    public String getName() {
        return null;
    }

    @Override
    public SpanData toSpanData() {
        return this.spanData;
    }

    @Override
    public InstrumentationLibraryInfo getInstrumentationLibraryInfo() {
        return null;
    }

    @Override
    public boolean hasEnded() {
        return false;
    }

    @Override
    public long getLatencyNanos() {
        return 0;
    }

    @Override
    public SpanKind getKind() {
        return null;
    }

    @Override
    public boolean isRecording() {
        return false;
    }

    private class SpanDataStub implements SpanData {

        @Override
        public String getName() {
            return name;
        }

        @Override
        public SpanKind getKind() {
            return null;
        }

        @Override
        public SpanContext getSpanContext() {
            return null;
        }

        @Override
        public SpanContext getParentSpanContext() {
            return null;
        }

        @Override
        public StatusData getStatus() {
            return StatusData.create(StatusCode.OK, "");
        }

        @Override
        public long getStartEpochNanos() {
            return 1000000;
        }

        @Override
        public Attributes getAttributes() {
            return attributes;
        }

        @Override
        public List<EventData> getEvents() {
            return null;
        }

        @Override
        public List<LinkData> getLinks() {
            return null;
        }

        @Override
        public long getEndEpochNanos() {
            return 0;
        }

        @Override
        public boolean hasEnded() {
            return false;
        }

        @Override
        public int getTotalRecordedEvents() {
            return 0;
        }

        @Override
        public int getTotalRecordedLinks() {
            return 0;
        }

        @Override
        public int getTotalAttributeCount() {
            return 0;
        }

        @Override
        public InstrumentationLibraryInfo getInstrumentationLibraryInfo() {
            return null;
        }

        @Override
        public Resource getResource() {
            return null;
        }
    }
}