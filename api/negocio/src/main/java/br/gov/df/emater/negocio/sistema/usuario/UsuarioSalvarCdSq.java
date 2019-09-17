package br.gov.df.emater.negocio.sistema.usuario;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.CadeiaSequenciada;
import br.gov.df.emater.negocio.base.AuditarTransacaoCmd;

@Component("UsuarioSalvarCdSq")
public class UsuarioSalvarCdSq extends CadeiaSequenciada {

	@Autowired
	UsuarioSalvarCdSq(AuditarTransacaoCmd c1, UsuarioSalvarCmd c2) {
		super(c1, c2);
	}

}
