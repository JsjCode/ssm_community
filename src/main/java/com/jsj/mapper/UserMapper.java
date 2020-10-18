package com.jsj.mapper;

import com.jsj.bean.Community;
import com.jsj.bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserMapper extends BaseMapper<User> {

    User getUserByPassword(@Param("username") String username, @Param("password") String password);

    User getById(Integer id);

    User getUserByCommentId(Integer commentId);

    List<Community> communitiesByUserId(int userId);

    List<Map<String,Object>> commentDynamic(@Param("userId") int userId,@Param("pageIndex") int pageIndex);

    List<Map<String,Object>> invitationsByUserId(@Param("userId") int userId,@Param("pageIndex") int pageIndex);

    int insert(User user);

    int update(User user);
}
