package br.gov.df.emater.repositorio_principal.entidade;

import java.util.Calendar;

import br.gov.df.emater.repositorio_principal.entidade.sistema.Usuario;

public interface Auditavel {

	public Calendar getAtualizadoEm();

	public Usuario getAtualizadoUsuario();

	public Integer getAtualizadoUsuarioId();

	public Calendar getCriadoEm();

	public Usuario getCriadoUsuario();

	public Integer getCriadoUsuarioId();

	public void setAtualizadoUsuario(Usuario atualizadoUsuario);

	public void setAtualizadoUsuarioId(Integer atualizadoUsuarioId);

	public void setCriadoUsuario(Usuario criadoUsuario);

	public void setCriadoUsuarioId(Integer criadoUsuarioId);

}
