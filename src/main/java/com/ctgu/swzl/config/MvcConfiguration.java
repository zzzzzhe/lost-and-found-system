package com.ctgu.swzl.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
/*继承 WebMvcConfigurationSupport 类，并重写其中的方法，实现了对 MVC 相关配置的自定义。包括静态资源的映射、视图控制器的配置、拦截器的配置、文件解析器的配置*/
@Configuration
public class MvcConfiguration extends WebMvcConfigurationSupport {

    @Value("${images.path}")
    private String path;
/*就是无论登不登陆都可以访问*/
    @Override  //静态资源映射
    protected void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/*.html").addResourceLocations("classpath:/static/");
        registry.addResourceHandler("/js/**").addResourceLocations("classpath:/static/js/");
        registry.addResourceHandler("/css/**").addResourceLocations("classpath:/static/css/");
        registry.addResourceHandler("/img/**").addResourceLocations("classpath:/static/img/");
        registry.addResourceHandler("/images/**").addResourceLocations("file:"+path+"/");
    }

    @Override  // 视图控制
    protected void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/problems").setViewName("problems");
    }

    @Override  // 登录拦截
    protected void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginHandleInterceptor()).addPathPatterns("/announce","/mine")
                .excludePathPatterns("/js/**","/css/**","/images/**","/img/**");
        registry.addInterceptor(new AdminInterceptor()).addPathPatterns("/admin/*")
                .excludePathPatterns("/js/**","/css/**","/images/**","/img/**");
    }
/*配置看上传文件的大小配置*/
    @Bean  // 文件解析器
    public CommonsMultipartResolver fileResolver(){
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(10*1024*1024);
        return resolver;
    }

    @Bean
    public ObjectMapper mapper(){
        return new ObjectMapper();
    }
}
