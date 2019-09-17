package br.gov.df.emater.repositorio_principal.entidade.comum;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the endereco database table.
 * 
 */
@Entity
@Table(catalog = "comum")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Endereco extends ReferenciaEspacial implements Serializable, Identificavel {

	private static final long serialVersionUID = 1L;

	private String cep;

	private String complemento;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@ManyToOne
	@JoinColumn(name = "localizacao_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Localizacao localizacao;

	private String logradouro;

	private String numero;

	@Lob
	@Column(name = "ponto_referencia")
	private String pontoReferencia;

}