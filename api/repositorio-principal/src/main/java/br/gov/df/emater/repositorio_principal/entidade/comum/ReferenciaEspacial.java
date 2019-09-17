package br.gov.df.emater.repositorio_principal.entidade.comum;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;

import org.springframework.data.geo.Polygon;

import br.gov.df.emater.repositorio_principal.dominio.ReferenciaEspacialTipo;
import br.gov.df.emater.repositorio_principal.entidade.EntidadeBase;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the referencia_espacial database table.
 * 
 */
@Inheritance(strategy = InheritanceType.JOINED)
@Entity
@Table(catalog = "comum", name = "referencia_espacial")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class ReferenciaEspacial extends EntidadeBase implements Serializable, Identificavel {
	
	private static final long serialVersionUID = 1L;

	private Polygon area;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Enumerated(EnumType.STRING)
	private ReferenciaEspacialTipo tipo;

}