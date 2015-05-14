package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.TextInfo;


import org.mybeans.form.FormBeanFactory;


import databean.Routes;
import formbean.TripPlanForm;

public class BusTransitAction extends Action {
	private FormBeanFactory<TripPlanForm> formBeanFactory = FormBeanFactory
			.getInstance(TripPlanForm.class);

	public BusTransitAction() {
	}

	public String getName() {
		return "BusTransit.do";
	}

	public String perform(HttpServletRequest request) {
		List<String> errors = new ArrayList<String>();
		request.setAttribute("errors", errors);

		try {
			TripPlanForm form = formBeanFactory.create(request);
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
