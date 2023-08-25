package com.ctgu.swzl.service;

import com.ctgu.swzl.domain.Post;
import org.apache.ibatis.annotations.Param;

import java.util.List;
/*业务层完成业务逻辑处理，即controller接受到数据由业务层处理*/
public interface PostService {

    List<Post> findAll();

    List<Post> findBySL(int S, int L);

    boolean addPost(Post post);

    List<Post> findById(long id);
    
    List<Post> findByUname(String username);

    boolean deleteById(long id);

    List<Post> findByTypeName(String typeName);

    boolean updateStatus(Post post);

    boolean updateViewCount(Post post);
}
