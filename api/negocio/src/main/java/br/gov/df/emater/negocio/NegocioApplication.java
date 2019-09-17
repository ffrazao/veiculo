package br.gov.df.emater.negocio;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "br.gov.df.emater")
public class NegocioApplication {

	public static void main(String[] args) {
		SpringApplication.run(NegocioApplication.class, args);
	}

}
