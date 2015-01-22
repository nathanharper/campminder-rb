# InterExchange::CampMinder.rb

Library to interface InterExchange with the CampMinder ClientLink API.

:warning: **Sensitive Information** :warning:

We are using `.gitignore` to ensure that documentation and examples provided by
CampMinder are not shared, InterExchange Employees can get a branch with the examples
by contacting [@dirkkelly](https://github.com/dirkkelly).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'InterExchange-CampMinder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install InterExchange-CampMinder

## Usage

## Domain

### InterExchange::CampMinder

All Classes are namespaced within `InterExchange::CampMinder`, we're using example documentation
provided to us by CampMinder to build the domain, the InterExchange domain objects will be referenced
in tests, but won't be tied to this implementation.

### Partner

InterExchange is the partner, we're the system which is going to connect to CampMinder

### Client

A Camp is the Client, this is the place where the Staff are going to be working

### Person

A Camp's Contact is going to be a Person who authorizes the link between the Client and us, the Partner

### Staff

As a staffing partner we use the API to send Staff for the client.

## Testing

    $ bundle exec rspec


## Contributing

1. Fork it ( https://github.com/interexchange/campminder-rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## LICENCE

```
Copyright (c) 2015 InterExchange

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
