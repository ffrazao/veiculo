package br.gov.df.emater.repositorio_principal.dao.produto;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.produto.Composicao;

public interface ComposicaoDAO extends JpaRepository<Composicao, Integer> {
}