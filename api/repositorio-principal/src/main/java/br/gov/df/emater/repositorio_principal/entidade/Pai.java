package br.gov.df.emater.repositorio_principal.entidade;

import java.util.Arrays;
import java.util.Collection;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

public interface Pai<T> {

	@SuppressWarnings("unchecked")
	public default void adicionarFilho(T t) {
		((Pai<T>) t).setPai((T) this);
		getFilhos().add(t);
	}

	@SuppressWarnings("unchecked")
	public default void adicionarFilho(T... ts) {
		Arrays.stream(ts).forEach(f -> adicionarFilho(f));
	}

	public Collection<T> getFilhos();

	@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
	@JsonIdentityReference(alwaysAsId = false)
	public T getPai();

	public default void removerFilho() {
		getFilhos().forEach(f -> this.removerFilho(f));
	}

	@SuppressWarnings("unchecked")
	public default void removerFilho(T t) {
		if (getFilhos().remove(t)) {
			((Pai<T>) t).setPai((T) null);
		}
	}

	public void setPai(T pai);

}
