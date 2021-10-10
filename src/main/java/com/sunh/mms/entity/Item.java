package com.sunh.mms.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author ${author}
 * @since 2021-10-10
 */
public class Item extends Model<Item> {

    private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 名称
     */
    private String name;

    /**
     * 数量
     */
    private Integer num;

    /**
     * 描述
     */
    private String description;


    public Long getId() {
        return id;
    }

    public Item setId(Long id) {
        this.id = id;
        return this;
    }

    public String getName() {
        return name;
    }

    public Item setName(String name) {
        this.name = name;
        return this;
    }

    public Integer getNum() {
        return num;
    }

    public Item setNum(Integer num) {
        this.num = num;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public Item setDescription(String description) {
        this.description = description;
        return this;
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

    @Override
    public String toString() {
        return "Item{" +
        "id=" + id +
        ", name=" + name +
        ", num=" + num +
        ", description=" + description +
        "}";
    }
}
