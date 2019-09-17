package br.gov.df.emater.repositorio_principal.entidade;

import java.util.Arrays;
import java.util.concurrent.atomic.AtomicInteger;

public interface Ordenavel {

	public Integer getOrdem();

	default void reordenar(Iterable<Ordenavel> ordenaveis) {
		AtomicInteger ordem = new AtomicInteger(0);
		ordenaveis.forEach(o -> o.setOrdem(ordem.incrementAndGet()));
	}

	default void reordenar(Ordenavel... ordenaveis) {
		reordenar(Arrays.asList(ordenaveis));
	}

	default Ordenavel reordenar(Ordenavel ordenavel) {
		Integer ordem = ordenavel.getOrdem();
		ordenavel.setOrdem(this.getOrdem());
		this.setOrdem(ordem);
		return this;
	}

	public void setOrdem(Integer ordem);

}
