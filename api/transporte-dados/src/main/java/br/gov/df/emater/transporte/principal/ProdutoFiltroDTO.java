package br.gov.df.emater.transporte.principal;

import br.gov.df.emater.transporte.FiltroDTO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class ProdutoFiltroDTO extends FiltroDTO {

	private String produtoTipo;

	private String marca;

	private String modelo;

	private String numeroSerie;

}
