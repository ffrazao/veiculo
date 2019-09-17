package br.gov.df.emater.repositorio_principal.entidade.evento;

import java.io.Serializable;
import java.util.Calendar;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.data.geo.Point;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.Pai;
import br.gov.df.emater.repositorio_principal.entidade.Temporalizavel;
import br.gov.df.emater.repositorio_principal.entidade.principal.Item;
import lombok.AccessLevel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * The persistent class for the Evento database table.
 * 
 */
@Inheritance(strategy = InheritanceType.JOINED)
@Entity
@Table(catalog = "evento")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Evento extends EntidadeBase implements Serializable, Identificavel, Temporalizavel, Pai<Evento> {

	private static final long serialVersionUID = 1L;

	@Lob
	private String descricao;

	@OneToMany(mappedBy = "pai", fetch = FetchType.LAZY)
	@Setter(AccessLevel.PRIVATE)
	private List<Evento> filhos;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Temporal(TemporalType.TIMESTAMP)
	private Calendar inicio;

	@ManyToOne
	@JoinColumn(name = "item_id ")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Item item;

	private Point local;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "pai_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Evento pai;

	@Temporal(TemporalType.TIMESTAMP)
	private Calendar termino;

	@ManyToOne
	@JoinColumn(name = "tipo_id ")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Tipo tipo;

}