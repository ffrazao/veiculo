package br.gov.df.emater.repositorio_principal.dao.sistema;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.sistema.Funcionalidade;

public interface FuncionalidadeDAO extends JpaRepository<Funcionalidade, Integer> {
}