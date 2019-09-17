package br.gov.df.emater.repositorio_principal.entidade.funcional;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;
import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.Temporalizavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the UnidadeOrganizacionalGestor database table.
 * 
 */
@Entity
@Table(catalog = "funcional")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class UnidadeOrganizacionalGestor extends EntidadeBase implements Serializable, Identificavel, Temporalizavel {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	
	@ManyToOne
	@JoinColumn(name = "unidade_organizacional_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private UnidadeOrganizacional unidadeOrganizacional;
	
	@ManyToOne
	@JoinColumn(name = "empregado_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Empregado empregado;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar inicio;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar termino;
	
	@Enumerated(EnumType.STRING)
	private Confirmacao substituto;

}
