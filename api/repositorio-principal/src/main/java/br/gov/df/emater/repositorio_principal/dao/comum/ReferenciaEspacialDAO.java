package br.gov.df.emater.repositorio_principal.dao.comum;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.comum.ReferenciaEspacial;

public interface ReferenciaEspacialDAO extends JpaRepository<ReferenciaEspacial, Integer> {
}