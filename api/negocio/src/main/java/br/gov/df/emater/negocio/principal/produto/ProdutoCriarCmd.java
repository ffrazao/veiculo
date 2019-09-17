package br.gov.df.emater.negocio.principal.produto;

import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.Comando;
import br.com.frazao.cadeiaresponsabilidade.Contexto;
import br.gov.df.emater.repositorio_principal.entidade.principal.Produto;

@Component
public class ProdutoCriarCmd extends Comando {

	@Override
	protected void procedimento(Contexto<?, ?> ctx) throws Exception {
		ctx.setResposta(new Produto());
	}

}
