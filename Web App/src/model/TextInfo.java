package model;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import databean.Routes;
import databean.Transit;

public class TextInfo {
	
	private final String Server = "https://maps.googleapis.com/maps/api/directions/json?mode=transit&alternatives=true";
	
	public ArrayList<Routes> getTripPlan (String ori, String dst) throws UnsupportedEncodingException, JSONException {
		ArrayList<Routes> list = new ArrayList<Routes> ();
		String url = Server  
				+ "&origin=" + URLEncoder.encode(ori, "UTF-8") 
				+ "&destination=" + URLEncoder.encode(dst, "UTF-8");
		//http://maps.googleapis.com/maps/api/directions/json?origin=Bartlett%20St,%20Pittsburgh&destination=Water%20front%20drive,Pittsburgh&sensor=false&departure_time=1343605500&mode=transit
		HttpHelper client = new HttpHelper("GET", url);
		client.excute();
		JSONArray routes = client.getData().getJSONArray("routes");
				
		for (int i = 0; i < routes.length(); ++i) {
			Routes oneItem = new Routes();
			JSONObject leg = routes.getJSONObject(i).getJSONArray("legs").getJSONObject(0);
			JSONArray steps = leg.getJSONArray("steps");
			
			

			for (int j = 0; j < steps.length(); ++j) {
				JSONObject step = steps.getJSONObject(j);
				if(step.get("travel_mode").toString().equals("TRANSIT")) {
					Transit tran = new Transit();
					tran.setNumStops(step.getJSONObject("transit_details").get("num_stops").toString());
					tran.setDistance(step.getJSONObject("distance").getString("text"));
					tran.setDuration(step.getJSONObject("duration").getString("text"));
					tran.setOriStop(step.getJSONObject("transit_details").getJSONObject("departure_stop").getString("name"));
					tran.setDestStop(step.getJSONObject("transit_details").getJSONObject("arrival_stop").getString("name"));
					tran.setBusline(step.getJSONObject("transit_details").getJSONObject("line").getString("short_name"));
					tran.setDepartTime(step.getJSONObject("transit_details").getJSONObject("departure_time").getString("text"));
					tran.setArrTime(step.getJSONObject("transit_details").getJSONObject("arrival_time").getString("text"));
					tran.setStartLat(step.getJSONObject("transit_details").getJSONObject("departure_stop").getJSONObject("location").get("lat").toString());
					tran.setStartLng(step.getJSONObject("transit_details").getJSONObject("departure_stop").getJSONObject("location").get("lng").toString());
					tran.setEndLat(step.getJSONObject("transit_details").getJSONObject("arrival_stop").getJSONObject("location").get("lat").toString());
					tran.setEndLng(step.getJSONObject("transit_details").getJSONObject("arrival_stop").getJSONObject("location").get("lng").toString());
					
					oneItem.getRoutes().add(tran);
				}
			}
			
			if (!oneItem.getRoutes().isEmpty())
			{
				oneItem.setOrigin(ori);
				oneItem.setDestination(dst);
				oneItem.setArrTime(leg.getJSONObject("arrival_time").getString("text"));
				oneItem.setDepartTime(leg.getJSONObject("departure_time").getString("text"));
				oneItem.setDistance(leg.getJSONObject("distance").getString("text"));
				oneItem.setDuration(leg.getJSONObject("duration").getString("text"));
				oneItem.setStartAddr(leg.getString("start_address"));
				oneItem.setEndAddr(leg.getString("end_address"));
				oneItem.setStartLat(leg.getJSONObject("start_location").get("lat").toString());
				oneItem.setEndLat(leg.getJSONObject("end_location").get("lat").toString());
				oneItem.setStartLng(leg.getJSONObject("start_location").get("lng").toString());
				oneItem.setStartLng(leg.getJSONObject("end_location").get("lng").toString());
				list.add(oneItem);
			}
		}
		return list;
	}
	public static void main(String[] args) {
		

	}

}
