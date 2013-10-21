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

## confing params

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
