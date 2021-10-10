package com.sunh.mms.dao;

import com.sunh.mms.entity.ItemOpt;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2021-10-10
 */
@Component
public interface ItemOptMapper extends BaseMapper<ItemOpt> {

    List<Map<String,Object>> optRecord(@Param("name") String name);

}
