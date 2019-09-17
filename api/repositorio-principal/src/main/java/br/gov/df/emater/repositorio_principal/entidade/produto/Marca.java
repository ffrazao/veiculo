package br.gov.df.emater.repositorio_principal.entidade.produto;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;
import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.PaiNomeavel;
import lombok.AccessLevel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * The persistent class for the marca database table.
 * 
 */
@Entity
@Table(catalog = "produto")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Marca extends EntidadeBase implements Serializable, Identificavel, PaiNomeavel<Marca> {

	private static final long serialVersionUID = 1L;

	@Enumerated(EnumType.STRING)
	private Confirmacao fabricante;

	@OneToMany(mappedBy = "pai", fetch = FetchType.LAZY)
	@Setter(AccessLevel.PRIVATE)
	private List<Marca> filhos;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Lob
	private byte[] logotipo;

	private String nome;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "pai_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Marca pai;

	public Marca(Integer id) {
		setId(id);
	}

	public Marca(Integer id, String nome, Confirmacao fabricante, Integer pai) {
		this(id);
		setNome(nome);
		setFabricante(fabricante);
		setPai(new Marca(pai));
	}

}