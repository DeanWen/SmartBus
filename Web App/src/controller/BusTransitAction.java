package controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import model.TextInfo;





import org.json.JSONException;
import org.mybeans.form.FormBeanFactory;





import databean.Routes;
import formbean.BusPlan;

public class BusTransitAction extends Action {
	private FormBeanFactory<BusPlan> formBeanFactory = FormBeanFactory
			.getInstance(BusPlan.class);

	public BusTransitAction() {
	}

	public String getName() {
		return "BusTransit.do";
	}

	public String perform(HttpServletRequest request) {
		if(request.getParameter("fav") != null) {
			String fav = request.getParameter("fav").trim();
			TextInfo text = new TextInfo();
			try {
				ArrayList<Routes> planList = text.getTripPlan("CMU,Pittsburgh, PA", fav);
				request.setAttribute("result", planList);
				request.setAttribute("origin", "CMU,Pittsburgh, PA");
				request.setAttribute("destination", fav);
			} catch (UnsupportedEncodingException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "text.jsp";
		}
		List<String> errors = new ArrayList<String>();
		request.setAttribute("errors", errors);

		try {
			BusPlan form = formBeanFactory.create(request);
			request.setAttribute("form", form);

			if (!form.isPresent()) {
				return "index.jsp";
			}

			errors.addAll(form.getValidationErrors());
			if (errors.size() != 0) {
				return "index.jsp";
			}

			TextInfo text = new TextInfo();
			ArrayList<Routes> planList = text.getTripPlan(form.getOrigin()+", Pittsburgh"+", PA"+"", form.getDestination()+", Pittsburgh"+", PA");
			request.setAttribute("result", planList);
			request.setAttribute("origin", form.getOrigin());
			request.setAttribute("destination", form.getDestination());
		
			return "text.jsp";
		} catch (Exception e) {
			errors.add(e.getMessage());
			return "index.jsp";
		}
	}
}
