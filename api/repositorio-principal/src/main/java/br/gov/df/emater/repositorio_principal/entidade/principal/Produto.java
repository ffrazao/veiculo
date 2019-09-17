package br.gov.df.emater.repositorio_principal.entidade.principal;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.entidade.produto.Composicao;
import br.gov.df.emater.repositorio_principal.entidade.produto.Modelo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the produto database table.
 * 
 */
@Entity
@Table(catalog = "principal")
@PrimaryKeyJoinColumn(name = "id", referencedColumnName = "id")
@DiscriminatorValue("Produto")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Produto extends Item implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name = "modelo_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Modelo modelo;

	@Column(name = "numero_serie")
	private String numeroSerie;
	
	@OneToMany(mappedBy = "principal", fetch = FetchType.LAZY)
	private List<Composicao> composicaoList;

}