package br.gov.df.emater.autorizador.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.oauth2.config.annotation.configurers.ClientDetailsServiceConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerEndpointsConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.approval.ApprovalStore;
import org.springframework.security.oauth2.provider.approval.JdbcApprovalStore;
import org.springframework.security.oauth2.provider.client.JdbcClientDetailsService;
import org.springframework.security.oauth2.provider.code.AuthorizationCodeServices;
import org.springframework.security.oauth2.provider.code.JdbcAuthorizationCodeServices;
import org.springframework.security.oauth2.provider.token.TokenEnhancer;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.security.oauth2.provider.token.store.JdbcTokenStore;

@Configuration
@EnableAuthorizationServer
public class AuthorizationServerConfig extends AuthorizationServerConfigurerAdapter {

	@Autowired
	private DataSource datasource;

	@Autowired
	private AuthenticationManager authenticationManager;

	@Autowired
	private TokenEnhancer tokenEnhancer;

	@Bean
	@Primary
	public JdbcClientDetailsService clientDetailsService() {// 4
		return new JdbcClientDetailsService(datasource);
	}

	@Bean
	public TokenStore tokenStore() {// 3
		return new JdbcTokenStore(datasource);
	}

	@Bean
	public ApprovalStore approvalStore() {// 1
		return new JdbcApprovalStore(datasource);
	}

	@Bean
	public AuthorizationCodeServices authorizationCodeServices() {// 2
		return new JdbcAuthorizationCodeServices(datasource);
	}

	@Override
	public void configure(ClientDetailsServiceConfigurer clients) throws Exception {
		clients.withClientDetails(clientDetailsService());
	}

	@Override
	public void configure(AuthorizationServerSecurityConfigurer oauthServer) throws Exception {

	}

	@Override
	public void configure(AuthorizationServerEndpointsConfigurer endpoints) throws Exception {
		endpoints.authenticationManager(authenticationManager).approvalStore(approvalStore())
				.authorizationCodeServices(authorizationCodeServices()).tokenStore(tokenStore())
				.tokenEnhancer(tokenEnhancer);
	}

}
