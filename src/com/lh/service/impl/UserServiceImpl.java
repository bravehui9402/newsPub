package com.lh.service.impl;

import com.lh.bean.ResultBean;
import com.lh.bean.User;
import com.lh.dao.UserDao;
import com.lh.dao.impl.UserDaoImpl;
import com.lh.service.UserService;

import java.sql.SQLException;
import java.util.List;

public class UserServiceImpl implements UserService {
    UserDao ud = new UserDaoImpl();
    @Override
    public ResultBean RegistUser(User user) {
        ResultBean rb = new ResultBean();
        try {
            ud.insertUser(user);
        }catch (Exception e){
            rb.setError("注册操作失败"+e.getMessage());
        }
        return rb;
    }

    @Override
    public boolean RegistUserByOf(String username) throws SQLException {
        User user = ud.findUserByUsername(username);
        if(user == null)
        {
            return true;
        }
        return false;
    }

    @Override
    public User UserLogin(User user) throws SQLException {
        User u = ud.findUserByUsername(user.getUsername());
        if(u!=null&&u.getPassword().equals(user.getPassword()))
        {
            return u;
        }

        return null;
    }

    @Override
    public int updateUserService(User user) throws SQLException {
        int i = ud.updateUser(user);
        return i;
    }

    @Override
    public List<User> loadUserListforManager() throws SQLException {

        return ud.loadUserList();
    }

    @Override
    public void managerDeleteUser(Integer userid) throws SQLException {
        ud.deleteUserById(userid);
    }
}
