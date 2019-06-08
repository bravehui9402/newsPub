package com.lh.dao.impl;

import com.lh.bean.News;
import com.lh.dao.NewsDao;
import com.lh.util.JdbcUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.Date;
import java.sql.SQLException;

import java.text.SimpleDateFormat;
import java.util.List;

public class NewsDaoImpl implements NewsDao {


    @Override
    public List<News> loadNews() {
        QueryRunner qr = null;
        try {
           qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "select * from news limit 1,11";

        List<News> list = null;
        try {
            list = qr.query(sql, new BeanListHandler<News>(News.class));
        } catch (SQLException e) {
            System.out.println("加载新闻数据库查询出错");
        }
        return list;
    }

    @Override
    public List<News> loadNewsList() {
        QueryRunner qr = null;
        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "select * from news";

        List<News> list = null;
        try {
            list = qr.query(sql, new BeanListHandler<News>(News.class));
        } catch (SQLException e) {
            System.out.println("加载新闻数据库查询出错");
        }
        return list;
    }

    @Override
    public News findNewsById(Integer id) {

        QueryRunner qr = null;
        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "select * from news where id = ?";
        try {
           return  qr.query(sql,id,new BeanHandler<News>(News.class));
        } catch (SQLException e) {
            System.out.println("查询单个新闻出错"+e.getMessage());
        }
        return null;
    }

    @Override
    public List<News> findNewsByType(Integer id) {
        QueryRunner qr = null;
        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "select * from news where newstype = ?";
        try {
            return  qr.query(sql,id,new BeanListHandler<News>(News.class));
        } catch (SQLException e) {
            System.out.println("查询单个新闻出错"+e.getMessage());
        }
        return null;
    }

    @Override
    public List<News> findNewsBySearch(String s) {
        QueryRunner qr = null;
        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "select * from news where title like '%"+s+"%'";
        try {
            List<News> list =  qr.query(sql,new BeanListHandler<News>(News.class));
            System.out.println(list);
            return list;
        } catch (SQLException e) {
            System.out.println("查询单个新闻出错"+e.getMessage());
        }
        return null;
    }

    @Override
    public void deleteNewsById(Integer newsid) throws SQLException {
        QueryRunner qr = null;
        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "delete  from news where id = ?";
        qr.update(sql,newsid);
    }

    @Override
    public void updateNews(News news) throws SQLException {
        QueryRunner qr = null;
        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "update news set title=?,author=?,content=?,newstype=? where id = ?";
        Object[] param = {news.getTitle(),news.getAuthor(),news.getContent(),news.getNewstype(),news.getId()};
        qr.update(sql,param);
    }

    @Override
    public void insertNews(News news) throws SQLException {
        QueryRunner qr = null;
        try {
            qr = new QueryRunner(JdbcUtils.getDataSource());
        } catch (SQLException e) {
            System.out.println("数据库连接出错"+e.getMessage());
        }
        String sql= "insert into  news  values(null,?,?,?,?,null,?)";
        Object[] param = {news.getTitle(),news.getAuthor(),news.getContent(),new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new java.util.Date()),news.getNewstype()};
        qr.update(sql,param);
    }
}
