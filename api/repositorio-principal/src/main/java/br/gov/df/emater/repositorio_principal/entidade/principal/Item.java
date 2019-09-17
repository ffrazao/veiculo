package br.gov.df.emater.repositorio_principal.entidade.principal;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;
import br.gov.df.emater.repositorio_principal.dominio.ItemTipo;
import br.gov.df.emater.repositorio_principal.entidade.Ativavel;
import br.gov.df.emater.repositorio_principal.entidade.Auditavel;
import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.sistema.Usuario;
import lombok.AccessLevel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * The persistent class for the item database table.
 * 
 */
@Inheritance(strategy = InheritanceType.JOINED)
@Entity
@Table(catalog = "principal")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Item extends EntidadeBase implements Serializable, Identificavel, Auditavel, Ativavel {

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

	@Column(name = "criado_em", insertable = false, updatable = false)
	@Temporal(TemporalType.TIMESTAMP)
	@Setter(value = AccessLevel.PRIVATE)
	private Calendar criadoEm;

	@Transient
	private Usuario criadoUsuario;

	@Column(name = "criado_usuario_id", updatable = false)
	private Integer criadoUsuarioId;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Enumerated(EnumType.STRING)
	@Column(name = "tipo")
	private ItemTipo itemTipo;

	@Lob
	private String observacao;

}