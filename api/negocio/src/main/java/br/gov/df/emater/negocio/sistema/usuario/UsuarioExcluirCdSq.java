package br.gov.df.emater.negocio.sistema.usuario;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.CadeiaSequenciada;

@Component("UsuarioExcluirCdSq")
public class UsuarioExcluirCdSq extends CadeiaSequenciada {

	@Autowired
	UsuarioExcluirCdSq(UsuarioExcluirCmd c1) {
		super(c1);
	}

}
