package com.copasso.blog;

import com.copasso.blog.utils.BlogUtils;

public class MD5Test {
    public static void main(String[] args) {
        System.out.println( BlogUtils.MD5encode("admin"+"admin"));
    }
}
