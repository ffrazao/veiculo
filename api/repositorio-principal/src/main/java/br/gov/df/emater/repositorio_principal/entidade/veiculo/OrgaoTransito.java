package br.gov.df.emater.repositorio_principal.entidade.veiculo;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.Nomeavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the OrgaoTransito database table.
 * 
 */
@Entity
@Table(catalog = "veiculo")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class OrgaoTransito extends EntidadeBase implements Serializable, Identificavel, Nomeavel {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Column(name = "nome")
	private String nome;

	@Column(name = "sigla")
	private String sigla;

	@Column(name = "unidade_federacao")
	private String unidadeFederacao;

	@Lob
	private String site;

}
