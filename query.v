module vcurrency

// Builds a query for "https://api.exchangeratesapi.io/"
fn build_query(query map[string]string, symbols []string) string {
	mut url := "https://api.exchangeratesapi.io/"
	
	// Get data between two dates,
	// Else return latest data
	if query["start_date"] != "" && query["end_date"] == "" {
		query_start_date := query["start_date"]
		url += "$query_start_date?" 
	} else if query["start_date"] == "" && query["end_date"] == "" {
		url += "latest?"
	} else {
		query_start_date := query["start_date"]
		query_end_date := query["end_date"]
		url += "history?start_at=$query_start_date&end_at=$query_end_date"
	}

	// Default base is EUR  
	if query["base"] == "" {
		url += "&base=EUR"
	} else {
		query_base := query["base"]
		url += "&base=$query_base"
	}

	// Add currency symbols to url
	if symbols.len != 0 {
		mut symbol_string := "&symbols="
		for index, symbol in symbols {
			if index != symbols.len - 1 {
				symbol_string += "$symbol,"
			} else {
				symbol_string += "$symbol"
			}
		}
		url += symbol_string
	}

	return url
}