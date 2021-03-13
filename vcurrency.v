module vcurrency

import x.json2
import net.http

// Json object to structure data
struct JSONObject {
	pub: 
		json map[string]json2.Any
		url string
		json_string string
}

// Request data from API
// Return struct JSONObject
pub fn get_data(options map[string]string, symbols []string) JSONObject {
	url := build_query(options, symbols)
	resp := http.get(url) or { panic("Connection to server failed.") }
	raw_json := json2.raw_decode(resp.text) or { panic("Invalid JSON sent by server.") }

	object := JSONObject{raw_json.as_map(), url, raw_json.str()}
	return object
}

pub fn convert(base string, amount f64, symbol string) f64 {
	url := build_query(map{"start_date" : "", "end_date" : "", "base" : base}, [symbol])
	resp := http.get(url) or { panic("Connection to server failed.") }
	raw_json := json2.raw_decode(resp.text) or { panic("Invalid JSON sent by server.") }
	data := raw_json.as_map()["rates"].as_map()[symbol]
	return amount * f64(data.f64())
}

pub fn convert_on_date(base string, date string, amount f64, symbol string) f64 {
	url := build_query(map{"start_date" : date, "end_date" : "", "base" : base}, [symbol])
	resp := http.get(url) or { panic("Connection to server failed.") } 
	raw_json := json2.raw_decode(resp.text) or { panic("Invalid JSON sent by server.") }
	data := raw_json.as_map()["rates"].as_map()[symbol].str()
	return amount * f64(data.f64())
}