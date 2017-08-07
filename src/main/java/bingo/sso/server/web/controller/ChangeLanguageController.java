package bingo.sso.server.web.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.LocaleEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

@Controller
public class ChangeLanguageController {
	@RequestMapping(value = "locale/changelanguage")
	public @ResponseBody String changeLanguage(@RequestParam String new_lang, HttpServletRequest request,
			HttpServletResponse response) {
		String msg = "";
		try {
			LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
			if (localeResolver == null) {
				throw new IllegalStateException(
						"No LocaleResolver found: not in a DispatcherServlet request?");
			}

			LocaleEditor localeEditor = new LocaleEditor();
			localeEditor.setAsText(new_lang);
			localeResolver.setLocale(request, response,
					(Locale) localeEditor.getValue());

			msg = "Change Language Success!";
		} catch (Exception ex) {
			msg = "error";
		}
		return msg;
	}

}
