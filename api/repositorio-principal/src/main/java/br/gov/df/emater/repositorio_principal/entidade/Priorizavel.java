package br.gov.df.emater.repositorio_principal.entidade;

import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;

public interface Priorizavel {
	
	public Confirmacao getPrincipal();
	
	public void setPrincipal(Confirmacao nome);
	
}
