package com.copasso.blog.model.vo;


import com.copasso.blog.util.PageHelper;

/**
 *  用于封装评论信息，包括评论内容，作者信息，文章信息
  */
public class CommentListVo {
    //评论信息
    private CommentCustom commentCustom;

    //文章信息
    private ArticleCustom articleCustom;

    //分页信息
    private PageHelper page;

    public CommentCustom getCommentCustom() {
        return commentCustom;
    }

    public void setCommentCustom(CommentCustom commentCustom) {
        this.commentCustom = commentCustom;
    }

    public ArticleCustom getArticleCustom() {
        return articleCustom;
    }

    public void setArticleCustom(ArticleCustom articleCustom) {
        this.articleCustom = articleCustom;
    }

    public PageHelper getPage() {
        return page;
    }

    public void setPage(PageHelper page) {
        this.page = page;
    }
}
