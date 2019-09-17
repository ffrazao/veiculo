package br.gov.df.emater.repositorio_principal.entidade.sistema;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;
import br.gov.df.emater.repositorio_principal.entidade.Ativavel;
import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.NomeavelCodificavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the perfil database table.
 * 
 */
@Entity
@Table(catalog = "sistema")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Perfil extends EntidadeBase implements Serializable, Identificavel, NomeavelCodificavel, Ativavel {
	private static final long serialVersionUID = 1L;

	@Enumerated(EnumType.STRING)
	private Confirmacao administrador;

	@Enumerated(EnumType.STRING)
	private Confirmacao ativo;

	private String codigo;

	@Lob
	private String descricao;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	private String nome;

	@OneToMany(mappedBy = "perfil")
	private List<Privilegio> privilegioList;

}