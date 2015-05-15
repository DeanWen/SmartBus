package model;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;

import org.json.JSONException;

import databean.BusStop;
public class AllBusStop {
	
	private final static String filename = "https://s3.amazonaws.com/3.3/task/stops.txt";
	private final static double lat = 40.4433;
	private final static double lng = -79.9436;
	
	public ArrayList<BusStop> getAllBusStops() throws MalformedURLException {
		ArrayList<BusStop> list = new ArrayList<BusStop>();
		Scanner scanner = null;
		URL url = new URL(filename);
		int line = 0;
		try {
			scanner = new Scanner(url.openStream());
			while (scanner.hasNextLine()){
				String input = scanner.nextLine();
				line++;
				
				if(line == 1) continue;
				
				String[] inputArray = input.split(",");
				
				for(int i = 0; i < inputArray.length; i++) {
					String stopId = inputArray[1].trim();
					String stopName = inputArray[2].trim();
					String lat = inputArray[4].trim();
					String lng = inputArray[5].trim();
					
					
					BusStop bs = new BusStop();
					bs.setStopId(stopId);
					bs.setStopName(stopName);
					bs.setLat(lat);
					bs.setLng(lng);
					
					list.add(bs);
				}
			}
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
            if (scanner != null) {
                scanner.close();
            }
        }
		return list;
	}
	
	private static double distance(double lat1, double lon1, double lat2, double lon2, char unit) {
		double theta = lon1 - lon2;
		double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2))
				+ Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2))
				* Math.cos(deg2rad(theta));
		dist = Math.acos(dist);
		dist = rad2deg(dist);
		dist = dist * 60 * 1.1515;
		if (unit == 'K') {
			dist = dist * 1.609344;
		} else if (unit == 'N') {
			dist = dist * 0.8684;
		}
		return (dist);
	}

	private static double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
	}

	private static double rad2deg(double rad) {
		return (rad * 180 / Math.PI);
	}
	
	public ArrayList<BusStop> getNearByStops() throws JSONException, MalformedURLException {
		ArrayList<BusStop> list = new AllBusStop().getAllBusStops();
		HashMap<String, BusStop> nearBy = new HashMap<String, BusStop>();
		for(int i = 0; i < list.size(); i++) {
			BusStop bs = list.get(i);
			if (distance(Double.parseDouble(bs.getLat()), Double.parseDouble(bs.getLng()), lat, lng, 'K') < 0.5) {
				if (nearBy.size() <= 5 && !nearBy.containsKey(bs.getStopName())) {
					nearBy.put(bs.getStopName(), bs);
				}
			}	
		}
		
		ArrayList<BusStop> res = new ArrayList<BusStop>();
		Iterator<BusStop> iter = nearBy.values().iterator();
		while (iter.hasNext()) {
			BusStop bs = (BusStop) iter.next();
			res.add(bs);
		}
		
		return res;
	}
	
	public static void main(String[] args) throws JSONException, MalformedURLException{
		AllBusStop abs = new AllBusStop();
		ArrayList<BusStop> res = abs.getNearByStops();
		for(BusStop bs : res) {
			System.out.println(bs.getStopId() + ", " + bs.getStopName() + ", " + bs.getLat() + "," + bs.getLng());
		}
	}
}
