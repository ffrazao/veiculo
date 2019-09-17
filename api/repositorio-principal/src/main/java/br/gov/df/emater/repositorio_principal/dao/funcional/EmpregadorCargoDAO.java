package br.gov.df.emater.repositorio_principal.dao.funcional;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.funcional.EmpregadorCargo;

public interface EmpregadorCargoDAO extends JpaRepository<EmpregadorCargo, Integer> {
}