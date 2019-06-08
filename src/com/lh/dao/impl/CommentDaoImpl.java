package com.lh.dao.impl;

import com.lh.bean.Comment;
import com.lh.dao.CommentDao;
import com.lh.util.JdbcUtils;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

public class CommentDaoImpl implements CommentDao {
    @Override
    public void insertComment(Integer userId, Integer newsId, String comment) throws SQLException {
        QueryRunner qr = null;
        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "insert into comment values(null,?,?,?,?)";
        Object[] params = {comment,userId,new Date(),newsId};

        int i = qr.update(sql, params);

    }

    @Override
    public List<Comment> findCommentByNewsId(Integer newsId) throws SQLException {
        QueryRunner qr = null;
        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "select * from comment where newsid = ?";
        List<Comment> list = qr.query(sql, newsId, new BeanListHandler<Comment>(Comment.class));
        return list;
    }

    @Override
    public List<Comment> loadRedComment() throws SQLException {
        QueryRunner qr = null;
        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "select * from comment ORDER BY commenttime DESC LIMIT 1,5";
        List<Comment> list = qr.query(sql,new BeanListHandler<Comment>(Comment.class));
        return list;
    }

    @Override
    public List<Comment> loadCommentforUid(Integer id) throws SQLException {
        QueryRunner qr = null;
        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "select * from comment where commentid = ?";
        List<Comment> list = qr.query(sql,id,new BeanListHandler<Comment>(Comment.class));
        return list;
    }

    @Override
    public void deleteCommentByCid(Integer commentid) throws SQLException {
        System.out.println(commentid);
        QueryRunner qr = null;

        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "delete from comment where id = ?";
        int i =qr.update(sql,commentid);

        System.out.println(i);
    }

    @Override
    public List<Comment> loadCommentforManager() throws SQLException {
        QueryRunner qr = null;
        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "select * from comment ";
        List<Comment> list = qr.query(sql,new BeanListHandler<Comment>(Comment.class));
        return list;
    }
}
