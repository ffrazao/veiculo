package br.gov.df.emater.repositorio_principal.dao.evento;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.evento.Participacao;

public interface ParticipacaoDAO extends JpaRepository<Participacao, Integer> {
}
