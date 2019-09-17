package br.gov.df.emater.repositorio_principal.entidade.funcional;

import java.io.Serializable;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.entidade.pessoa.GrupoSocial;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the UnidadeOrganizacional database table.
 * 
 */
@Entity
@Table(catalog = "funcional")
@PrimaryKeyJoinColumn(name = "id", referencedColumnName = "id")
@DiscriminatorValue("UnidadeOrganizacional")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class UnidadeOrganizacional extends GrupoSocial implements Serializable {

	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name = "empregador_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Empregador empregador;

	@ManyToOne
	@JoinColumn(name = "unidade_organizacional_tipo_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private UnidadeOrganizacionalTipo unidadeOrganizacionalTipo;

}
