package com.lh.service;

import com.lh.bean.Comment;
import com.lh.bean.ResultBean;
import com.lh.bean.User;

import java.sql.SQLException;
import java.util.List;

public interface UserService {
    /*用户注册方法*/
    public ResultBean RegistUser(User user);
    /*用户名是否重复验证*/
    public boolean RegistUserByOf(String username) throws SQLException;

    public User UserLogin(User user) throws SQLException;
    /*修改用户*/
    public int updateUserService(User user) throws SQLException;
    /*加载用户信息*/
    List<User> loadUserListforManager() throws SQLException;

    void managerDeleteUser(Integer newsid) throws SQLException;


}
