package model;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import databean.BusStop;

public class PAAC {
	private final String paacKey = "key=ziU2dVzq4CCXuRJJgTaHsiz6N&format=json";
	private final String paacServer = "http://realtime.portauthority.org/bustime/api/v2/";

	// get real-time vehicle for a bus line
	public String getVehicles (String route) {
		String method = "GET";
		String url = paacServer + "getvehicles?" + paacKey + "&rt=" + route;
		HttpUtil hu = new HttpUtil(method, url);
		hu.excute();
		return hu.getDataString();
	}
	
	// get available directions for a route
	public ArrayList<String> getDirections (String route) throws JSONException {
		String method = "GET";
		String url = paacServer + "getdirections?" + paacKey + "&rt=" + route;
		HttpUtil hu = new HttpUtil(method, url);
		hu.excute();
		
		ArrayList<String> dir = new ArrayList<String>();
		JSONArray dir_arr = hu.getData().getJSONObject("bustime-response").getJSONArray("directions");
		
		for (int i = 0; i < dir_arr.length(); ++i) 
			dir.add(dir_arr.getJSONObject(i).get("dir").toString());

		return dir;
	}
	
	// get all busstops for a route in one direction
	public HashMap<String, String> getStops (String route, String dir) throws JSONException {
		String method = "GET";
		String url = paacServer + "getstops?" + paacKey + "&rt=" + route + "&dir=" + dir;
		HttpUtil hu = new HttpUtil(method, url);
		hu.excute();
		
		HashMap<String, String> map = new HashMap<String, String>();
		JSONArray stops = hu.getData().getJSONObject("bustime-response").getJSONArray("stops");
		
		for (int i = 0; i < stops.length(); ++i) 
			map.put(stops.getJSONObject(i).get("stpnm").toString().toLowerCase(), 
					stops.getJSONObject(i).get("stpid").toString());
		
		return map;
	}
	
	// predict the time for a bus to a stop
	public ArrayList<Estimation> getPrediction (String stopid) throws JSONException {
		ArrayList<Estimation> res = new ArrayList<Estimation>();
		if (stopid == null) return res;
		
		String method = "GET";
		String url = paacServer + "getpredictions?" + paacKey + "&stpid=" + stopid;
		HttpUtil hu = new HttpUtil(method, url);
		hu.excute();
		
		JSONObject message = hu.getData().getJSONObject("bustime-response");
		
		if (message.has("error")) {
			return res;
		}
		
		JSONArray pred = message.getJSONArray("prd");
		for (int i = 0; i < pred.length(); i++) {
			Estimation e = new Estimation();
			e.setDes(pred.getJSONObject(i).get("des").toString());
			String[] DT = pred.getJSONObject(i).get("prdtm").toString().split("\\s+");
			if (DT[1].equalsIgnoreCase("DUE"))
				e.setRealTime("Arriving");
			else
				e.setRealTime(DT[1]);
			e.setRtdir(pred.getJSONObject(i).get("rtdir").toString());
			e.setRoute(pred.getJSONObject(i).get("rt").toString());
			e.setLeft(pred.getJSONObject(i).get("prdctdn").toString());
			res.add(e);
		}
		
		return res;
	}
	
	public String getCurrAddress (double lat, double lng) throws JSONException {
		String method = "GET";
		String url = "http://maps.googleapis.com/maps/api/geocode/json?latlng=" +
		Double.toString(lat) + "," + Double.toString(lng) + "&sensor=true_or_false";
		HttpUtil hu = new HttpUtil(method, url);
		hu.excute();
		return hu.getData().getJSONArray("results").getJSONObject(0).getString("formatted_address");
	}
	
	public ArrayList<BusStop> getAroundBusStop() throws JSONException {
		double lat = 40.4433;
		double lng = -79.9436;
		ArrayList<BusStop> stopList = new ArrayList<BusStop>();
		String method = "GET";
		String url = "https://maps.googleapis.com/maps/api/place/radarsearch/json?location="+
		Double.toString(lat) + "," + Double.toString(lng) + "&radius=500&types=bus_station&sensor=false&key=AIzaSyBRqN6BsdiUVqi2MlA41WKC_TTO40Zlw30";
		HttpUtil hu = new HttpUtil(method, url);
		hu.excute();
		
		JSONArray res = hu.getData().getJSONArray("results");
		for (int i = 0; i < 5; i++) {
			JSONObject obj = res.getJSONObject(i);
			JSONObject geo = obj.getJSONObject("geometry");
			JSONObject location = geo.getJSONObject("location");

			BusStop bs = new BusStop();
			String slat = Double.toString(location.getDouble("lat"));
			String slng = Double.toString(location.getDouble("lng"));
			String sname = getCurrAddress(location.getDouble("lat"), location.getDouble("lng"));
			bs.setLat(slat);
			bs.setLng(slng);
			bs.setStopName(sname);
			stopList.add(bs);
			System.out.println(sname + ", " + slat + "," + slng);
		}
				
		return stopList;

	}
	
	public ArrayList<BusStop> getBusStops(String route, boolean isInBound) {
		ArrayList<BusStop> res = new ArrayList<BusStop>();
		
		String method = "GET";
		String url = paacServer + "getstops?" + paacKey + "&rt=" + route + "&dir=" + (isInBound ? "INBOUND" : "OUTBOUND");
		
		HttpUtil hu = new HttpUtil(method, url);
		hu.excute();
		try {
			JSONArray stops = hu.getData().getJSONObject("bustime-response").getJSONArray("stops");
			for (int i = 0; i < stops.length(); i++) {
				JSONObject stop = stops.getJSONObject(i);
				BusStop tmp = new BusStop();
				tmp.setStopId(stop.getString("stpid"));
				tmp.setStopName(stop.getString("stpnm"));
				tmp.setLat(stop.get("lat").toString());
				tmp.setLng(stop.get("lon").toString());
				res.add(tmp);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	public static void main(String[] args) throws JSONException {
		try {
			URLEncoder.encode("", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		//unit test for getBusStops function
		String route = "61C";
		boolean isInBound = true;
		PAAC p = new PAAC();
		ArrayList<BusStop> res = p.getBusStops(route, isInBound);
		for(BusStop bs : res) {
			System.out.println(bs.getStopId() + ", " + bs.getStopName() + ", " + bs.getLat() + "," + bs.getLng());
		}
	}

}