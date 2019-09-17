package br.gov.df.emater.rest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication(scanBasePackages = "br.gov.df.emater")
public class RestfulApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(RestfulApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(RestfulApplication.class);
	}

}
