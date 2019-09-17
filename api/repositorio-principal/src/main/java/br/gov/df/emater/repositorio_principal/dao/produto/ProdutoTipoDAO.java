package br.gov.df.emater.repositorio_principal.dao.produto;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.produto.ProdutoTipo;

public interface ProdutoTipoDAO extends JpaRepository<ProdutoTipo, Integer> {

	List<ProdutoTipo> findByPai(Optional<ProdutoTipo> pai);
}