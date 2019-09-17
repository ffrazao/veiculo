package br.gov.df.emater.negocio.sistema.usuario;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.Comando;
import br.com.frazao.cadeiaresponsabilidade.Contexto;
import br.gov.df.emater.repositorio_principal.dao.sistema.UsuarioDAO;
import br.gov.df.emater.transporte.sistema.UsuarioFiltroDTO;

@Component
public class UsuarioListarCmd extends Comando {

	@Autowired
	private UsuarioDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	protected void procedimento(Contexto<?, ?> ctx) throws Exception {
		if (ctx.getRequisicao() != null) {
			if (ctx.getRequisicao() instanceof Integer) {
				ctx.setResposta(dao.findById((Integer) ctx.getRequisicao()).orElse(null));
			} else if (ctx.getRequisicao() instanceof List) {
				ctx.setResposta(((List<Integer>) ctx.getRequisicao()).stream().map(id -> dao.findById(id).orElse(null)).collect(Collectors.toList()));
			} else {
				UsuarioFiltroDTO filtro = (UsuarioFiltroDTO) ctx.getRequisicao();
				ctx.setResposta(dao.findByFiltro(filtro));
			}
		} else {
			ctx.setResposta(dao.findAll());
		}
	}

}
