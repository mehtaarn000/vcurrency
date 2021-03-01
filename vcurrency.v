module vcurrency
import x.json2
import net.http

// Json object to structure data
pub struct JSONObject {
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
