package br.gov.df.emater.negocio.sistema.usuario;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.Comando;
import br.com.frazao.cadeiaresponsabilidade.Contexto;
import br.gov.df.emater.repositorio_principal.dao.sistema.TokenDAO;
import br.gov.df.emater.repositorio_principal.dao.sistema.UsuarioDAO;

@Component
public class UsuarioAbrirCmd extends Comando {

	@Autowired
	private UsuarioDAO dao;

	@Autowired
	private TokenDAO tDao;

	@Override
	protected void procedimento(Contexto<?, ?> ctx) throws Exception {
		System.out.printf("Deu certo 1 !!!! total usuarios [%d] token [%d]", dao.count(), tDao.count());
	}

}
