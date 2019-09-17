package br.gov.df.emater.autorizador.controller;

import static java.util.Arrays.asList;

import java.security.Principal;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.approval.Approval;
import org.springframework.security.oauth2.provider.approval.ApprovalStore;
import org.springframework.security.oauth2.provider.client.JdbcClientDetailsService;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by ahmed on 21.5.18.
 */
@Controller
public class LoginController {

	@Autowired
	private ApprovalStore approvalStore;

	@Autowired
	private JdbcClientDetailsService clientDetailsService;

	@Autowired
	private TokenStore tokenStore;

	@RequestMapping("/login")
	public String loginPage() {
		return "login";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public void logoutPage(HttpServletRequest request, HttpServletResponse response) {
		// remover sessões abertas
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		// remover do token store
		String authHeader = request.getHeader("Authorization");
		if (authHeader != null) {
			String tokenValue = authHeader.replace("Bearer", "").trim();
			OAuth2AccessToken accessToken = tokenStore.readAccessToken(tokenValue);
			if (accessToken != null) {
				tokenStore.removeAccessToken(accessToken);
			}
		}
	}

	@RequestMapping(value = "/approval/revoke", method = RequestMethod.POST)
	public String revokApproval(@ModelAttribute Approval approval) {

		approvalStore.revokeApprovals(asList(approval));
		tokenStore.findTokensByClientIdAndUserName(approval.getClientId(), approval.getUserId())
				.forEach(tokenStore::removeAccessToken);
		return "redirect:/";
	}

	@RequestMapping("/")
	public ModelAndView root(Map<String, Object> model, Principal principal) {

		List<Approval> approvals = clientDetailsService.listClientDetails().stream()
				.map(clientDetails -> approvalStore.getApprovals(principal.getName(), clientDetails.getClientId()))
				.flatMap(Collection::stream).collect(Collectors.toList());

		model.put("approvals", approvals);
		model.put("clientDetails", clientDetailsService.listClientDetails());
		return new ModelAndView("index", model);

	}

}
