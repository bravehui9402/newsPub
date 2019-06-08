package com.lh.test;

import com.lh.bean.User;
import com.lh.dao.UserDao;
import com.lh.dao.impl.UserDaoImpl;
import org.junit.Test;

import java.sql.SQLException;

public class test1 {
    @Test
    public void test1Demo() throws SQLException {

        User user = new User();
        user.setUsername("admin");
        user.setPassword("admin");
        user.setGender("0");
        user.setResume("大家好，我是管理员");

        UserDao ud = new UserDaoImpl();
        ud.insertUser(user);
    }
}
