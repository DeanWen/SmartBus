package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.AllBusStop;
import model.PAAC;
import model.TextInfo;

import org.mybeans.form.FormBeanFactory;

import databean.BusStop;
import databean.Routes;


public class nearmeAction extends Action {

	public nearmeAction() {
	}

	public String getName() {
		return "nearme.do";
	}

	public String perform(HttpServletRequest request) {
		List<String> errors = new ArrayList<String>();
		request.setAttribute("errors", errors);

		try {
			PAAC paac = new PAAC();
			AllBusStop abs = new AllBusStop();
			ArrayList<BusStop> res = abs.getNearByStops();
			request.setAttribute("BusStops", res);

			return "nearmetext.jsp";
		} catch (Exception e) {
			errors.add(e.getMessage());
			return "index.jsp";
		}
	}
}
