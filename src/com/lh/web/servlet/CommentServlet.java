package com.lh.web.servlet;

import com.alibaba.fastjson.JSON;
import com.lh.service.CommentService;
import com.lh.service.impl.CommentServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CommentServlet",urlPatterns = "/comment")
public class CommentServlet extends HttpServlet {
    CommentService cs = new CommentServiceImpl();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("UTF-8");
        String method = request.getParameter("method");
        if("fabiaopinglun".equals(method)){
            fabiaopinglun(request,response);
        }else if("huoqupinglun".equals(method)){
            huoqupinglun(request,response);
        }else if("loadCommentforindex".equals(method)){
            loadCommentforindex(request,response);
        }else if("loadComforMana".equals(method)){
            loadComforMana(request,response);
        }else if("deleteCommentById".equals(method)){
            deleteCommentById(request,response);
        }
    }

    private void deleteCommentById(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer commentid = Integer.valueOf(request.getParameter("commentid"));
        String s = "";
        try {
            cs.deleteCommentByCommentid(commentid);
           s= "删除成功！";
        } catch (Exception e) {
            s= "删除失败！";
            e.printStackTrace();
        } finally {
            response.getWriter().print(s);
        }


    }

    private void loadComforMana(HttpServletRequest request, HttpServletResponse response) {
        Integer uid =  Integer.valueOf(request.getParameter("userid"));
        List<Map> list = new ArrayList<>();
        try {
          list = cs.loadCommentforMana(uid);
            String s = JSON.toJSONString(list);
            response.getWriter().print(s);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }

    private void loadCommentforindex(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String s = JSON.toJSONString( cs.loadCommentforindex());
        System.out.println(s);
        response.getWriter().print(s);

    }

    private void huoqupinglun(HttpServletRequest request, HttpServletResponse response) throws IOException {
                System.out.println(request.getParameter("newsid"));
              String s = JSON.toJSONString( cs.loadCommentforNewsShow(Integer.valueOf(request.getParameter("newsid"))));
              System.out.println(s);
              response.getWriter().print(s);
    }

    private void fabiaopinglun(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String uid =request.getParameter("userid");
        if(uid == null ||  "".equals(uid))
        {
            response.getWriter().print("nologin");

        }else{
            boolean b = cs.fabiaopinglun(Integer.valueOf(request.getParameter("userid")), Integer.valueOf(request.getParameter("newsid")), request.getParameter("comment"));
            if (b){
                response.getWriter().print(b);
            }else{
                response.getWriter().print(b);
            }
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
