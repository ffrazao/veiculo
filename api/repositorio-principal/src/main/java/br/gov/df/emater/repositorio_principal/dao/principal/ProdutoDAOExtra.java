package br.gov.df.emater.repositorio_principal.dao.principal;

import java.util.Collection;

import br.gov.df.emater.repositorio_principal.entidade.principal.Produto;
import br.gov.df.emater.transporte.principal.ProdutoFiltroDTO;

public interface ProdutoDAOExtra {

	Collection<Produto> findByFiltro(ProdutoFiltroDTO filtro);

}
