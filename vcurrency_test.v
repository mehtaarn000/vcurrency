module vcurrency

fn test_build_query() {
	symbols := ["USD", "EUR", "PHP"]
    res := build_query(map{"start_date" : "2021-02-25", "end_date" : "2021-02-26", "base" : "INR"}, symbols)
	assert res == "https://api.exchangeratesapi.io/history?start_at=2021-02-25&end_at=2021-02-26&base=INR&symbols=USD,EUR,PHP"
}

fn test_get_data() {
	symbols := ["USD"]
    res := get_data(map{"start_date" : "2021-02-25", "end_date" : "2021-02-26", "base" : "INR"}, symbols)
	assert res.url == "https://api.exchangeratesapi.io/history?start_at=2021-02-25&end_at=2021-02-26&base=INR&symbols=USD"
	assert res.json_string == '{"rates":{"2021-02-26":{"USD":0.0135314357},"2021-02-25":{"USD":0.0137678222}},"start_at":"2021-02-25","base":"INR","end_at":"2021-02-26"}'
}