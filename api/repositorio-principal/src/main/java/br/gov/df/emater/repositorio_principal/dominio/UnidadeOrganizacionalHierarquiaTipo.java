package br.gov.df.emater.repositorio_principal.dominio;

public enum UnidadeOrganizacionalHierarquiaTipo {
	
	GESTAO("Gestão"), ASSESSORAMENTO("Assessoramento");	

	private String descricao;

	private UnidadeOrganizacionalHierarquiaTipo(String descricao) {
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
