package com.lh.web.servlet;

import com.alibaba.fastjson.JSON;
import com.lh.bean.News;
import com.lh.service.NewsService;
import com.lh.service.impl.NewsServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

@WebServlet(name = "NewsServlet",urlPatterns = "/news")
public class NewsServlet extends HttpServlet {
    NewsService ns = new NewsServiceImpl();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String method = request.getParameter("method");
        if("loadNewsListforindex".equals(method)){
            loadNewsList(request,response);
        }else if("lookNewsById".equals(method)){
            lookNewsById(request,response);
        }else if("newsListShow".equals(method)){
            newsListShow(request,response);
        }else if("newsshowbySearch".equals(method)){
            newsshowbySearch(request,response);
        }
    }

    private void newsshowbySearch(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String  s =request.getParameter("search");
        List<News> list = ns.findNewsBySearch(s);
        System.out.println(list);
        request.setAttribute("newstypeList",JSON.toJSONString(ns.findNewsBySearch(s)));
        request.getRequestDispatcher("WEB-INF/jsp1/newsshowbySearch.jsp").forward(request,response);
    }

    private void newsListShow(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("UTF-8");
        Integer i =Integer.valueOf(request.getParameter("newstype"));

        String s = JSON.toJSONString(ns.findNewsByType(i));
        request.setAttribute("newstypeList",s);
        request.getRequestDispatcher("WEB-INF/jsp1/newsshowby"+i+".jsp").forward(request,response);
    }

    private void lookNewsById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        News news = ns.findNewsById(id);
        System.out.println("ok");
        request.setAttribute("news",news);
        request.getRequestDispatcher("WEB-INF/jsp1/newsConmment.jsp").forward(request,response);
    }

    private void loadNewsList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("UTF-8");
        News news = new News();
        try {
            BeanUtils.populate(news,request.getParameterMap());
        } catch (Exception e) {
            System.out.println("类型转换出错"+e.getMessage());
        }
        List<News> list = ns.loadNewsList();
        System.out.println(list.get(0));
        String s = JSON.toJSONString(list);
        response.getWriter().print(s);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
