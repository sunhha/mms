package com.sunh.mms.service.impl;

import com.sunh.mms.entity.ItemOpt;
import com.sunh.mms.dao.ItemOptMapper;
import com.sunh.mms.service.IItemOptService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2021-10-10
 */
@Service
public class ItemOptServiceImpl extends ServiceImpl<ItemOptMapper, ItemOpt> implements IItemOptService {

    @Autowired
    private ItemOptMapper itemOptMapper;

    @Override
    public List<Map<String, Object>> optRecord(String name) {
        return itemOptMapper.optRecord(name);
    }
}
