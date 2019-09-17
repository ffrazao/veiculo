package br.gov.df.emater.negocio.principal.produto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.CadeiaSequenciada;
import br.gov.df.emater.negocio.base.AuditarTransacaoCmd;

@Component("ProdutoSalvarCdSq")
public class ProdutoSalvarCdSq extends CadeiaSequenciada {

	@Autowired
	ProdutoSalvarCdSq(AuditarTransacaoCmd c1, ProdutoSalvarCmd c2) {
		super(c1, c2);
	}

}
