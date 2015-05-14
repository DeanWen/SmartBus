package model;



import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

public class HttpHelper {
	private JSONObject data;
	private HttpClient client;
	private HttpResponse res = null;
	private String url;
	private String method;
	
	public void excute() {
		client = HttpClientBuilder.create().build();
		try {
			if(method.equals("GET"))
			{
				res = client.execute(new HttpGet(url));
			}
			else 
			{
				res = client.execute(new HttpPost(url));
			}
			data = new JSONObject(EntityUtils.toString(res.getEntity()));
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	
	public HttpHelper(String sendWay, String address) {
		method = sendWay;
		url = address;
	}
	
	public JSONObject getData() {
		return data;
	}

	
	
}
