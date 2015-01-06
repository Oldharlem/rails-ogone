# RailsOgone
## Description
This gem provides the bare minimum to integrate a simple Ogone form into your Rails app. It assumes basic knowledge of how Ogone works, and how it is configured for your project.

## Installation
In your Gemfile:
```
gem 'rails-ogone'
```
Or, from the commandline:
```
gem install rails-ogone
```
Once the gem is installed, in your Rails root dir:
```
rails g ogone:config
```
## Configuration
The generator should have created the ```config/ogone.yml``` configuration file. In it, you need to define your Ogone PSPID, and the configured SHA-in/out strings for each corresponding Rails environment:
```YAML
development: &development
  pspid: 'CHANGEME'
  sha_in: ''
  sha_out: ''

test:
  <<: *development

production:
  pspid: 'CHANGEME'
  sha_in: ''
  sha_out: ''
```

## Implementation in Rails
All you need to do is use the ```ogone_form_tag``` helper method in your Rails view, at the point where you implement your payment step:
```ERB
<%= ogone_form_tag do |f| %>
  <%= f.input 'ORDERID', 'BOGUS001' %>
  <%= f.input 'CURRENCY', 'EUR' %>
  <%= f.input 'LANGUAGE', 'nl_BE' %>
  <%= f.input 'ACCEPTURL', '' %>
  <%= f.input 'CANCELURL', '' %>
  <%= f.input 'DECLINEURL', '' %>
  <%= f.input 'EXCEPTIONURL', '' %>
  <%# AMOUNT can be a decimal value. This gem converts it accordingly to an int as per Ogone's requirements. %>
  <%= f.input 'AMOUNT', '37.99' %> 
  <%= f.input 'CN', 'Dave Lens' %>
  <%= f.input 'EMAIL', 'customer@example.com' %>
  <%= f.input 'OWNERCTY', 'BE' %>
  <%= f.input 'ECOM_SHIPTO_POSTAL_NAME_FIRST', 'Dave' %>
  <%= f.input 'ECOM_SHIPTO_POSTAL_NAME_LAST', 'Lens' %>
  <%= f.input 'ECOM_SHIPTO_POSTAL_COUNTRYCODE', 'BE' %>
  <%# ... %>
<% end %>
```
There is, purposefully, very little magic going on here. The SHASIGN and PSPID parameters are automatically added to your Ogone form as hidden fields. All other desired parameters must be added manually.

This will generate the following form markup in your development environment:
```html
<form action="https://secure.ogone.com/ncol/test/orderstandard.asp" method="post">
  <input type="hidden" value="CHANGEME" name="PSPID">
  <input type="hidden" value="BOGUS001" name="ORDERID">
  <input type="hidden" value="EUR" name="CURRENCY">
  <input type="hidden" value="nl_BE" name="LANGUAGE">
  <input type="hidden" value="" name="ACCEPTURL">
  <input type="hidden" value="" name="CANCELURL">
  <input type="hidden" value="" name="DECLINEURL">
  <input type="hidden" value="" name="EXCEPTIONURL">
  <input type="hidden" value="3799" name="AMOUNT">
  <input type="hidden" value="Dave Lens" name="CN">
  <input type="hidden" value="customer@example.com" name="EMAIL">
  <input type="hidden" value="BE" name="OWNERCTY">
  <input type="hidden" value="Dave" name="ECOM_SHIPTO_POSTAL_NAME_FIRST">
  <input type="hidden" value="Lens" name="ECOM_SHIPTO_POSTAL_NAME_LAST">
  <input type="hidden" value="BE" name="ECOM_SHIPTO_POSTAL_COUNTRYCODE">
  <input type="hidden" value="61573629B6A26EB3BA5E799BA0984EAB5787D27B" name="SHASIGN">
  ...
</form>
```
## Running tests
This gem uses RSpec (and optionally Guard) for its tests. So in your CLI, run the magic word to get them to run:
```bash
$ rspec
```
## What about non-Rails apps?
It's possible this gem will work in non-Rails apps, assuming you have the ```config/ogone.yml``` file in place (which the Rails generator would normally create for you). This is untested at the moment of writing, but if you want to give it a go, look at [lib/rails-ogone/helper.rb](https://github.com/davelens/rails-ogone/blob/master/lib/rails-ogone/helper.rb) to get you started.

## Copyright
Copyright (c) 2015 Dave Lens, released under the MIT license.
