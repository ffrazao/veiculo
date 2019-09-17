package br.gov.df.emater.repositorio_principal.entidade.produto;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.entidade.Auditavel;
import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.Temporalizavel;
import br.gov.df.emater.repositorio_principal.entidade.principal.Produto;
import br.gov.df.emater.repositorio_principal.entidade.sistema.Usuario;
import lombok.AccessLevel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * The persistent class for the composicao database table.
 * 
 */
@Entity
@Table(catalog = "produto")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Composicao extends EntidadeBase implements Serializable, Identificavel, Auditavel, Temporalizavel {
	
	private static final long serialVersionUID = 1L;

	@Column(name = "atualizado_em", insertable = false, updatable = false)
	@Temporal(TemporalType.TIMESTAMP)
	@Setter(value = AccessLevel.PRIVATE)
	private Calendar atualizadoEm;

	@Transient
	private Usuario atualizadoUsuario;

	@Column(name = "atualizado_usuario_id")
	private Integer atualizadoUsuarioId;

	@Column(name = "criado_em", insertable = false, updatable = false)
	@Temporal(TemporalType.TIMESTAMP)
	@Setter(value = AccessLevel.PRIVATE)
	private Calendar criadoEm;
	
	@Transient
	private Usuario criadoUsuario;

	@Column(name = "criado_usuario_id", updatable = false)
	private Integer criadoUsuarioId;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Temporal(TemporalType.TIMESTAMP)
	private Calendar inicio;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "principal_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Produto principal;

	@ManyToOne
	@JoinColumn(name = "produto_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Produto produto;

	@Temporal(TemporalType.TIMESTAMP)
	private Calendar termino;

}