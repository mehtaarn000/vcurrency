# vcurrency

API wrapper (written in V) for https://api.exchangeratesapi.io/

## Installation
Use:

`v install mehtaarn000.vcurrency`

## Functions

The `get_data` function takes two arguments: `options (type map)` and `symbols (type array of strings)`.

`get_data` takes arguments: `start_date`, `end_date` (which can both be an empty string to get latest data), and `base` (default "EUR"). 

The `symbols` array should have all the symbols that you would like to get from the API. For example, "USD", "INR", "NZD" (default is all symbols).

## Example usage

Get raw JSON from the API (not reccommended)

```v
module main

import mehtaarn000.vcurrency

fn main() {
    data := vcurrency.get_data(map{"start_date" : "2021-02-25", "end_date" : "2021-02-26", "base" : "INR"}, ["USD", "CNY"])
    
    // To get the response
    println(data.json)

    // To parse the json data
    println(data.json["rates"])

    // To get the generated url
    println(data.url)

}
```

Use the `convert` function
`convert` takes three arguments. `base` (type string), amount (type f64), and symbols (type []string). It returns a `map[string]f64`.
```v
module main

import mehtaarn000.vcurrency

fn main() {
    data := vcurrency.convert("USD", 100, ["EUR", "INR"])
    println(data)
}
```