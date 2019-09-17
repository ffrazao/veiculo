package br.gov.df.emater.repositorio_principal.entidade.pessoa;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import br.gov.df.emater.repositorio_principal.dominio.PessoaFisicaSexo;
import br.gov.df.emater.repositorio_principal.entidade.principal.Pessoa;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the pessoa_fisica database table.
 * 
 */
@Entity
@Table(catalog = "pessoa", name = "pessoa_fisica")
@PrimaryKeyJoinColumn(name = "id", referencedColumnName = "id")
@DiscriminatorValue("PessoaFisica")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class PessoaFisica extends Pessoa implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private String cpf;

	@Temporal(TemporalType.DATE)
	private Date falecimento;

	@Temporal(TemporalType.DATE)
	private Date nascimento;

	@Enumerated(EnumType.STRING)
	private PessoaFisicaSexo sexo;

}