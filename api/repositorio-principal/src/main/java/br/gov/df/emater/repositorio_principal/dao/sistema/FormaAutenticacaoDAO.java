package br.gov.df.emater.repositorio_principal.dao.sistema;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.sistema.FormaAutenticacao;

public interface FormaAutenticacaoDAO extends JpaRepository<FormaAutenticacao, Integer> {
}