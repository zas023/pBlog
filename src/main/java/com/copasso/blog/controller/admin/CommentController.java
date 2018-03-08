package com.copasso.blog.controller.admin;

import com.github.pagehelper.PageInfo;
import com.vdurmont.emoji.EmojiParser;
import com.copasso.blog.controller.BaseController;
import com.copasso.blog.exception.TipException;
import com.copasso.blog.model.Bo.RestResponseBo;
import com.copasso.blog.model.Vo.CommentVo;
import com.copasso.blog.model.Vo.CommentVoExample;
import com.copasso.blog.model.Vo.UserVo;
import com.copasso.blog.service.ICommentService;
import com.copasso.blog.utils.BlogUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by 13 on 2017/2/26.
 */
@Controller
@RequestMapping("admin/comments")
public class CommentController extends BaseController {

    private static final Logger LOGGER = LoggerFactory.getLogger(CommentController.class);

    @Resource
    private ICommentService commentsService;

    /**
     * 评论列表
     * @param page
     * @param limit
     * @param request
     * @return
     */
    @GetMapping(value = "")
    public String index(@RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "limit", defaultValue = "15") int limit, HttpServletRequest request) {
        UserVo users = this.user(request);
        CommentVoExample commentVoExample = new CommentVoExample();
        commentVoExample.setOrderByClause("coid desc");
        commentVoExample.createCriteria().andAuthorIdNotEqualTo(users.getUid());
        PageInfo<CommentVo> commentsPaginator = commentsService.getCommentsWithPage(commentVoExample,page, limit);
        request.setAttribute("comments", commentsPaginator);
        return "admin/comment_list";
    }

    /**
     * 删除一条评论
     * @param coid
     * @return
     */
    @PostMapping(value = "delete")
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    public  RestResponseBo delete(@RequestParam Integer coid) {
        try {
            CommentVo comments = commentsService.getCommentById(coid);
            if(null == comments){
                return RestResponseBo.fail("不存在该评论");
            }
            commentsService.delete(coid, comments.getCid());
        } catch (Exception e) {
            String msg = "评论删除失败";
            if (e instanceof TipException) {
                msg = e.getMessage();
            } else {
                LOGGER.error(msg, e);
            }
            return RestResponseBo.fail(msg);
        }
        return RestResponseBo.ok();
    }

    @PostMapping(value = "status")
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    public RestResponseBo delete(@RequestParam Integer coid, @RequestParam String status) {
        try {
            CommentVo comments = new CommentVo();
            comments.setCoid(coid);
            comments.setStatus(status);
            commentsService.update(comments);
        } catch (Exception e) {
            String msg = "操作失败";
            if (e instanceof TipException) {
                msg = e.getMessage();
            } else {
                LOGGER.error(msg, e);
            }
            return RestResponseBo.fail(msg);
        }
        return RestResponseBo.ok();
    }

    /**
     * 回复评论
     * @param coid
     * @param content
     * @param request
     * @return
     */
    @PostMapping(value = "")
    @ResponseBody
    @Transactional(rollbackFor = TipException.class)
    public RestResponseBo reply(@RequestParam Integer coid, @RequestParam String content, HttpServletRequest request) {
        if(null == coid || StringUtils.isBlank(content)){
            return RestResponseBo.fail("请输入完整后评论");
        }

        if(content.length() > 2000){
            return RestResponseBo.fail("请输入2000个字符以内的回复");
        }
        CommentVo c = commentsService.getCommentById(coid);
        if(null == c){
            return RestResponseBo.fail("不存在该评论");
        }
        UserVo users = this.user(request);
        content = BlogUtils.cleanXSS(content);
        content = EmojiParser.parseToAliases(content);

        CommentVo comment = new CommentVo();
        comment.setAuthor(users.getUsername());
        comment.setAuthorId(users.getUid());
        comment.setCid(c.getCid());
        comment.setIp(request.getRemoteAddr());
        comment.setUrl(users.getHomeUrl());
        comment.setContent(content);
        comment.setMail(users.getEmail());
        comment.setParent(coid);
        try {
            commentsService.insertComment(comment);
            return RestResponseBo.ok();
        } catch (Exception e) {
            String msg = "回复失败";
            if (e instanceof TipException) {
                msg = e.getMessage();
            } else {
                LOGGER.error(msg, e);
            }
            return RestResponseBo.fail(msg);
        }
    }

}
