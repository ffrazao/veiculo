package br.gov.df.emater.repositorio_principal.dominio;

public enum PessoaFisicaSexo {

	F("Feminino"), M("Masculino");

	private String descricao;

	private PessoaFisicaSexo(String descricao) {
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
