package com.copasso.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.copasso.blog.exception.TipException;
import com.copasso.blog.utils.DateUtils;
import com.copasso.blog.utils.BlogUtils;
import com.copasso.blog.dao.CommentVoMapper;
import com.copasso.blog.model.Bo.CommentBo;
import com.copasso.blog.model.Vo.CommentVo;
import com.copasso.blog.model.Vo.CommentVoExample;
import com.copasso.blog.model.Vo.ContentVo;
import com.copasso.blog.service.ICommentService;
import com.copasso.blog.service.IContentService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 评论Service
 */
@Service
public class CommentServiceImpl implements ICommentService {
    private static final Logger LOGGER = LoggerFactory.getLogger(CommentServiceImpl.class);

    @Resource
    private CommentVoMapper commentMapper;

    @Resource
    private IContentService contentService;

    /**
     * 添加评论
     * @param comments
     */
    @Override
    public void insertComment(CommentVo comments) {
        if (null == comments) {
            throw new TipException("评论对象为空");
        }
        if (StringUtils.isBlank(comments.getAuthor())) {
            comments.setAuthor("热心网友");
        }
        if (StringUtils.isNotBlank(comments.getMail()) && !BlogUtils.isEmail(comments.getMail())) {
            throw new TipException("请输入正确的邮箱格式");
        }
        if (StringUtils.isBlank(comments.getContent())) {
            throw new TipException("评论内容不能为空");
        }
        if (comments.getContent().length() < 5 || comments.getContent().length() > 2000) {
            throw new TipException("评论字数在5-2000个字符");
        }
        if (null == comments.getCid()) {
            throw new TipException("评论文章不能为空");
        }
        ContentVo contents = contentService.getContents(String.valueOf(comments.getCid()));
        if (null == contents) {
            throw new TipException("不存在的文章");
        }
        comments.setOwnerId(contents.getAuthorId());
        comments.setCreated(DateUtils.getCurrentUnixTime());
        commentMapper.insertSelective(comments);

        ContentVo temp = new ContentVo();
        temp.setCid(contents.getCid());
        temp.setCommentsNum(contents.getCommentsNum() + 1);
        contentService.updateContentByCid(temp);
    }

    /**
     * 获取文章评论
     * @param cid  文章id
     * @param page  页码
     * @param limit  个数
     * @return
     */
    @Override
    public PageInfo<CommentBo> getComments(Integer cid, int page, int limit) {

        if (null != cid) {
            PageHelper.startPage(page, limit);
            CommentVoExample commentVoExample = new CommentVoExample();
            //获取所有评论
            commentVoExample.createCriteria().andCidEqualTo(cid).andParentEqualTo(0);
            commentVoExample.setOrderByClause("coid desc");
            List<CommentVo> parents = commentMapper.selectByExampleWithBLOBs(commentVoExample);
            PageInfo<CommentVo> commentPaginator = new PageInfo<>(parents);
            PageInfo<CommentBo> returnBo = copyPageInfo(commentPaginator);
            if (parents.size() != 0) {
                //Vo-->Bo
                List<CommentBo> comments = new ArrayList<>(parents.size());
                parents.forEach(parent -> {
                    CommentBo comment = new CommentBo(parent);

                    List<CommentVo> children = new ArrayList<>();
                    getChildren(children,comment.getCoid());
                    comment.setChildren(children);
                    if (children.size()>0)
                        comment.setLevels(1);

                    comments.add(comment);
                });
                returnBo.setList(comments);
            }
            return returnBo;
        }
        return null;
    }

    /**
     * 获取评论下的追加评论
     *
     * @param coid
     * @return
     */
    private void getChildren(List<CommentVo> list, Integer coid) {

        CommentVoExample commentVoExample = new CommentVoExample();
        //获取所有评论
        commentVoExample.createCriteria().andParentEqualTo(coid);
        commentVoExample.setOrderByClause("coid desc");
        List<CommentVo> parents = commentMapper.selectByExampleWithBLOBs(commentVoExample);
        if (null != parents) {
            list.addAll(parents);
            parents.forEach(c -> getChildren(list, c.getCoid()));
        }
    }

    @Override
    public PageInfo<CommentVo> getCommentsWithPage(CommentVoExample commentVoExample, int page, int limit) {
        PageHelper.startPage(page, limit);
        List<CommentVo> commentVos = commentMapper.selectByExampleWithBLOBs(commentVoExample);
        PageInfo<CommentVo> pageInfo = new PageInfo<>(commentVos);
        return pageInfo;
    }

    @Override
    public void update(CommentVo comments) {
        if (null != comments && null != comments.getCoid()) {
            commentMapper.updateByPrimaryKeyWithBLOBs(comments);
        }
    }

    @Override
    public void delete(Integer coid, Integer cid) {
        if (null == coid) {
            throw new TipException("主键为空");
        }
        commentMapper.deleteByPrimaryKey(coid);
        ContentVo contents = contentService.getContents(cid + "");
        if (null != contents && contents.getCommentsNum() > 0) {
            ContentVo temp = new ContentVo();
            temp.setCid(cid);
            temp.setCommentsNum(contents.getCommentsNum() - 1);
            contentService.updateContentByCid(temp);
        }
    }

    @Override
    public CommentVo getCommentById(Integer coid) {
        if (null != coid) {
            return commentMapper.selectByPrimaryKey(coid);
        }
        return null;
    }

    /**
     * copy原有的分页信息，除数据
     *
     * @param ordinal
     * @param <T>
     * @return
     */
    private <T> PageInfo<T> copyPageInfo(PageInfo ordinal) {
        PageInfo<T> returnBo = new PageInfo<T>();
        returnBo.setPageSize(ordinal.getPageSize());
        returnBo.setPageNum(ordinal.getPageNum());
        returnBo.setEndRow(ordinal.getEndRow());
        returnBo.setTotal(ordinal.getTotal());
        returnBo.setHasNextPage(ordinal.isHasNextPage());
        returnBo.setHasPreviousPage(ordinal.isHasPreviousPage());
        returnBo.setIsFirstPage(ordinal.isIsFirstPage());
        returnBo.setIsLastPage(ordinal.isIsLastPage());
        returnBo.setNavigateFirstPage(ordinal.getNavigateFirstPage());
        returnBo.setNavigateLastPage(ordinal.getNavigateLastPage());
        returnBo.setNavigatepageNums(ordinal.getNavigatepageNums());
        returnBo.setSize(ordinal.getSize());
        returnBo.setPrePage(ordinal.getPrePage());
        returnBo.setNextPage(ordinal.getNextPage());
        return returnBo;
    }
}
