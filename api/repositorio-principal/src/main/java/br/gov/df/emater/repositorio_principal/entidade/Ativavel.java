package br.gov.df.emater.repositorio_principal.entidade;

import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;

public interface Ativavel {

	public Confirmacao getAtivo();
	
	public void setAtivo(Confirmacao confirmacao);
	
}
