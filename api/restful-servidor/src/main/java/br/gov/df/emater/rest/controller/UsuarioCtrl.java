package br.gov.df.emater.rest.controller;

import java.net.URLDecoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import br.gov.df.emater.negocio.base.NegocioFacade;
import br.gov.df.emater.repositorio_principal.entidade.sistema.Usuario;
import br.gov.df.emater.transporte.sistema.UsuarioFiltroDTO;

@SuppressWarnings("unchecked")
@RestController()
@RequestMapping("usuario")
public class UsuarioCtrl {

	@Autowired
	protected NegocioFacade negocioFacade;

	@PostMapping()
	protected List<Usuario> alterar(@RequestBody(required = true) List<Usuario> registros) throws Exception {
		return (List<Usuario>) negocioFacade.executarComEscrita("UsuarioSalvarCdSq", registros);
	}

	@GetMapping(value = "/criar")
	protected Usuario criar(@RequestParam(name = "modelo", required = false) String modeloStr) throws Exception {
		Usuario modelo = null;
		if (modeloStr != null) {
			ObjectMapper om = new ObjectMapper();
			modelo = om.readValue(URLDecoder.decode(modeloStr.replace("+", "%2B"), "UTF-8").replace("%2B", "+"),
					Usuario.class);
		}
		return (Usuario) negocioFacade.executarSomenteLeitura("UsuarioCriarCdSq", modelo);
	}

	@DeleteMapping(value = "/{ids}")
	protected void excluir(@PathVariable(name = "ids", required = true) List<Integer> ids) throws Exception {
		negocioFacade.executarComEscrita("UsuarioExcluirCdSq", ids);
	}

	@PutMapping()
	protected List<Usuario> incluir(@RequestBody(required = true) List<Usuario> registros) throws Exception {
		return (List<Usuario>) negocioFacade.executarComEscrita("UsuarioSalvarCdSq", registros);
	}

	@GetMapping(value = "")
	protected List<Usuario> listar(@RequestParam(name = "filtro", required = false) String filtroStr) throws Exception {
		UsuarioFiltroDTO filtro = null;
		if (filtroStr != null) {
			ObjectMapper om = new ObjectMapper();
			filtro = om.readValue(URLDecoder.decode(filtroStr.replace("+", "%2B"), "UTF-8").replace("%2B", "+"),
					UsuarioFiltroDTO.class);
		}
		return (List<Usuario>) negocioFacade.executarSomenteLeitura("UsuarioListarCdSq", filtro);
	}

	@PostMapping(value = "/salvar")
	protected List<Usuario> salvar(@RequestBody(required = true) List<Usuario> registros) throws Exception {
		return (List<Usuario>) negocioFacade.executarComEscrita("UsuarioSalvarCdSq", registros);
	}

	@GetMapping(value = "/{ids}")
	protected List<Usuario> ver(@PathVariable(name = "ids", required = true) List<Integer> ids) throws Exception {
		return (List<Usuario>) negocioFacade.executarSomenteLeitura("UsuarioListarCdSq", ids);
	}
}
