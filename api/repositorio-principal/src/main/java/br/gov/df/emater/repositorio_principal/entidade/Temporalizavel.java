package br.gov.df.emater.repositorio_principal.entidade;

import java.util.Calendar;

public interface Temporalizavel {
	
	public Calendar getInicio();
	
	public Calendar getTermino();
	
	public void setInicio(Calendar inicio);
	
	public void setTermino(Calendar termino);

}
