package br.gov.df.emater.repositorio_principal.entidade.comum;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.data.geo.Point;

import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.Nomeavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the arquivo database table.
 * 
 */
@Entity
@Table(catalog = "comum")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Arquivo extends EntidadeBase implements Serializable, Identificavel, Nomeavel {

	private static final long serialVersionUID = 1L;

	private String autores;

	@Lob
	private byte[] conteudo;

	@Temporal(TemporalType.TIMESTAMP)
	private Calendar data;

	@Lob
	private String descricao;

	private String extensao;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	private Point local;

	private String md5;

	private String nome;

	@Column(name = "tamanho_bytes")
	private int tamanhoBytes;

}