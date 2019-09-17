package br.gov.df.emater.repositorio_principal.dao.evento;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.evento.Tipo;

public interface TipoDAO extends JpaRepository<Tipo, Integer> {
}
