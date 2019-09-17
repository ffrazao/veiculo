package br.gov.df.emater.negocio.principal.produto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.CadeiaSequenciada;

@Component("ProdutoListarCdSq")
public class ProdutoListarCdSq extends CadeiaSequenciada {

	@Autowired
	ProdutoListarCdSq(ProdutoListarCmd c1) {
		super(c1);
	}

}
