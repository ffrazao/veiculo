package br.gov.df.emater.repositorio_principal.dao.principal.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import br.gov.df.emater.repositorio_principal.dao.principal.ProdutoDAOExtra;
import br.gov.df.emater.repositorio_principal.dominio.Confirmacao;
import br.gov.df.emater.repositorio_principal.entidade.principal.Produto;
import br.gov.df.emater.repositorio_principal.entidade.produto.Marca;
import br.gov.df.emater.repositorio_principal.entidade.produto.Modelo;
import br.gov.df.emater.repositorio_principal.entidade.produto.ProdutoTipo;
import br.gov.df.emater.transporte.principal.ProdutoFiltroDTO;

public class ProdutoDAOImpl implements ProdutoDAOExtra {

	@Autowired
	private EntityManager em;

	@SuppressWarnings("unchecked")
	@Override
	public Collection<Produto> findByFiltro(ProdutoFiltroDTO filtro) {
		Collection<Produto> result = new ArrayList<>();

		List<Object> param = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		sql.append("select    a.id as produto_id,").append("\n");
		sql.append("          a.numero_serie,").append("\n");
		sql.append("          b.id as modelo_id,").append("\n");
		sql.append("          b.nome as modelo_nome,").append("\n");
		sql.append("          b.descricao as modelo_descricao,").append("\n");
		sql.append("          c.id as produto_tipo_id,").append("\n");
		sql.append("          c.nome as produto_tipo_nome,").append("\n");
		sql.append("          c.pai_id as produto_tipo_pai_id,").append("\n");
		sql.append("          d.id as marca_id,").append("\n");
		sql.append("          d.nome as marca_nome,").append("\n");
		sql.append("          d.fabricante as marca_fabricante,").append("\n");
		sql.append("          d.pai_id as marca_pai_id").append("\n");
		sql.append("from      principal.produto a").append("\n");
		sql.append("join      produto.modelo b").append("\n");
		sql.append("on        b.id = a.modelo_id").append("\n");
		sql.append("join      produto.produto_tipo c").append("\n");
		sql.append("on        c.id = b.produto_tipo_id").append("\n");
		sql.append("left join produto.marca d").append("\n");
		sql.append("on        d.id = b.marca_id").append("\n");
		sql.append("where     1 = 1").append("\n");
		//sql.append("and       a.ativo = 'S'").append("\n");
		if (StringUtils.isNotBlank(filtro.getProdutoTipo())) {
			sql.append("and   c.nome like ?").append("\n");
			param.add(String.format("%%%s%%", filtro.getProdutoTipo()));
		}
		if (StringUtils.isNotBlank(filtro.getMarca())) {
			sql.append("and   d.nome like ?").append("\n");
			param.add(String.format("%%%s%%", filtro.getMarca()));
		}
		if (StringUtils.isNotBlank(filtro.getModelo())) {
			sql.append("and   b.nome like ?").append("\n");
			param.add(String.format("%%%s%%", filtro.getModelo()));
		}
		if (StringUtils.isNotBlank(filtro.getNumeroSerie())) {
			sql.append("and   a.numero_serie like ?").append("\n");
			param.add(String.format("%%%s%%", filtro.getNumeroSerie()));
		}
		Query query = em.createNativeQuery(sql.toString());
		int posicao = 0;
		for (Object p : param) {
			query.setParameter(++posicao, p);
		}
		for (Object[] linha : (List<Object[]>) query.getResultList()) {
			Produto p = new Produto();
			p.setId((Integer) linha[0]);
			p.setNumeroSerie((String) linha[1]);
			p.setModelo(new Modelo((Integer) linha[2], (String) linha[3], (String) linha[4],
					new ProdutoTipo((Integer) linha[5], (String) linha[6], (Integer) linha[7]),
					new Marca((Integer) linha[8], (String) linha[9], Confirmacao.valueOf(((Character) linha[10]).toString()) , (Integer) linha[11])));
			result.add(p);
		}

		return result;
	}

}
