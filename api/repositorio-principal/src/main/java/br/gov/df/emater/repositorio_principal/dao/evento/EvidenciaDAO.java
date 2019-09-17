package br.gov.df.emater.repositorio_principal.dao.evento;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.evento.Evidencia;

public interface EvidenciaDAO extends JpaRepository<Evidencia, Integer> {
}
