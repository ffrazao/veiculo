package br.gov.df.emater.negocio.principal.produto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.CadeiaSequenciada;

@Component("ProdutoExcluirCdSq")
public class ProdutoExcluirCdSq extends CadeiaSequenciada {

	@Autowired
	ProdutoExcluirCdSq(ProdutoExcluirCmd c1) {
		super(c1);
	}

}
