package br.gov.df.emater.repositorio_principal.entidade;

import java.util.Optional;

import javax.persistence.Transient;

public interface PaiNomeavel<T> extends Pai<T>, Nomeavel {

	@SuppressWarnings("unchecked")
	@Transient
	default String getNomeAscendente() {
		StringBuilder result = new StringBuilder();
		result.append(getNome());
		Optional.ofNullable(getPai())
				.ifPresent((v) -> result.append("/ ").append(((PaiNomeavel<T>) v).getNomeAscendente()));
		return result.toString();
	}

	@SuppressWarnings("unchecked")
	@Transient
	default String getNomeDescendente() {
		StringBuilder result = new StringBuilder();
		Optional.ofNullable(getPai())
				.ifPresent((v) -> result.append(((PaiNomeavel<T>) v).getNomeAscendente()).append("/ "));
		result.append(getNome());
		return result.toString();
	}

}
