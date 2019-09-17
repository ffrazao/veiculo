package br.gov.df.emater.repositorio_principal.dominio;

public enum EvidenciaTipo {

	AUDIO("Áudio"), DOCUMENTO("Documento"), IMAGEM("Imagem"), VIDEO("Vídeo");

	private String descricao;

	private EvidenciaTipo(String descricao) {
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
