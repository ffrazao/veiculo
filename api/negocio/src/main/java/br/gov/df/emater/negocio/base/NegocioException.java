package br.gov.df.emater.negocio.base;

public class NegocioException extends Exception {

	private static final long serialVersionUID = 1L;

	public NegocioException() {
		super();
	}

	public NegocioException(String message) {
		super(message);
	}

	public NegocioException(String mensagem, Object... itens) {
		this(String.format(mensagem, (Object[]) itens));
	}

	public NegocioException(String message, Throwable cause) {
		super(message, cause);
	}

	public NegocioException(String mensagem, Throwable cause, Object... itens) {
		this(String.format(mensagem, (Object[]) itens), cause);
	}

	public NegocioException(Throwable cause) {
		super(cause);
	}
}
