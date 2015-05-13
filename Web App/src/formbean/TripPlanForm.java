package formbean;


import java.util.List;
import java.util.ArrayList;

import org.mybeans.form.FormBean;

public class TripPlanForm extends FormBean {
	private String origin;
	private String destination;
	private String action;

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String v) {
		this.origin = v.trim();
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String v) {
		this.destination = v.trim();
	}

	public String getAction() {
		return action;
	}

	public void setAction(String v) {
		this.action = v;
	}

	public boolean isPresent() {
		return action != null;
	}

	public List<String> getValidationErrors() {
		List<String> errors = new ArrayList<String>();

		if (action == null) {
			errors.add("Please type and click the button");
		}

		if (errors.size() > 0)
			return errors;


		if ((origin == null || origin.length() == 0)
				|| (destination == null || destination.length() == 0)) {
			errors.add("Addresses are needed");
		}

		

		return errors;
	}
}