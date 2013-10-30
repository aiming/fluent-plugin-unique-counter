# Fluent unique counter plugin [![Build Status](https://travis-ci.org/aiming/fluent-plugin-unique-counter.png?branch=master)](https://travis-ci.org/aiming/fluent-plugin-unique-counter)

This plugin purpose is simple monitoring (countup only).
This was referred from [fluent-plugin-numeric-counter](https://github.com/tagomoris/fluent-plugin-numeric-counter). Thanks! :)

# Contributors

- [@takesato](https://github.com/takesato)
- [@futoase](https://github.com/futoase)

## Installation

Add this line to your application's Gemfile:

    gem 'fluent-plugin-unique-counter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-unique-counter

## How to use

- create fluentd config file

```
<source>
  type forward
  port 24224
</source>

<match test.api.*>
  type unique_counter
  tag count.up
  unique_key user_id
  unit minutes
</match>

<match count.up>
  type file
  path fluent/count-up.log
</match>
```

- send test data

```
echo '{"user_id": 1000}' | fluent-cat test.api.uga
echo '{"user_id": 1000}' | fluent-cat test.api.uga
echo '{"user_id": 1000}' | fluent-cat test.api.uga
echo '{"user_id": 1002}' | fluent-cat test.api.uga
echo '{"user_id": 1002}' | fluent-cat test.api.uga
echo '{"user_id": 1003}' | fluent-cat test.api.uga
echo '{"user_id": 1003}' | fluent-cat test.api.uga
```

- result (count-up.log)

```
2013-10-21T22:07:08+09:00       count.up        {"unique_count":3}
```

## config params

- count_interval

  This interval time to monitoring. Default setting is ```60sec```.

- unit

  Monitoring specific interval an unit. Selectable setting is ```minutes```, ```hours``` and ```days```.

- unique_key

  Monitoring key name.

- tag

  Output tag name. Default setting is ```unique_count```.

## License

Apache License v2.0.

## Copylight

Copylight (c) 2013 Aiming Inc.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/aiming/fluent-plugin-unique-counter/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

