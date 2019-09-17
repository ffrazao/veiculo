package br.gov.df.emater.repositorio_principal.entidade.sistema;

import java.io.Serializable;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Convert;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.conversor.JsonHashMapConverter;
import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;
import br.gov.df.emater.repositorio_principal.entidade.Ativavel;
import br.gov.df.emater.repositorio_principal.entidade.Auditavel;
import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.PaiNomeavelCodificavel;
import lombok.AccessLevel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * The persistent class for the configuracao database table.
 * 
 */
@Entity
@Table(catalog = "sistema")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Configuracao extends EntidadeBase
		implements Serializable, Identificavel, Ativavel, Auditavel, PaiNomeavelCodificavel<Configuracao> {

	private static final long serialVersionUID = 1L;

	@Enumerated(EnumType.STRING)
	private Confirmacao ativo;

	@Column(name = "atualizado_em", insertable = false, updatable = false)
	@Temporal(TemporalType.TIMESTAMP)
	@Setter(value = AccessLevel.PRIVATE)
	private Calendar atualizadoEm;

	@Transient
	private Usuario atualizadoUsuario;

	@Column(name = "atualizado_usuario_id")
	private Integer atualizadoUsuarioId;

	private String codigo;

	@Column(name = "criado_em", insertable = false, updatable = false)
	@Temporal(TemporalType.TIMESTAMP)
	@Setter(value = AccessLevel.PRIVATE)
	private Calendar criadoEm;

	@Transient
	private Usuario criadoUsuario;

	@Column(name = "criado_usuario_id", updatable = false)
	private Integer criadoUsuarioId;

	@Lob
	private String descricao;

	@OneToMany(mappedBy = "pai", fetch = FetchType.LAZY)
	@Setter(AccessLevel.PRIVATE)
	private List<Configuracao> filhos;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@ManyToOne
	@JoinColumn(name = "modulo_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Modulo modulo;

	private String nome;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "pai_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Configuracao pai;

	@ManyToOne
	@JoinColumn(name = "usuario_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Usuario usuario;

	@Lob
	@Convert(converter = JsonHashMapConverter.class)
	private Map<String, Object> valor;

}