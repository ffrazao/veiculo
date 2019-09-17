package br.gov.df.emater.repositorio_principal.entidade.pessoa;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;
import br.gov.df.emater.repositorio_principal.entidade.Ativavel;
import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.Temporalizavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the relacionamento database table.
 * 
 */
@Inheritance(strategy = InheritanceType.JOINED)
@Entity
@Table(catalog = "pessoa")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Relacionamento extends EntidadeBase implements Serializable, Identificavel, Ativavel, Temporalizavel {

	private static final long serialVersionUID = 1L;

	@Enumerated(EnumType.STRING)
	private Confirmacao ativo;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Temporal(TemporalType.TIMESTAMP)
	private Calendar inicio;

	@ManyToOne
	@JoinColumn(name = "relacionamento_tipo_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private RelacionamentoTipo relacionamentoTipo;

	@Temporal(TemporalType.TIMESTAMP)
	private Calendar termino;

}