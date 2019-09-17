package br.gov.df.emater.negocio.base;

import java.security.Principal;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.frazao.cadeiaresponsabilidade.Comando;
import br.com.frazao.cadeiaresponsabilidade.Contexto;
import br.com.frazao.cadeiaresponsabilidade.ContextoBase;

@Service
public class NegocioFacade implements BeanFactoryAware {

	public NegocioFacade() {
	}

//	@Bean
//	public NegocioFacade create() {
//		return new NegocioFacade();
//	}

	private BeanFactory beanFactory;

	private Object executar(String comandoNome, Object requisicao, Principal usuario, Contexto<String, Object> contexto)
			throws NegocioException {
		Comando comando = (Comando) this.beanFactory.getBean(comandoNome);
		if (comando == null) {
			throw new NegocioException("Comando não reconhecido pelo sistema [%s]", comandoNome);
		}
		if (contexto == null) {
			contexto = new ContextoBase<>();
		}
		contexto.put("comando", comando.getClass().getName());
		contexto.setRequisicao(requisicao);
		contexto.put("usuario", usuario);

		try {
			comando.executar(contexto);
		} catch (Exception e) {
			throw new NegocioException(e);
		}

		return contexto.getResposta();
	}

	@Transactional
	public Object executarComEscrita(String comando) throws NegocioException {
		return executar(comando, null, null, null);
	}

	@Transactional
	public Object executarComEscrita(String comando, Object requisicao) throws NegocioException {
		return executar(comando, requisicao, null, null);
	}

	@Transactional
	public Object executarComEscrita(String comando, Object requisicao, Principal usuario) throws NegocioException {
		return executar(comando, requisicao, usuario, null);
	}

	@Transactional
	public Object executarComEscrita(String comando, Object requisicao, Principal usuario,
			Contexto<String, Object> contexto) throws NegocioException {
		return executar(comando, requisicao, usuario, contexto);
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public Object executarComEscritaENovaTransacao(String comando) throws NegocioException {
		return executar(comando, null, null, null);
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public Object executarComEscritaENovaTransacao(String comando, Object requisicao) throws NegocioException {
		return executar(comando, requisicao, null, null);
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public Object executarComEscritaENovaTransacao(String comando, Object requisicao, Principal usuario)
			throws NegocioException {
		return executar(comando, requisicao, usuario, null);
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public Object executarComEscritaENovaTransacao(String comando, Object requisicao, Principal usuario,
			Contexto<String, Object> contexto) throws NegocioException {
		return executar(comando, requisicao, usuario, contexto);
	}

	@Transactional(readOnly = true, propagation = Propagation.REQUIRES_NEW)
	public Object executarSomenteLeitura(String comando) throws NegocioException {
		return executar(comando, null, null, null);
	}

	@Transactional(readOnly = true, propagation = Propagation.REQUIRES_NEW)
	public Object executarSomenteLeitura(String comando, Object requisicao) throws NegocioException {
		return executar(comando, requisicao, null, null);
	}

	@Transactional(readOnly = true, propagation = Propagation.REQUIRES_NEW)
	public Object executarSomenteLeitura(String comando, Object requisicao, Principal usuario) throws NegocioException {
		return executar(comando, requisicao, usuario, null);
	}

	@Transactional(readOnly = true, propagation = Propagation.REQUIRES_NEW)
	public Object executarSomenteLeitura(String comando, Object requisicao, Principal usuario,
			Contexto<String, Object> contexto) throws NegocioException {
		return executar(comando, requisicao, usuario, contexto);
	}

	@Override
	public void setBeanFactory(BeanFactory beanFactory) throws BeansException {
		this.beanFactory = beanFactory;
	}

}