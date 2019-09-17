package br.gov.df.emater.repositorio_principal.entidade.funcional;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.entidade.pessoa.Relacionamento;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the Emprego database table.
 * 
 */
@Entity
@Table(catalog = "funcional")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Emprego extends Relacionamento implements Serializable {

	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name = "empregador_cargo_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private EmpregadorCargo empregadorCargo;

	private String matricula;

}
