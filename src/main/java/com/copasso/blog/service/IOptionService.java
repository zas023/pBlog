package com.copasso.blog.service;

import com.copasso.blog.model.Vo.OptionVo;

import java.util.List;
import java.util.Map;

/**
 * 网站选项Service接口
 */
public interface IOptionService {

    void insertOption(OptionVo optionVo);

    void insertOption(String name, String value);

    List<OptionVo> getOptions();


    /**
     * 保存一组配置
     *
     * @param options
     */
    void saveOptions(Map<String, String> options);
}
