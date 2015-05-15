package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import model.AllBusStop;
import databean.BusStop;


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
