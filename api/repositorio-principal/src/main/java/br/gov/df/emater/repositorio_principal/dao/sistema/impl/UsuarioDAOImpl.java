package br.gov.df.emater.repositorio_principal.dao.sistema.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import br.gov.df.emater.repositorio_principal.dao.sistema.UsuarioDAOExtra;
import br.gov.df.emater.repositorio_principal.entidade.sistema.Usuario;
import br.gov.df.emater.transporte.sistema.UsuarioFiltroDTO;

public class UsuarioDAOImpl implements UsuarioDAOExtra {

	@Autowired
	private EntityManager em;

	@Override
	public Collection<Usuario> findByFiltro(UsuarioFiltroDTO filtro) {
		CriteriaBuilder builder = em.getCriteriaBuilder();
		CriteriaQuery<Usuario> criteria = builder.createQuery(Usuario.class);
		Root<Usuario> root = criteria.from(Usuario.class);
		List<Predicate> criteriaList = new ArrayList<>();
		if (StringUtils.isNotBlank(filtro.getEmail())) {
			criteriaList.add(builder.like(root.get("email"), String.format("%%%s%%", filtro.getEmail().replace(" ", "%"))));
		}
		if (StringUtils.isNotBlank(filtro.getLogin())) {
			criteriaList.add(builder.like(root.get("login"), String.format("%%%s%%", filtro.getLogin().replace(" ", "%"))));
		}
		if (StringUtils.isNotBlank(filtro.getNome())) {
			criteriaList.add(builder.like(root.get("nome"), String.format("%%%s%%", filtro.getNome().replace(" ", "%"))));
		}
		if (StringUtils.isNotBlank(filtro.getPerfil())) {
			criteriaList.add(builder.like(root.get("perfil"), String.format("%%%s%%", filtro.getPerfil().replace(" ", "%"))));
		}
		if (!criteriaList.isEmpty()) {
			criteria.where(builder.and(criteriaList.toArray(new Predicate[0])));
		}
		final TypedQuery<Usuario> query = em.createQuery(criteria);
		return query.getResultList();
	}

}
