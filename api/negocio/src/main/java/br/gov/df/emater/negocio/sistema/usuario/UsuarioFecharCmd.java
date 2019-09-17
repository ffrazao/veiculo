package br.gov.df.emater.negocio.sistema.usuario;

import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.Comando;
import br.com.frazao.cadeiaresponsabilidade.Contexto;

@Component
public class UsuarioFecharCmd extends Comando {

	@Override
	protected void procedimento(Contexto<?, ?> ctx) throws Exception {
		ctx.setResposta("Frz!!!");
		System.out.println("Deu certo 3 !!!!");
	}

}
