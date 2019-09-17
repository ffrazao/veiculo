package br.gov.df.emater.repositorio_principal.dao.comum;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.comum.Foto;

public interface FotoDAO extends JpaRepository<Foto, Integer> {
}