package com.sunh.mms.dto;

import com.github.pagehelper.PageInfo;
import lombok.Data;

import java.util.List;

public class MyPageInfo<T> extends PageInfo {
    private List<T> rows;

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }
}
