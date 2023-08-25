package com.ctgu.swzl.domain;
/*引入Lombok*/
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data                               //生成getter、setter、equals、hashCode和toString方法
@Accessors(chain = true)            //生成链式调用setter方法
@ToString                           //生成toString方法
@NoArgsConstructor                  //生成无参构造方法
public class User implements Serializable {
    private Long id;
    private String username;
    private String password;
    private String email;
    private int age;
    private char sex;
    private String photo;
    private String rewardCode;
    private String personalSay;
    private Date lastTime;
    private String admin;

    private List<Post> allPost;         //用户发布的所有帖子
    private List<Comment> allComment;   //用户发表的所有评论
}
