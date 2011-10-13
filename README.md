# Pukka

Keep your data Pukka with these custom ActiveModel validators.


## Quick Start

Add `gem 'pukka'` to your Gemfile, run `bundle install`, then just use the validators in your models.

For example:

    class Person < ActiveRecord::Base
      validates :email, :email_format => true
    end


## Questions, Problems, Feedback

Please use the GitHub [issue tracker](https://github.com/airblade/pukka/issues) or email me.


## Intellectual property

Copyright 2011 Andy Stewart (boss@airbladesoftware.com).

Released under the MIT licence.
