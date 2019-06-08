package com.lh.service;

import com.lh.bean.News;

import java.sql.SQLException;
import java.util.List;

public interface NewsService {
    /*主页新闻展示*/
    public List<News> loadNewsList();
    /*管理新闻展示*/
    public List<News> loadNewsListforManager();
    /*查询的单个新闻*/
    public News findNewsById(Integer id);

    /*根据新闻类型查询新闻*/
    public List<News> findNewsByType(Integer id);
    /*根据新闻关键字查询新闻*/
    public List<News> findNewsBySearch(String s);
    /*管理员删除新闻*/
    public void managerDeleteNews(Integer newsid) throws SQLException;
    /*管理员更新新闻*/
    public  void uodateNews(News news) throws SQLException;
    /*管理员添加新闻*/
    public void addNews(News news) throws SQLException;
}
