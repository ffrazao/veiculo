package br.gov.df.emater.repositorio_principal.dominio;

public enum Combustivel {

	DIESEL("Diesel"), ETANOL("Etanol"), GASOLINA("Gasolina");

	private String descricao;

	private Combustivel(String descricao) {
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
