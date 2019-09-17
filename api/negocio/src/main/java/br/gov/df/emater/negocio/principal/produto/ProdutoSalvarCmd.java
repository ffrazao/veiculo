package br.gov.df.emater.negocio.principal.produto;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.Comando;
import br.com.frazao.cadeiaresponsabilidade.Contexto;
import br.gov.df.emater.repositorio_principal.dao.principal.ProdutoDAO;
import br.gov.df.emater.repositorio_principal.dao.produto.ModeloDAO;
import br.gov.df.emater.repositorio_principal.dominio.ItemTipo;
import br.gov.df.emater.repositorio_principal.entidade.principal.Produto;

@Component
public class ProdutoSalvarCmd extends Comando {

	@Autowired
	private ProdutoDAO dao;

	@Autowired
	private ModeloDAO modeloDao;

	@Override
	protected void procedimento(Contexto<?, ?> ctx) throws Exception {
		if (ctx.getRequisicao() instanceof Collection) {
			ctx.setResposta(((Collection<?>) ctx.getRequisicao()).stream()
					.map(reg -> dao.saveAndFlush(prepara((Produto) reg))).collect(Collectors.toList()));
		} else {
			ctx.setResposta(dao.saveAndFlush(prepara((Produto) ctx.getRequisicao())));
		}
	}

	private Produto prepara(Produto produto) {
		produto.setItemTipo(ItemTipo.PRODUTO);
		produto.setModelo(modeloDao.getOne(produto.getModelo().getId()));
		return produto;
	}

}
