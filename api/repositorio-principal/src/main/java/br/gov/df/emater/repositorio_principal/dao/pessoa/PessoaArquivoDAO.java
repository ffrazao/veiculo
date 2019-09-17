package br.gov.df.emater.repositorio_principal.dao.pessoa;

import org.springframework.data.jpa.repository.JpaRepository;

import br.gov.df.emater.repositorio_principal.entidade.pessoa.PessoaArquivo;

public interface PessoaArquivoDAO extends JpaRepository<PessoaArquivo, Integer> {
}
