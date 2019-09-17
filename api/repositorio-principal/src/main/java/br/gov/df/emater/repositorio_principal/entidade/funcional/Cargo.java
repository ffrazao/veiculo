package br.gov.df.emater.repositorio_principal.entidade.funcional;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.Nomeavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the Cargo database table.
 * 
 */
@Entity
@Table(catalog = "funcional")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Cargo extends EntidadeBase implements Serializable, Identificavel, Nomeavel {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	
	private String nome;

}
