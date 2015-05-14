package controller;

import javax.servlet.http.HttpServletRequest;

public class ShowMap extends Action {

	public ShowMap() {
		
	}
	
	public String getName() { return "showMap.do"; }
    
    public String perform(HttpServletRequest request) {
    	String curLat = "40.4424925";
    	String curLng = "-79.9425528";
    	String destLat = "40.4642993";
    	String destLng = "-79.97742099999999";
    
    	request.setAttribute("curLat", curLat);
    	request.setAttribute("curLng", curLng);
    	request.setAttribute("destLat", destLat);
    	request.setAttribute("destLng", destLng);
    	
    	
    	return "map.jsp";

    }
}
