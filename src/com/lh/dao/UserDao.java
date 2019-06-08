package com.lh.dao;

import com.lh.bean.User;

import java.sql.SQLException;
import java.util.List;

public interface UserDao {
    /*添加用户*/
    public void insertUser(User user) throws SQLException;
    public User findUserByUsername(String username) throws SQLException;
    /*通过用户id获取用户名*/
    public  String findUsernameByUserId(Integer id) throws SQLException;
    /*修改用户信息*/
    public int updateUser(User user) throws SQLException;

    List<User> loadUserList() throws SQLException;

    void deleteUserById(Integer userid) throws SQLException;
}
