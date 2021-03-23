module vcurrency

fn test_build_query() {
	symbols := ['USD', 'EUR', 'PHP']
	res := build_query(map{
		'start_date': '2021-02-25'
		'end_date':   '2021-02-26'
		'base':       'INR'
	}, symbols)
	assert res == 'https://api.exchangeratesapi.io/history?start_at=2021-02-25&end_at=2021-02-26&base=INR&symbols=USD,EUR,PHP'
}

fn test_build_query2() {
	symbols := []string{}
	res := build_query(map{
		'start_date': ''
		'end_date':   ''
		'base':       'USD'
	}, symbols)
	assert res == 'https://api.exchangeratesapi.io/latest?&base=USD'
}
