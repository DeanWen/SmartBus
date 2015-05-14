package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import model.Estimation;
import model.PAAC;

public class predicationAction extends Action {
	public predicationAction() {
	}

	public String getName() {
		return "predication.do";
	}

	public String perform(HttpServletRequest request) {
		List<String> errors = new ArrayList<String>();
		request.setAttribute("errors", errors);
		String stopid = request.getParameter("stopid").trim();
		try {
			PAAC paac = new PAAC();
			ArrayList<Estimation> elist = paac.getPrediction(stopid);
			request.setAttribute("esti", elist);
			
			return "predication.jsp";
		} catch (Exception e) {
			errors.add(e.getMessage());
			return "index.jsp";
		}
	}
}
