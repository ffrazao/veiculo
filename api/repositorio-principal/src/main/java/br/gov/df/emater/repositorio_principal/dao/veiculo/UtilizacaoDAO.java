package br.gov.df.emater.repositorio_principal.dao.veiculo;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.veiculo.Utilizacao;

public interface UtilizacaoDAO extends JpaRepository<Utilizacao, Integer> {
}