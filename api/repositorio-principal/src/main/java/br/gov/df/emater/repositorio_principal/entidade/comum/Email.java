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
 * The persistent class for the email database table.
 * 
 */
@Entity
@Table(catalog = "comum")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Email extends EntidadeBase implements Serializable, Identificavel {

	private static final long serialVersionUID = 1L;

	private String dominio;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	private String usuario;

	@Transient
	public String getEmail() {
		return StringUtils.isBlank(usuario) || StringUtils.isBlank(dominio) ? ""
				: String.format("%s@%s", usuario, dominio);
	}

	@Transient
	public void setEmail(String email) {
		if (StringUtils.isBlank(email)) {
			this.usuario = null;
			this.dominio = null;
		} else {
			String[] parte = email.split("@");
			setEmail(parte[0], parte[1]);
		}
	}

	@Transient
	public void setEmail(String usuario, String dominio) {
		setUsuario(usuario);
		setDominio(dominio);
	}

}