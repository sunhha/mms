package com.sunh.mms.service.impl;

import com.sunh.mms.entity.Item;
import com.sunh.mms.dao.ItemMapper;
import com.sunh.mms.service.IItemService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2021-10-10
 */
@Service
public class ItemServiceImpl extends ServiceImpl<ItemMapper, Item> implements IItemService {

}
