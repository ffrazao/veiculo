package br.gov.df.emater.repositorio_principal.dominio;

public enum TokenTipo {

	ACESSO("Acesso"), TROCAR_SENHA("Trocar Senha");

	private String descricao;

	private TokenTipo(String descricao) {
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
