package br.gov.df.emater.repositorio_principal.entidade.principal;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import br.gov.df.emater.repositorio_principal.dominio.PessoaTipo;
import br.gov.df.emater.repositorio_principal.entidade.Nomeavel;
import br.gov.df.emater.repositorio_principal.entidade.pessoa.PessoaArquivo;
import br.gov.df.emater.repositorio_principal.entidade.pessoa.PessoaEmail;
import br.gov.df.emater.repositorio_principal.entidade.pessoa.PessoaEndereco;
import br.gov.df.emater.repositorio_principal.entidade.pessoa.PessoaFoto;
import br.gov.df.emater.repositorio_principal.entidade.pessoa.PessoaTelefone;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the pessoa database table.
 * 
 */
@Entity
@Table(catalog = "principal")
@PrimaryKeyJoinColumn(name = "id", referencedColumnName = "id")
@DiscriminatorValue("Pessoa")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Pessoa extends Item implements Serializable, Nomeavel {

	private static final long serialVersionUID = 1L;

	private String nome;

	@OneToMany(mappedBy = "pessoa", fetch = FetchType.LAZY)
	private List<PessoaArquivo> pessoaArquivoList;

	@OneToMany(mappedBy = "pessoa", fetch = FetchType.LAZY)
	private List<PessoaEmail> pessoaEmailList;

	@OneToMany(mappedBy = "pessoa", fetch = FetchType.LAZY)
	private List<PessoaEndereco> pessoaEnderecoList;

	@OneToMany(mappedBy = "pessoa", fetch = FetchType.LAZY)
	private List<PessoaFoto> pessoaFotoList;

	@OneToMany(mappedBy = "pessoa", fetch = FetchType.LAZY)
	private List<PessoaTelefone> pessoaTelefoneList;

	@Enumerated(EnumType.STRING)
	@Column(name = "tipo")
	private PessoaTipo pessoaTipo;

}