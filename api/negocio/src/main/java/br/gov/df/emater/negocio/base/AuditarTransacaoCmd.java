package br.gov.df.emater.negocio.base;

import java.security.Principal;
import java.util.Arrays;
import java.util.Collection;
import java.util.function.Consumer;
import java.util.stream.StreamSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.frazao.cadeiaresponsabilidade.Comando;
import br.com.frazao.cadeiaresponsabilidade.Contexto;
import br.gov.df.emater.repositorio_principal.dao.sistema.UsuarioDAO;
import br.gov.df.emater.repositorio_principal.entidade.Auditavel;
import br.gov.df.emater.repositorio_principal.entidade.Identificavel;
import br.gov.df.emater.repositorio_principal.entidade.sistema.Usuario;

@Component
public class AuditarTransacaoCmd extends Comando {

	private Consumer<Object> auditarSePossivel = (obj) -> {
		if (obj instanceof Auditavel) {
			if (!(obj instanceof Identificavel)
					|| ((obj instanceof Identificavel) && ((Identificavel) obj).getId() == null)) {
				if ((((Auditavel) obj).getCriadoUsuarioId() == null)) {
					((Auditavel) obj).setCriadoUsuarioId(this.usuario.getId());
				}
			}
			if (((Auditavel) obj).getAtualizadoUsuarioId() == null) {
				((Auditavel) obj).setAtualizadoUsuarioId(this.usuario.getId());
			}
		}
	};

	@Autowired
	private UsuarioDAO dao;

	private Usuario usuario;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected void procedimento(Contexto<?, ?> contexto) throws Exception {
		if (contexto.get("usuario") != null) {
			usuario = dao.findByLogin(((Principal) contexto.get("usuario")).getName());
			if (usuario == null) {
				throw new NegocioException("Usuário inválido! [%s]", contexto.get("usuario"));
			}
			synchronized (usuario) {				
				Object req = contexto.getRequisicao();
				if (req != null) {
					if (req instanceof Object[]) {
						Arrays.stream((Object[]) req).forEach(auditarSePossivel);
					} else if (req instanceof Collection) {
						((Collection) req).stream().forEach(auditarSePossivel);
						// } else if (req instanceof Map) {
						// ((Map) req).entrySet().stream().forEach(auditarSePossivel);
					} else if (req instanceof Iterable) {
						StreamSupport.stream(((Iterable) req).spliterator(), false).forEach(auditarSePossivel);
					} else {
						auditarSePossivel.accept(req);
					}
				}
			}
		}
	}

}
