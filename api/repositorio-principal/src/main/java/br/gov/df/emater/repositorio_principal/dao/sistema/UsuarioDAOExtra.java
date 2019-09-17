package br.gov.df.emater.repositorio_principal.dao.sistema;

import java.util.Collection;

import br.gov.df.emater.repositorio_principal.entidade.sistema.Usuario;
import br.gov.df.emater.transporte.sistema.UsuarioFiltroDTO;

public interface UsuarioDAOExtra {

	Collection<Usuario> findByFiltro(UsuarioFiltroDTO filtro);

}
