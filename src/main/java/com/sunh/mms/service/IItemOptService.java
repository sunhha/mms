package com.sunh.mms.service;

import com.sunh.mms.entity.ItemOpt;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2021-10-10
 */
public interface IItemOptService extends IService<ItemOpt> {

    List<Map<String, Object>> optRecord(String name);
}
