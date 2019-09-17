package br.gov.df.emater.negocio.principal.produto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.CadeiaSequenciada;

@Component("ProdutoCriarCdSq")
public class ProdutoCriarCdSq extends CadeiaSequenciada {

	@Autowired
	ProdutoCriarCdSq(ProdutoCriarCmd c1) {
		super(c1);
	}

}
