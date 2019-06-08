package com.lh.service.impl;

import com.lh.bean.Comment;
import com.lh.dao.CommentDao;
import com.lh.dao.NewsDao;
import com.lh.dao.UserDao;
import com.lh.dao.impl.CommentDaoImpl;
import com.lh.dao.impl.NewsDaoImpl;
import com.lh.dao.impl.UserDaoImpl;
import com.lh.service.CommentService;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CommentServiceImpl implements CommentService {
    CommentDao cd = new CommentDaoImpl();
    UserDao ud = new UserDaoImpl();
    NewsDao nd = new NewsDaoImpl();
    @Override
    public boolean fabiaopinglun(Integer userId, Integer newsId, String comment) {

        try {
            cd.insertComment(userId,newsId,comment);
            return  true;
        } catch (SQLException e) {
            System.out.println("评论发表失败"+e.getMessage());
            return false;
        }


    }

    @Override
    public List<Map> loadCommentforNewsShow(Integer newid) {

        List<Map> list2 = new ArrayList<>();
        try {
            List<Comment> list = cd.findCommentByNewsId(newid);
            for(Comment c: list){
                Map map = new HashMap();
                String username = ud.findUsernameByUserId(c.getCommentid());
                map.put("commentpersion",username);
                map.put("comment",c.getComment());
                map.put("commenttime",c.getCommenttime());
                list2.add(map);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }


        return list2;
    }

    @Override
    public List<Map> loadCommentforindex() {
        List<Map> list2 = new ArrayList<>();
        try {
            List<Comment> list = cd.loadRedComment();
            for(Comment c: list){
                Map map = new HashMap();
                String username = ud.findUsernameByUserId(c.getCommentid());
                map.put("commentpersion",username);
                map.put("comment",c.getComment());
                map.put("newsid",c.getNewsid());
                list2.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list2;
    }

    @Override
    public List<Map> loadCommentforMana(Integer uid) throws SQLException {
        List<Comment> list1 = cd.loadCommentforUid(uid);
        List<Map> list = new ArrayList<>();
        for(Comment c:list1)
        {
            Map<String,String > map = new HashMap<>();
            map.put("commenttome",c.getCommenttime());
            map.put("comment",c.getComment());
            map.put("commentid",c.getId().toString());
            map.put("newsName",nd.findNewsById(c.getNewsid()).getTitle());
            list.add(map);
        }

        return list;
    }

    @Override
    public void deleteCommentByCommentid(Integer commentid) throws SQLException {
        cd.deleteCommentByCid(commentid);
    }

    @Override
    public List<Comment> loadCommentListforManager() throws SQLException {
        return cd.loadCommentforManager();
    }
}
