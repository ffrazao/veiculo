package br.gov.df.emater.repositorio_principal.dominio;

public enum ReferenciaEspacialTipo {

	ENDERECO("Endereço"), LOCALIZACAO("Localização");

	private String descricao;

	private ReferenciaEspacialTipo(String descricao) {
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
