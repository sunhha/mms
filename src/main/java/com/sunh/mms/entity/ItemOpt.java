package com.sunh.mms.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author ${author}
 * @since 2021-10-10
 */
public class ItemOpt extends Model<ItemOpt> {

    private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * item_id
     */
    private Long itemId;

    /**
     * 1:入库;2:出库
     */
    private Integer type;

    /**
     * 操作数量
     */
    private Integer num;

    /**
     * 操作时间
     */
    private LocalDateTime optTime;

    /**
     * 备注
     */
    private String remark;


    public Long getId() {
        return id;
    }

    public ItemOpt setId(Long id) {
        this.id = id;
        return this;
    }

    public Long getItemId() {
        return itemId;
    }

    public ItemOpt setItemId(Long itemId) {
        this.itemId = itemId;
        return this;
    }

    public Integer getType() {
        return type;
    }

    public ItemOpt setType(Integer type) {
        this.type = type;
        return this;
    }

    public Integer getNum() {
        return num;
    }

    public ItemOpt setNum(Integer num) {
        this.num = num;
        return this;
    }

    public LocalDateTime getOptTime() {
        return optTime;
    }

    public ItemOpt setOptTime(LocalDateTime optTime) {
        this.optTime = optTime;
        return this;
    }

    public String getRemark() {
        return remark;
    }

    public ItemOpt setRemark(String remark) {
        this.remark = remark;
        return this;
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

    @Override
    public String toString() {
        return "ItemOpt{" +
        "id=" + id +
        ", itemId=" + itemId +
        ", type=" + type +
        ", num=" + num +
        ", optTime=" + optTime +
        ", remark=" + remark +
        "}";
    }
}
