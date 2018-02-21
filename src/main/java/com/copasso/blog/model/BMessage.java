package com.copasso.blog.model;

import java.util.HashMap;

public class BMessage extends HashMap<String,Object>{

    public BMessage (Object data){
        this.put("data", data);
    }

    public BMessage success(){
        return success("成功");
    }

    public BMessage success(String msg){
        this.put("code",1);
        this.put("msg",msg);
        return this;
    }

    public BMessage faol(){
        return fail("失败");
    }

    public BMessage fail(String msg){
        this.put("code",0);
        this.put("msg",msg);
        return this;
    }


}
