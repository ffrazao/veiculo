package br.gov.df.emater.repositorio_principal.dao.sistema;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.sistema.Usuario;

public interface UsuarioDAO extends JpaRepository<Usuario, Integer>, UsuarioDAOExtra {
	
	Usuario findByLogin(String login);
	
}