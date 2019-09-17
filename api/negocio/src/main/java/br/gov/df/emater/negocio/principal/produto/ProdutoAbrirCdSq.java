package br.gov.df.emater.negocio.principal.produto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.CadeiaSequenciada;

@Component
public class ProdutoAbrirCdSq extends CadeiaSequenciada {

	@Autowired
	ProdutoAbrirCdSq(ProdutoAbrirCmd c1, ProdutoExecutarCmd c2, ProdutoFecharCmd c3) {
		super(c1, c2, c3);
	}

}
