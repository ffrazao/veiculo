package br.gov.df.emater.repositorio_principal.entidade.sistema;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;
import br.gov.df.emater.repositorio_principal.entidade.Ativavel;
import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the usuario_perfil database table.
 * 
 */
@Entity
@Table(catalog = "sistema", name = "usuario_perfil")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class UsuarioPerfil extends EntidadeBase implements Serializable, Identificavel, Ativavel {

	private static final long serialVersionUID = 1L;

	@Enumerated(EnumType.STRING)
	private Confirmacao ativo;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Enumerated(EnumType.STRING)
	private Confirmacao padrao;

	@ManyToOne
	@JoinColumn(name="perfil_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Perfil perfil;

	@ManyToOne
	@JoinColumn(name="usuario_id")
	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	private Usuario usuario;

}