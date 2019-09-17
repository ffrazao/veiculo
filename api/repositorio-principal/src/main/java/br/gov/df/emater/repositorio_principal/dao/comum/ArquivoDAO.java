package br.gov.df.emater.repositorio_principal.dao.comum;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.comum.Arquivo;

public interface ArquivoDAO extends JpaRepository<Arquivo, Integer> {
}