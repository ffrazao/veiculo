package br.gov.df.emater.autorizador;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "br.gov.df.emater")
public class AutorizadorServidorApplication {

	public static void main(String[] args) {
		SpringApplication.run(AutorizadorServidorApplication.class, args);
	}

}
