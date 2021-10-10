package com.sunh.mms.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sunh.mms.dto.MyPageInfo;
import com.sunh.mms.dto.OptResult;
import com.sunh.mms.entity.Item;
import com.sunh.mms.entity.ItemOpt;
import com.sunh.mms.service.IItemOptService;
import com.sunh.mms.service.IItemService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RequestMapping("/")
@Controller
public class MainViewController {

    @Autowired
    private IItemService itemService;

    @Autowired
    private IItemOptService itemOptService;

    @RequestMapping(value = {"/main", "index.html"})
    public ModelAndView mainPage(ModelAndView modelAndView) {
        modelAndView.setViewName("/main");
        return modelAndView;
    }

    @RequestMapping(value = {"/optRecord", "optRecord.html"})
    public ModelAndView optRecordPage(ModelAndView modelAndView) {
        modelAndView.setViewName("/optRecord");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping(value = "/item/data")
    public MyPageInfo<Item> itemData(
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "pageNumber", required = false, defaultValue = "1") int pageNo,
            @RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize) {
        QueryWrapper<Item> queryWrapper = new QueryWrapper<>();
        queryWrapper.clear();
        queryWrapper.lambda()
                .like(!StringUtils.isEmpty(name), Item::getName, name);
        PageInfo<Item> pageInfo = PageHelper.startPage(pageNo, pageSize).doSelectPageInfo(() -> {
            itemService.list(queryWrapper);
        });
        return convertPage(pageInfo);
    }

    @Transactional
    @ResponseBody
    @RequestMapping(value = "/item/add")
    public OptResult itemAdd(@RequestParam String name,
                             @RequestParam Integer num,
                             @RequestParam String description) {
        OptResult optResult = new OptResult();
        try {
            QueryWrapper<Item> queryWrapper = new QueryWrapper<>();
            queryWrapper.clear();
            queryWrapper.lambda()
                    .eq(Item::getName,name);
            List<Item> list = itemService.list(queryWrapper);
            if(!CollectionUtils.isEmpty(list)){
                optResult.setSuccess(false);
                optResult.setErrorDesc("名称已存在");
                return optResult;
            }

            Item item = new Item();
            item.setName(name);
            item.setNum(num);
            item.setDescription(description);
            itemService.save(item);

            ItemOpt itemOpt = new ItemOpt();
            itemOpt.setItemId(item.getId());
            itemOpt.setNum(num);
            itemOpt.setType(1);
            itemOpt.setRemark("首次入库");
            itemOpt.setOptTime(LocalDateTime.now());
            itemOptService.save(itemOpt);

            optResult.setSuccess(true);
        } catch (Exception e) {
            optResult.setSuccess(false);
            optResult.setErrorDesc("系统出错");
            e.printStackTrace();
        }
        return optResult;
    }

    @Transactional
    @ResponseBody
    @RequestMapping(value = "/item/opt")
    public OptResult itemOpt(@RequestParam Integer id,
                             @RequestParam(required = false) Integer num,
                             @RequestParam(required = false) String remark,
                             @RequestParam Integer type) {
        OptResult optResult = new OptResult();
        try {
            Item item = itemService.getById(id);
            if (-1 != type) {
                if(null == num){
                    optResult.setSuccess(false);
                    optResult.setErrorDesc("请填写数量");
                    return optResult;
                }
                if (1 == type) {
                    //入库
                    int numNow = item.getNum() + num;
                    item.setNum(numNow);
                } else if (2 == type) {
                    //出库
                    int numNow = item.getNum() - num;
                    item.setNum(numNow);
                }
                itemService.updateById(item);
                ItemOpt itemOpt = new ItemOpt();
                itemOpt.setItemId(id.longValue());
                itemOpt.setNum(num);
                itemOpt.setType(type);
                itemOpt.setRemark(remark);
                itemOpt.setOptTime(LocalDateTime.now());
                itemOptService.save(itemOpt);
            } else {
                //删除
                itemService.removeById(id);
            }
            optResult.setSuccess(true);
        } catch (Exception e) {
            optResult.setSuccess(false);
            optResult.setErrorDesc("系统出错");
            e.printStackTrace();
        }
        return optResult;
    }

    @ResponseBody
    @RequestMapping(value = "/itemOpt/data")
    public MyPageInfo<Map<String,Object>> itemOptData(
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "pageNumber", required = false, defaultValue = "1") int pageNo,
            @RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize) {
        PageInfo<Map<String,Object>> pageInfo = PageHelper.startPage(pageNo, pageSize).doSelectPageInfo(() -> {
            itemOptService.optRecord(name);
        });
        return convertPage(pageInfo);
    }

    private <T> MyPageInfo<T> convertPage(PageInfo<T> pageInfo) {
        MyPageInfo<T> myPageInfo = new MyPageInfo<>();
        BeanUtils.copyProperties(pageInfo, myPageInfo);
        myPageInfo.setRows(pageInfo.getList());
        return myPageInfo;
    }

}
