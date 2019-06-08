package com.lh.web.servlet;

import com.lh.bean.ResultBean;
import com.lh.bean.User;
import com.lh.service.UserService;
import com.lh.service.impl.UserServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;

@WebServlet(name = "user",urlPatterns = "/user")
public class UserServlet extends HttpServlet {
    UserService us = new UserServiceImpl();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        String method = request.getParameter("method");
        if("regist".equals(method)){
            regist(request,response);
        }else if("registOfVa".equals(method)){
            registOfVa(request,response);
        }else if("yzm".equals(method)){
            registOfyzm(request,response);
        }else if("login".equals(method)){
            login(request,response);
        }else if("refect".equals(method)){
            refect(request,response);
        }else if("update".equals(method)){
            update(request,response);
        }else if("zhuxiao".equals(method)){
            zhuxiao(request,response);
        }
    }

    private void zhuxiao(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().setAttribute("user",null);
    }

    private void update(HttpServletRequest request, HttpServletResponse response) {
        User user = new User();
        try {
            BeanUtils.populate(user,request.getParameterMap());
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            int i = us.updateUserService(user);
            response.getWriter().print(i);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }

    private void refect(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            request.getRequestDispatcher("WEB-INF/jsp1/userManager.jsp").forward(request,response);
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        User user = new User();
        try {
            BeanUtils.populate(user,request.getParameterMap());
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {

            if( us.UserLogin(user) != null)
            {
                if ("admin".equals(us.UserLogin(user).getUsername()))
                {
                    request.getSession().setAttribute("user",us.UserLogin(user));
                    request.getRequestDispatcher("WEB-INF/jsp1/adminManager1.jsp").forward(request,response);
                }else {
                    request.getSession().setAttribute("user",us.UserLogin(user));
                    response.sendRedirect("jsp/index.jsp");
                }

            }else{
                request.setAttribute("loginError","用户名或密码不正确，请重新输入");
                request.setAttribute("user",user);
                request.getRequestDispatcher("jsp/login.jsp").forward(request,response);

            }

        } catch (SQLException e) {
            request.setAttribute("loginError","出现了一些小问题，请重新注册或者联系管理员~~");
            request.setAttribute("user",user);
            request.getRequestDispatcher("jsp/login.jsp").forward(request,response);
        }


    }

    /*验证码判断函数*/
    private void registOfyzm(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("UTF-8");

        String yzm = request.getParameter("yzm");
        String checkcode = (String) request.getSession().getAttribute("checkcode");
        if(checkcode.equals(yzm)){
            try {
                response.getWriter().print("true");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /*注册名是否重复验证*/
    public  void registOfVa(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");

        try {
            response.getWriter().print(us.RegistUserByOf(username));
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }


    /*用户注册*/
    public void regist(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        User user = new User();
        try {
            BeanUtils.populate(user,request.getParameterMap());
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }

        ResultBean resultBean = us.RegistUser(user);
        if(resultBean.getError() == null)
        {
            response.sendRedirect("jsp/login.jsp");
        }else{
            request.setAttribute("registError","出现了一些小问题，请重新注册或者联系管理员~~");
            request.setAttribute("user",user);
            request.getRequestDispatcher("jsp/regist.jsp").forward(request,response);
        }

    };
}
