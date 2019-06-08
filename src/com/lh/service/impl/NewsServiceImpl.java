package com.lh.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.lh.bean.News;
import com.lh.dao.NewsDao;
import com.lh.dao.impl.NewsDaoImpl;
import com.lh.service.NewsService;

import java.sql.SQLException;
import java.util.List;

public class NewsServiceImpl implements NewsService {


    NewsDao nd = new NewsDaoImpl();
    /*分页加载新闻的函数*/
    @Override
    public List<News> loadNewsList() {
        List<News> list = nd.loadNews();
        return list;
    }

    @Override
    public List<News> loadNewsListforManager() {
        List<News> list = nd.loadNewsList();
        return list;
    }

    @Override
    public News findNewsById(Integer id) {
        return  nd.findNewsById(id);
    }

    @Override
    public List<News> findNewsByType(Integer id) {
        return  nd.findNewsByType(id);
    }

    @Override
    public List<News> findNewsBySearch(String s) {
        return nd.findNewsBySearch(s);
    }

    @Override
    public void managerDeleteNews(Integer newsid) throws SQLException {
        nd.deleteNewsById(newsid);
    }

    @Override
    public void uodateNews(News news) throws SQLException {
        nd.updateNews(news);
    }

    @Override
    public void addNews(News news) throws SQLException {
        nd.insertNews(news);
    }
}
