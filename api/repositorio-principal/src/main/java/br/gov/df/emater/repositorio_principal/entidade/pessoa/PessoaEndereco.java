package br.gov.df.emater.repositorio_principal.entidade.pessoa;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
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
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;
import br.gov.df.emater.repositorio_principal.dominio.Visibilidade;
import br.gov.df.emater.repositorio_principal.entidade.Auditavel;
import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.Ordenavel;
import br.gov.df.emater.repositorio_principal.entidade.Priorizavel;
import br.gov.df.emater.repositorio_principal.entidade.Visivel;
import br.gov.df.emater.repositorio_principal.entidade.comum.Endereco;
import br.gov.df.emater.repositorio_principal.entidade.principal.Pessoa;
import br.gov.df.emater.repositorio_principal.entidade.sistema.Usuario;
import lombok.AccessLevel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * The persistent class for the pessoa_endereco database table.
 * 
 */
@Entity
@Table(catalog = "pessoa", name = "pessoa_endereco")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class PessoaEndereco extends EntidadeBase implements Serializable, Identificavel, Auditavel, Ordenavel, Priorizavel, Visivel {
	
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name = "endereco_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Endereco endereco;

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

	private Integer ordem;

	@ManyToOne
	@JoinColumn(name = "pessoa_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Pessoa pessoa;

	@Enumerated(EnumType.STRING)
	private Confirmacao principal;

	@Enumerated(EnumType.STRING)
	private Visibilidade visibilidade;
	
}