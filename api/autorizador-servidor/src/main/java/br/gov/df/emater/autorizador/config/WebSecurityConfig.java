package br.gov.df.emater.autorizador.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.BeanIds;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Bean(name = BeanIds.AUTHENTICATION_MANAGER)
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	@Override
	public UserDetailsService userDetailsServiceBean() throws Exception {
		return new JdbcUserDetails();
	}

	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/webjars/**", "/resources/**");
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()
			.anonymous().and()
			.authorizeRequests().antMatchers("/login", "/logout", "/logout.do", "/usuario").permitAll()
								.antMatchers(HttpMethod.OPTIONS).permitAll()
								.anyRequest().authenticated().and()
//			.formLogin().loginProcessingUrl("/login.do").usernameParameter("username").passwordParameter("password").loginPage("/login").and()
			//.formLogin().usernameParameter("username").passwordParameter("password").loginPage("/login").and()
			.logout().logoutRequestMatcher(new AntPathRequestMatcher("/logout.do"))
			//.and().userDetailsService(userDetailsServiceBean())
			;
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsServiceBean()).passwordEncoder(passwordEncoder());
	}
	
	public static void main(String[] args) {
		System.out.println(new WebSecurityConfig().passwordEncoder().encode("evbem_web"));
	}

}
