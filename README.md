# Lognalistics

A small library that analyses page visits.

## Requirements
- Docker

## How to run
Once inside directory you can run listed commands:

- To enter container and run commands from within run `make dev`.
- To run unit and integration tests against implementation run `make test`
- To run library against provided [webserver.log](https://github.com/elharion/lognalistics/blob/master/app/webserver.log) file, run `make task`. Which outputs results in **STDOUT**

## API

### Method
```ruby
Lognalistics::Processor.new.generate_statistics(file_path, metric_type, output)
```

### Input
|Field|Type|Description|
|-|-|-|
|file_path|String|Path to a file to be analysed|
|metric_type|Symbol|Metric type. Available values `:total_views`, `:unique_views`|
|output|Symbol|Output format for generated metrics. Available values: `:stdout`, `:json`|

### Output
 * For `:stdout` output, returns genrated metrics in **STDOUT**
 ```
/about/2 - visits: 90
/contact - visits: 89
/index - visits: 82
/about - visits: 81
/help_page/1 - visits: 80
/home - visits: 78
```
```
/help_page/1 - unique views: 23
/contact - unique views: 23
/home - unique views: 23
/index - unique views: 23
/about/2 - unique views: 22
/about - unique views: 21
 ```
* For `:json` output, returns generated metrics as JSON runtime return value*
```JSON
{ "result": [
  "/about/2 - visits: 90",
  "/contact - visits: 89",
  "/index - visits: 82",
  "/about - visits: 81",
  "/help_page/1 - visits: 80",
  "/home - visits: 78"
]}
```
```JSON
{ "result":[
  "/help_page/1 - unique views: 23",
  "/contact - unique views: 23",
  "/home - unique views: 23",
  "/index - unique views: 23",
  "/about/2 - unique views: 22",
  "/about - unique views: 21"
]}
```

## Additional Notes
:star: Test coverage report available [here](https://htmlpreview.github.io/?https://github.com/elharion/lognalistics/blob/master/app/coverage/index.html#_AllFiles).


