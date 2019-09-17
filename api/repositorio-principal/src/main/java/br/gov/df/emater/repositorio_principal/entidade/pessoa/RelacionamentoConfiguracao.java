package br.gov.df.emater.repositorio_principal.entidade.pessoa;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the relacionamento_configuracao database table.
 * 
 */
@Entity
@Table(catalog = "pessoa", name = "relacionamento_configuracao")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class RelacionamentoConfiguracao extends EntidadeBase implements Serializable, Identificavel {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@ManyToOne
	@JoinColumn(name = "relacionado_funcao_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private RelacionamentoFuncao relacionadoFuncao;

	@ManyToOne
	@JoinColumn(name = "relacionador_funcao_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private RelacionamentoFuncao relacionadorFuncao;

	@ManyToOne
	@JoinColumn(name = "relacionamento_tipo_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private RelacionamentoTipo relacionamentoTipo;

}