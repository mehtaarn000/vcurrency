module vcurrency

import x.json2
import net.http

// Json object to structure data
struct JSONObject {
pub:
	json        map[string]json2.Any
	url         string
	json_string string
}

// Used to validate dates sent to the API
fn validate_date(date string) bool {
	if date[4] != `-` {
		return false
	}

	if date[7] != `-` {
		return false
	}

	return true
}

// Request data from API
// Return struct JSONObject
// Can be, but not recommended, used to request data from the API
pub fn get_data(options map[string]string, symbols []string) JSONObject {
	url := build_query(options, symbols)
	resp := http.get(url) or { panic('Connection to server failed.') }
	raw_json := json2.raw_decode(resp.text) or { panic('Invalid JSON sent by server.') }

	object := JSONObject{raw_json.as_map(), url, raw_json.str()}
	return object
}

// Convert 1 or more currencies using the latest date
pub fn convert(base string, amount f64, symbols []string) map[string]f64 {
	url := build_query(map{
		'start_date': ''
		'end_date':   ''
		'base':       base
	}, symbols)
	resp := http.get(url) or { panic('Connection to server failed.') }
	raw_json := json2.raw_decode(resp.text) or { panic('Invalid JSON sent by server.') }

	if symbols.len == 1 {
		symbol := symbols[0]
		val := raw_json.as_map()['rates'].as_map()[symbol].f64()
		return map {"$symbol" : amount * val}
	}
	
	mut returnmap := map[string]f64{}

	for _, i in symbols {
		data := raw_json.as_map()['rates'].as_map()["$i"].f64()
		returnmap["$i"] = amount * data
	}
	return returnmap
}

// Convert 1 or more currencies using data from a specific date
pub fn convert_on_date(base string, date string, amount f64, symbols []string) map[string]f64 {
	checkdate := validate_date(date)

	if checkdate == false {
		panic('Date must be in YYYY-MM-DD format.')
	}

	url := build_query(map{"start_date" : date, "end_date" : "", "base" : base}, symbols)
	resp := http.get(url) or { panic('Connection to server failed.') }
	raw_json := json2.raw_decode(resp.text) or { panic('Invalid JSON sent by server.') }

	if symbols.len == 1 {
		symbol := symbols[0]
		val := raw_json.as_map()['rates'].as_map()[symbol].f64()
		return map {"$symbol" : amount * val}
	}
	
	mut returnmap := map[string]f64{}

	for _, i in symbols {
		data := raw_json.as_map()['rates'].as_map()["$i"].f64()
		returnmap["$i"] = amount * data
	}
	return returnmap
}
