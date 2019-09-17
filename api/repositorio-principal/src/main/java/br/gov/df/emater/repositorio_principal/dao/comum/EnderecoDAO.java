package br.gov.df.emater.repositorio_principal.dao.comum;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.comum.Endereco;

public interface EnderecoDAO extends JpaRepository<Endereco, Integer> {
}