package com.lh.web.servlet;

import com.alibaba.fastjson.JSON;
import com.lh.bean.Comment;
import com.lh.bean.News;
import com.lh.bean.User;
import com.lh.service.CommentService;
import com.lh.service.NewsService;
import com.lh.service.UserService;
import com.lh.service.impl.CommentServiceImpl;
import com.lh.service.impl.NewsServiceImpl;
import com.lh.service.impl.UserServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ManagerServlet",urlPatterns = "/manager1")
public class ManagerServlet extends HttpServlet {
    NewsService ns = new NewsServiceImpl();
    UserService us = new UserServiceImpl();
    CommentService cs = new CommentServiceImpl();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("UTF-8");
        String method = request.getParameter("method");
        if("loadNewsList".equals(method)){
            loadNewsList(request,response);
        }else if("deleteNews".equals(method)){
            deleteNews(request,response);
        }else if("findnewsByid".equals(method)){
            findnewsByid(request,response);
        }else if("updateNews".equals(method)){
            updateNews(request,response);
        }else if("addNews".equals(method)){
            addNews(request,response);
        }else if("loadUserList".equals(method)){
            loadUserList(request,response);
        }else if("deleteUser".equals(method)){
            deleteUser(request,response);
        }else if("loadCommentList".equals(method)){
            loadCommentList(request,response);
        }else if("deleteComment".equals(method)){
            deleteComment(request,response);
        }

    }
    /*删除评论信息*/
    private void deleteComment(HttpServletRequest request, HttpServletResponse response) {
        Integer cid = Integer.valueOf(request.getParameter("commentdeleteid"));
        PrintWriter writer= null;
        try {
            writer = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            cs.deleteCommentByCommentid(cid);
            writer.print("删除成功！");
        } catch (Exception e) {
            writer.print("删除失败！请联系管理员");
            e.printStackTrace();
        }
    }

    /*加载评论信息*/
    private void loadCommentList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Comment> CommentList = null;
        try {
            CommentList = cs.loadCommentListforManager();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.getWriter().print(JSON.toJSONString(CommentList));
    }

    /*管理员删除用户*/
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) {
        Integer newsid = Integer.valueOf(request.getParameter("userdeleteid"));
        PrintWriter writer= null;
        try {
            writer = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            us.managerDeleteUser(newsid);
            writer.print("删除成功！");
        } catch (Exception e) {
            writer.print("删除失败！请联系管理员");
            e.printStackTrace();
        }
    }

    /*管理员加载用户信息*/
    private void loadUserList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<User> newsList = null;
        try {
            newsList = us.loadUserListforManager();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.getWriter().print(JSON.toJSONString(newsList));
    }

    /*管理员添加新闻*/
    private void addNews(HttpServletRequest request, HttpServletResponse response) {
        News news = new News();
        PrintWriter writer= null;
        try {
            writer = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            BeanUtils.populate(news,request.getParameterMap());
            ns.addNews(news);
            writer.print("添加成功！");
        } catch (Exception e) {
            writer.print("添加失败！");
            e.printStackTrace();
        }
    }
    /*管理员修改新闻*/
    private void updateNews(HttpServletRequest request, HttpServletResponse response) {
        News news = new News();
        PrintWriter writer= null;
        try {
            writer = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            BeanUtils.populate(news,request.getParameterMap());
            try {
                ns.uodateNews(news);
                writer.print("修改成功！");
            } catch (SQLException e) {
                writer.print("修改失败！！");
                e.printStackTrace();
            }
        } catch (IllegalAccessException e) {
            writer.print("修改失败！！");
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            writer.print("修改失败！！");
            e.printStackTrace();
        }
    }
    /*管理员通过新闻id寻找新闻*/
    private void findnewsByid(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer newsid =  Integer.valueOf(request.getParameter("newsupdateid"));
        response.getWriter().print(JSON.toJSONString(ns.findNewsById(newsid)));

    }
    /*管理员删除新闻*/
    private void deleteNews(HttpServletRequest request, HttpServletResponse response) {
        Integer newsid = Integer.valueOf(request.getParameter("newsdeleteid"));
        PrintWriter writer= null;
        try {
          writer = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            ns.managerDeleteNews(newsid);
            writer.print("删除成功！");
        } catch (SQLException e) {
            writer.print("删除失败！请联系管理员");
            e.printStackTrace();
        }
    }
    /*管理员加载新闻列表*/
    private void loadNewsList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<News> newsList = ns.loadNewsListforManager();
        response.getWriter().print(JSON.toJSONString(newsList));
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
