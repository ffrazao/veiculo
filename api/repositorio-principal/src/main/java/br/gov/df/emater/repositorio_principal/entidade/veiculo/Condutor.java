package br.gov.df.emater.repositorio_principal.entidade.veiculo;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import br.gov.df.emater.repositorio_principal.entidade.pessoa.PessoaFisica;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the Condutor database table.
 * 
 */
@Entity
@Table(catalog = "veiculo")
@PrimaryKeyJoinColumn(name = "id", referencedColumnName = "id")
@DiscriminatorValue("Condutor")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Condutor extends PessoaFisica implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "cnh_numero")
	private String cnhNumero;

	@Column(name = "cnh_categoria")
	private String cnhCategoria;

	@Column(name = "cnh_vencimento")
	@Temporal(TemporalType.DATE)
	private Calendar cnhVencimento;

	@Column(name = "cnh_imagem")
	@Lob
	private byte[] cnhImagem;

}
