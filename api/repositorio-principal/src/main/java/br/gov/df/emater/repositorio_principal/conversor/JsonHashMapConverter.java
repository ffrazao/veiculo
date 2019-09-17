package br.gov.df.emater.repositorio_principal.conversor;

import java.io.IOException;
import java.util.Map;

import javax.persistence.AttributeConverter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonHashMapConverter implements AttributeConverter<Map<String, Object>, String> {

	private static final Logger logger = LoggerFactory.getLogger(JsonHashMapConverter.class);

	private ObjectMapper objectMapper = new ObjectMapper();

	public JsonHashMapConverter() {
	}

	@Override
	public String convertToDatabaseColumn(Map<String, Object> objeto) {

		String json = null;
		try {
			json = objectMapper.writeValueAsString(objeto);
		} catch (final JsonProcessingException e) {
			logger.error("JSON writing error", e);
		}

		return json;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> convertToEntityAttribute(String json) {

		Map<String, Object> objeto = null;
		try {
			objeto = objectMapper.readValue(json, Map.class);
		} catch (final IOException e) {
			logger.error("JSON reading error", e);
		}

		return objeto;
	}

}
