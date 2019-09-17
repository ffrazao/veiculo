package br.gov.df.emater.repositorio_principal;

import java.io.IOException;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.fasterxml.jackson.databind.ObjectMapper;

import br.gov.df.emater.repositorio_principal.dao.produto.ProdutoTipoDAO;
import br.gov.df.emater.repositorio_principal.entidade.produto.ProdutoTipo;

@SpringBootApplication(scanBasePackages = "br.gov.df.emater")
@EntityScan("br.gov.df.emater.repositorio_principal.entidade")
@EnableJpaRepositories("br.gov.df.emater.repositorio_principal.dao")
public class RepositorioPrincipalApplication /* implements CommandLineRunner */ {

	public static void main(String[] args) throws IOException {
		// @formatter:off
		/*

		Map<String, Object> applicationYml = null;
		try (InputStream inputStream = RepositorioPrincipalApplication.class.getClassLoader()
				.getResourceAsStream("application.yml")) {

			Yaml yaml = new Yaml();
			applicationYml = yaml.load(inputStream);

			Map<String, Object> no;

			// verificar o no spring
			no = (Map<String, Object>) applicationYml.get("spring");
			if (CollectionUtils.isEmpty(no)) {
				System.out.println("Dados de conexão ao banco de dados não definido...");
				applicationYml.put("spring", new HashMap<>());
				no = (Map<String, Object>) applicationYml.get("spring");
			}

			// verificar o subno datasource
			no = (Map<String, Object>) no.get("datasource");
			if (CollectionUtils.isEmpty(no)) {
				no = (Map<String, Object>) applicationYml.get("spring");
				no.put("datasource", new HashMap<>());
				no = (Map<String, Object>) no.get("datasource");

				System.out.println("informe os dados de conexão ao banco de dados");
				try (Scanner sc = new Scanner(System.in)) {
					sc.useDelimiter("\\s");
					String linha;
					do {
						System.out.println("url: ");
					} while (StringUtils.isEmpty(linha = sc.nextLine()));
					no.put("url", linha);
					do {
						System.out.println("username: ");
					} while (StringUtils.isEmpty(linha = sc.nextLine()));
					no.put("username", linha);
					do {
						System.out.println("password: ");
					} while (StringUtils.isEmpty(linha = sc.nextLine()));
					no.put("password", linha);
				}
				no.put("initialization-mode", "always");
				no.put("continue-on-error", false);

				System.out.format("url: [%s], username: [%s], password: [%s]", no.get("url"), no.get("username"),
						no.get("password"));
			}
			System.out.println(yaml.dump(applicationYml));
		}
		 */
		// @formatter:on

		SpringApplication.run(RepositorioPrincipalApplication.class, args);
	}

	@Autowired
	private ProdutoTipoDAO dao;

	//@Override
	@Transactional()
	public void run(String... args) throws Exception {
		Optional<ProdutoTipo> t = dao.findById(1);
		System.out.println(new ObjectMapper().writeValueAsString(t.orElse(null)));
	}

}
