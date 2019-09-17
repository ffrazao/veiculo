package br.gov.df.emater.transporte;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class FiltroDTO implements DTO {

	private boolean chegouAoFim;

	private Integer pagina = 1;

	private Integer tamanho = 1000;

}
