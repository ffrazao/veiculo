package br.gov.df.emater.repositorio_principal.entidade.veiculo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.entidade.evento.Evento;
import br.gov.df.emater.repositorio_principal.entidade.funcional.UnidadeOrganizacional;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the Infracao database table.
 * 
 */
@Entity
@Table(catalog = "veiculo")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Infracao extends Evento implements Serializable {

	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name = "condutor_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Condutor condutor;

	@ManyToOne
	@JoinColumn(name = "lotacao_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private UnidadeOrganizacional lotacao;

	@Column(name = "aviso_condutor")
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar avisoCondutor;

	@Column(name = "limite_justificativa")
	@Temporal(TemporalType.DATE)
	private Calendar limiteJustificativa;

	@ManyToOne
	@JoinColumn(name = "orgao_autuador_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private OrgaoTransito orgaoAutuador;

	@Column(name = "envio_email")
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar envioEmail;

	@Column(name = "notificacao")
	@Temporal(TemporalType.DATE)
	private Calendar notificacao;

	@Column(name = "recebimento_boleto")
	@Temporal(TemporalType.DATE)
	private Calendar recebimentoBoleto;

	private BigDecimal valor;

	@Column(name = "vencimento")
	@Temporal(TemporalType.DATE)
	private Calendar vencimento;

	@Column(name = "pagamento")
	@Temporal(TemporalType.DATE)
	private Calendar pagamento;

}
