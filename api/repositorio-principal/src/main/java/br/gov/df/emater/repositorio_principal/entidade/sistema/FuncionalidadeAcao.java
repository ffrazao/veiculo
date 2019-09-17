package br.gov.df.emater.repositorio_principal.entidade.sistema;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
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

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;
import br.gov.df.emater.repositorio_principal.dominio.FuncionalidadeAcaoConcedeAcessoA;
import br.gov.df.emater.repositorio_principal.entidade.Ativavel;
import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.Pai;
import lombok.AccessLevel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * The persistent class for the funcionalidade_acao database table.
 * 
 */
@Entity
@Table(catalog = "sistema", name = "funcionalidade_acao")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class FuncionalidadeAcao extends EntidadeBase
		implements Serializable, Identificavel, Ativavel, Pai<FuncionalidadeAcao> {
	
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name = "acao_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Acao acao;

	@Enumerated(EnumType.STRING)
	private Confirmacao ativo;

	@Column(name = "concede_acesso_a")
	@Enumerated(EnumType.STRING)
	private FuncionalidadeAcaoConcedeAcessoA concedeAcessoA;

	@Lob
	private String descricao;

	@OneToMany(mappedBy = "pai", fetch = FetchType.LAZY)
	@Setter(AccessLevel.PRIVATE)
	private List<FuncionalidadeAcao> filhos;

	@ManyToOne
	@JoinColumn(name = "funcionalidade_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Funcionalidade funcionalidade;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "pai_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private FuncionalidadeAcao pai;

}