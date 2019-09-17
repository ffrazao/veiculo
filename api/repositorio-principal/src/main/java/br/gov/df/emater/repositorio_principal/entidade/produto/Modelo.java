package br.gov.df.emater.repositorio_principal.entidade.produto;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.Nomeavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the modelo database table.
 * 
 */
@Entity
@Table(catalog = "produto")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Modelo extends EntidadeBase implements Serializable, Identificavel, Nomeavel {

	private static final long serialVersionUID = 1L;

	@Lob
	private String descricao;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@ManyToOne
	@JoinColumn(name = "marca_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Marca marca;

	private String nome;

	@ManyToOne
	@JoinColumn(name = "produto_tipo_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private ProdutoTipo produtoTipo;

	public Modelo(Integer id, String nome, String descricao, ProdutoTipo produtoTipo) {
		setId(id);
		setNome(nome);
		setDescricao(descricao);
		setProdutoTipo(produtoTipo);
	}

	public Modelo(Integer id, String nome, String descricao, ProdutoTipo produtoTipo, Marca marca) {
		this(id, nome, descricao, produtoTipo);
		setMarca(marca);
	}

}