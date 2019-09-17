package br.gov.df.emater.negocio.sistema.usuario;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.Comando;
import br.com.frazao.cadeiaresponsabilidade.Contexto;
import br.gov.df.emater.repositorio_principal.dao.sistema.UsuarioDAO;
import br.gov.df.emater.repositorio_principal.entidade.sistema.Usuario;

@Component
public class UsuarioSalvarCmd extends Comando {

	@Autowired
	private UsuarioDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	protected void procedimento(Contexto<?, ?> ctx) throws Exception {
		if (ctx.getRequisicao() instanceof Usuario) {
			ctx.setResposta(dao.saveAndFlush((Usuario) ctx.getRequisicao()));
		} else {
			ctx.setResposta(((List<Usuario>) ctx.getRequisicao()).stream().map(reg -> dao.saveAndFlush(reg))
					.collect(Collectors.toList()));
		}
	}

}
