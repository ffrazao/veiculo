package br.gov.df.emater.repositorio_principal.entidade.pessoa;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;
import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.NomeavelCodificavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the relacionamento_tipo database table.
 * 
 */
@Entity
@Table(catalog = "pessoa", name = "relacionamento_tipo")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class RelacionamentoTipo extends EntidadeBase implements Serializable, Identificavel, NomeavelCodificavel {

	private static final long serialVersionUID = 1L;

	private String codigo;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	private String nome;

	@Enumerated(EnumType.STRING)
	private Confirmacao temporal;

}