package com.lh.dao.impl;

import com.lh.bean.User;
import com.lh.dao.UserDao;
import com.lh.util.JdbcUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserDaoImpl implements UserDao {




    @Override
    public void insertUser(User user) throws SQLException {
        QueryRunner qr = new QueryRunner(JdbcUtils.getDataSource());
        String sql = "insert into user values(null,?,?,?,?)";
        Object params[] = {user.getUsername(),user.getPassword(),user.getGender(),user.getResume()};
        int update = qr.update(sql, params);
    }

    @Override
    public User findUserByUsername(String username) throws SQLException {
        QueryRunner qr = new QueryRunner(JdbcUtils.getDataSource());
        String sql = "select * from user where username = ?";
        Object  params[] = {username};
        User user = qr.query(sql, username, new BeanHandler<User>(User.class));

        System.out.println(user+"userDao");
        return user;
    }
    /*通过用户id获取用户名*/
    @Override
    public String findUsernameByUserId(Integer id) throws SQLException {
        QueryRunner qr = new QueryRunner(JdbcUtils.getDataSource());
        String sql = "select username from user where id = ?";
        String username = qr.query(sql, new ResultSetHandler<String>() {
            @Override
            public String handle(ResultSet resultSet) throws SQLException {
                resultSet.next();
                return resultSet.getString(1);
            }
        },id);


        return username;
    }

    @Override
    public int updateUser(User user) throws SQLException {
        QueryRunner qr = new QueryRunner(JdbcUtils.getDataSource());
        String sql = "update user set password = ?,resume=? where id = ?";
        Object  params[] = {user.getPassword(),user.getResume(),user.getId()};
       int i =  qr.update(sql,params);


        return i;
    }

    @Override
    public List<User> loadUserList() throws SQLException {
        QueryRunner qr = new QueryRunner(JdbcUtils.getDataSource());
        String sql = "select * from user";
      List<User> list = qr.query(sql, new BeanListHandler<User>(User.class));


        return list;
    }
    /*通过用户id删除用户*/
    @Override
    public void deleteUserById(Integer userid) throws SQLException {
        QueryRunner qr = new QueryRunner(JdbcUtils.getDataSource());
        String sql = "delete from user  where id = ?";
         qr.update(sql,userid);
    }




}
