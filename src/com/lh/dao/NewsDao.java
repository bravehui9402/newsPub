package com.lh.dao;

import com.lh.bean.News;

import java.sql.SQLException;
import java.util.List;

public interface NewsDao {
    /*新闻首页加载*/
    public List<News> loadNews();
    /*新闻管理加载*/
    public List<News> loadNewsList();
    /*根据新闻id获取新闻*/
    public News findNewsById(Integer id);
    /*根据新闻类型查询新闻*/
    public List<News> findNewsByType(Integer id);
    /*根据关键字查找新闻*/
    public List<News> findNewsBySearch(String  s);
    /*根据新闻id进行删除*/
    public void deleteNewsById(Integer newsid) throws SQLException;
    /*新闻更新*/
    public  void  updateNews(News news) throws SQLException;
    /*添加新闻*/
    public  void  insertNews(News news) throws SQLException;
}
