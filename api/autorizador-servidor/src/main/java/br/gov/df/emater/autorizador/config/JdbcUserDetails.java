package br.gov.df.emater.autorizador.config;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

/**
 * Created by Frazão
 */
public class JdbcUserDetails implements UserDetailsService {

	@Autowired
	private DataSource dataSource;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User result = null;
		try {
			Connection c = dataSource.getConnection();
			PreparedStatement ps = c
					.prepareStatement("select login, senha, ativo from sistema.usuario where login = ?");
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				result = new User(rs.getString("login"), rs.getString("senha"),
						"S".equalsIgnoreCase(rs.getString("ativo")), true, true, true,
						new ArrayList<GrantedAuthority>());
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		if (result == null) {
			throw new UsernameNotFoundException(username);
		}
		return result;
	}

}
