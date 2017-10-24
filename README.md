# Log reader for webhooks data type 

This script does a log analysis, and performs some parsers

# Language used
 Ruby - version 2.4.2 (see Gemfile)

## Dependencies
  - Ruby
  - Rspec
  
  To install the dependencies, use the bundler install command in the project root

# Tests

 The tests must be run with rspec:
 ```
 rspec spec /
 ```

## Usage

To run the program type in your command line
```
ruby bootstrap.rb log.txt
```

result example

```
{["https://eagerhaystack.com"]=>750, ["https://surrealostrich.com.br"]=>734, ["https://grimpottery.net.br"]=>732}
{["200"]=>1417, ["201"]=>1402, ["204"]=>1388, ["400"]=>1440, ["404"]=>1474, ["500"]=>1428, ["503"]=>1451}
```