package br.gov.df.emater.repositorio_principal.dominio;

public enum PessoaTipo {
	
	GS("Grupo Social"), PF("Pessoa Física") , PJ("Pessoa Jurídica");

	private String descricao;

	private PessoaTipo(String descricao) {
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}

	@Override
	public String toString() {
		return getDescricao();
	}

}
