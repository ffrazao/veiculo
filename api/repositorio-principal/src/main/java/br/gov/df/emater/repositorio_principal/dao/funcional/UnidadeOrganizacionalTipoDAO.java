package br.gov.df.emater.repositorio_principal.dao.funcional;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.funcional.UnidadeOrganizacionalTipo;

public interface UnidadeOrganizacionalTipoDAO extends JpaRepository<UnidadeOrganizacionalTipo, Integer> {
}