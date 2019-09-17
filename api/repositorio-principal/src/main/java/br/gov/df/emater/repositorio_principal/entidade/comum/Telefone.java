package br.gov.df.emater.repositorio_principal.entidade.comum;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang.StringUtils;

import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the telefone database table.
 * 
 */
@Entity
@Table(catalog = "comum")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Telefone extends EntidadeBase implements Serializable, Identificavel {

	private static final long serialVersionUID = 1L;

	private String ddd;

	private String ddi;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	private String numero;

	@Transient
	public String getTelefone() {
		if (StringUtils.isBlank(this.numero)) {
			return "";
		}
		StringBuilder sb = new StringBuilder();
		if (!StringUtils.isBlank(this.ddd)) {
			if (!StringUtils.isBlank(this.ddi)) {
				sb.append(this.ddi.trim());
				sb.append(" ");
			}
			sb.append(this.ddd.trim());
			sb.append(" ");
		}
		if (sb.length() > 0) {
			sb = new StringBuilder(String.format("(%s) ", sb.toString().trim()));
		}
		sb.append(" ");
		sb.append(this.numero);
		return sb.toString().trim();
	}

	public void setDdd(String ddd) {
		if (ddd != null) {
			ddd = ddd.replaceAll("[^0-9]", "").replaceFirst("^0*", "");
		}
		this.ddd = StringUtils.isBlank(ddd) ? null : ddd;
	}

	public void setDdi(String ddi) {
		if (ddi != null) {
			ddi = ddi.replaceAll("[^0-9]", "").replaceFirst("^0*", "");
		}
		this.ddi = StringUtils.isBlank(ddi) ? null : ddi;
	}

	public void setNumero(String numero) {
		if (numero != null) {
			numero = numero.replaceAll("[^0-9]", "").replaceFirst("^0*", "");
			if (numero.length() < 9) {
				numero = numero.replaceFirst("(\\d{4})(\\d+)", "$1-$2");
			} else {
				numero = numero.replaceFirst("(\\d{5})(\\d+)", "$1-$2");
			}
		}
		this.numero = StringUtils.isBlank(numero) ? null : numero;
	}

	@Transient
	public void setTelefone(String telefone) {
		String ddi = null, ddd = null, numero = null;
		if (StringUtils.isNotBlank(telefone)) {
			if (telefone.contains(")")) {
				String[] parte = telefone.split(")");
				if (parte[0].contains(" ")) {
					String[] subparte = parte[0].split(" ");
					ddi = subparte[0];
					ddd = subparte[1];
				} else {
					ddd = parte[0];
				}
				numero = parte[1];
			} else {
				numero = telefone;
			}
		}
		setDdi(ddi);
		setDdd(ddd);
		setNumero(numero);
	}

	@Transient
	public void setTelefone(String ddi, String ddd, String numero) {
		setDdi(ddi);
		setDdd(ddd);
		setNumero(numero);
	}

}