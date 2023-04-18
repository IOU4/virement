package eai.virement.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import lombok.extern.slf4j.Slf4j;

/**
 * AppConfig
 */
@Configuration
@EnableWebMvc
@Slf4j
public class AppConfig implements WebMvcConfigurer {

  @Override
  public void addCorsMappings(CorsRegistry registry) {
    log.info("new mappings");
    registry.addMapping("/**")
        .allowedOrigins("*")
        .allowedMethods("*");
  }

}
