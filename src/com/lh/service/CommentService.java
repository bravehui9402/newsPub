package com.lh.service;

import com.lh.bean.Comment;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface CommentService {
    public boolean fabiaopinglun(Integer userId, Integer newsId,String comment);



    /*给新闻页面加载评论*/
    public List<Map> loadCommentforNewsShow(Integer newid);
    /*给首页加载最新评论*/
    public List<Map> loadCommentforindex();

    /*给用户管理页面加载评论*/
    public List<Map> loadCommentforMana(Integer uid) throws SQLException;

    /*根据评论id进行删除操作*/
    public void deleteCommentByCommentid(Integer commentid) throws SQLException;

    List<Comment> loadCommentListforManager() throws SQLException;
}
