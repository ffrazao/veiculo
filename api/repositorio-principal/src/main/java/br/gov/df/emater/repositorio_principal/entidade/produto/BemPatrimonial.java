package br.gov.df.emater.repositorio_principal.entidade.produto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.entidade.principal.Pessoa;
import br.gov.df.emater.repositorio_principal.entidade.principal.Produto;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the bem_patrimonial database table.
 * 
 */
@Entity
@Table(catalog = "produto", name = "bem_patrimonial")
@PrimaryKeyJoinColumn(name = "id", referencedColumnName = "id")
@DiscriminatorValue("BemPatrimonial")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class BemPatrimonial extends Produto implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Lob
	private String observacao;

	@Column(name = "identificacao_patrimonial")
	private String identificacaoPatrimonial;
	
	@ManyToOne
	@JoinColumn(name = "pessoa_responsavel_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Pessoa pessoaResponsavel;

}