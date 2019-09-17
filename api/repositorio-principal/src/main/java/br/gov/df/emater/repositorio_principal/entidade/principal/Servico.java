package br.gov.df.emater.repositorio_principal.entidade.principal;

import java.io.Serializable;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * The persistent class for the servico database table.
 * 
 */
@Entity
@Table(catalog = "principal")
@PrimaryKeyJoinColumn(name = "id", referencedColumnName = "id")
@DiscriminatorValue("Servico")
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Servico extends Item implements Serializable {

	private static final long serialVersionUID = 1L;

}