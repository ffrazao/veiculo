package br.gov.df.emater.negocio.sistema.usuario;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.CadeiaSequenciada;

@Component("UsuarioCriarCdSq")
public class UsuarioCriarCdSq extends CadeiaSequenciada {

	@Autowired
	UsuarioCriarCdSq(UsuarioCriarCmd c1) {
		super(c1);
	}

}
