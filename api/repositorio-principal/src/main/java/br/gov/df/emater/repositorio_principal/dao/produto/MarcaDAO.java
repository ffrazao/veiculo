package br.gov.df.emater.repositorio_principal.dao.produto;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.produto.Marca;

public interface MarcaDAO extends JpaRepository<Marca, Integer> {
}