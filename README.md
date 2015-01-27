# CampMinder.rb

[![Circle CI](https://circleci.com/gh/interexchange/campminder-rb.svg?style=svg)](https://circleci.com/gh/interexchange/campminder-rb)
[![Code Climate](https://codeclimate.com/github/interexchange/campminder-rb/badges/gpa.svg)](https://codeclimate.com/github/interexchange/campminder-rb)
[![Test Coverage](https://codeclimate.com/github/interexchange/campminder-rb/badges/coverage.svg)](https://codeclimate.com/github/interexchange/campminder-rb)

Library to interface InterExchange with the [CampMinder](http://www.campminder.com) ClientLink API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'CampMinder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install CampMinder

## Configuration

Environment variables are used to configure your CampMinder credentials.

`CAMPMINDER_BUSINESS_PARTNER_ID`:
The integer ID of your company in CampMinder's system.

`CAMPMINDER_SECRET_CODE`:
The secret code of your company in CampMinder's system.

`CAMPMINDER_WEB_SERVICE_URL`:
A URL on CampMinder’s system to which you will send all
outgoing requests.

`CAMPMINDER_REDIRECTION_URL`:
A URL on CampMinder’s system to which you will redirect control as
the last step of the Connection Establishment procedure.

For local gem testing there is a `.env` file in this respository with
sample settings.

## Usage

### ClientLinkRequest

The first thing we would recommend doing is writing a spec. We use Rack::Test.
You can look at the specs for the [CampMinderHandler] for an example.

Next, create the route for your controller.

```
post 'camp_minder_handler', to: 'camp_minder_handler#create'
```

Then, make your CampMinderHandlerController, and extend the CampMinder::HandlerController.

```
class CampMinderHandlerController < ApplicationController
  include CampMinder::HandlerController
end
```

Your CampMinderHandlerController must implement three methods:

```
class CampMinderHandlerController < ApplicationController
  include CampMinder::HandlerController

  # return Boolean
  def valid_username_password?(username, password)
    @user = User.find_by_email(username)
    @user.present? && @user.valid_password?(password)
  end

  # return Integer
  def partner_client_id
    @user.company.id
  end

  # return Boolean
  def store_partner_client(partner_client_id, client_id, person_id, token, connection_status)
    PartnerClient.create(
      partner_client_id: partner_client_id,
      client_id: client_id,
      person_id: person_id,
      token: token,
      connection_status: connection_status
    ).valid?
  end
end
```

## Domain

### CampMinder

All Classes are namespaced within `CampMinder`, we're using example documentation
provided to us by CampMinder to build the domain tests.

### Partner

InterExchange is the partner, we're the system which is going to connect to CampMinder

### Client

A Camp is the Client, this is the place where the Staff are going to be working

### Person

A Camp's Contact is going to be a Person who authorizes the link between the Client and us, the Partner

### Staff

As a staffing partner we use the API to send Staff for the client.

## Testing

    $ rake

There is a dummy rails app at `spec/dummy`, the gems spec suite should be used to execute these tests, eg:

    rspec spec/dummy/spec/

## Contributing

1. Fork it ( https://github.com/interexchange/campminder-rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## LICENCE

`LICENSE.txt`

[CampMinderHandler]: https://github.com/interexchange/campminder-rb/blob/master/spec/dummy/spec/CampMinderHandler_spec.rb#L10-L130
