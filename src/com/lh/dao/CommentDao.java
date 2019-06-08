package com.lh.dao;

import com.lh.bean.Comment;

import java.sql.SQLException;
import java.util.List;

public interface CommentDao {
    public void insertComment(Integer userId, Integer newsId,String comment) throws SQLException;

    /*根据新闻id查找评论*/
    public List<Comment> findCommentByNewsId(Integer newsId) throws SQLException;

    /*加载最新评论*/
    public List<Comment> loadRedComment() throws SQLException;

    /*根据用户id获取评论*/
    public List<Comment> loadCommentforUid(Integer id) throws SQLException;
    /*根据评论id进行删除操作*/
    public  void deleteCommentByCid(Integer commentid) throws SQLException;

    List<Comment> loadCommentforManager() throws SQLException;
}
