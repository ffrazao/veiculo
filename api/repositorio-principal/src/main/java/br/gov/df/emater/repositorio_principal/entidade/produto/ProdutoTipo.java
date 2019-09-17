package br.gov.df.emater.repositorio_principal.entidade.produto;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.PaiNomeavel;
import lombok.AccessLevel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * The persistent class for the produto_tipo database table.
 * 
 */
@Entity
@Table(catalog = "produto", name = "produto_tipo")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class ProdutoTipo extends EntidadeBase implements Serializable, Identificavel, PaiNomeavel<ProdutoTipo> {

	private static final long serialVersionUID = 1L;

	@OneToMany(mappedBy = "pai", fetch = FetchType.LAZY)
	@Setter(AccessLevel.PRIVATE)
	private List<ProdutoTipo> filhos;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	private String nome;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "pai_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private ProdutoTipo pai;

	@OneToMany(mappedBy = "produtoTipo")
	private List<ProdutoTipoMarca> produtoTipoMarcaList;

	public ProdutoTipo(Integer id) {
		setId(id);
	}

	public ProdutoTipo(Integer id, String nome, Integer pai) {
		this(id);
		setNome(nome);
		setPai(new ProdutoTipo(pai));
	}

}