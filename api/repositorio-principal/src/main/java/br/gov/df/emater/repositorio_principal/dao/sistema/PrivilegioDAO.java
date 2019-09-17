package br.gov.df.emater.repositorio_principal.dao.sistema;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.sistema.Privilegio;

public interface PrivilegioDAO extends JpaRepository<Privilegio, Integer> {
}