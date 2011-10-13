require 'test_helper'
require 'pukka/email_format_validator'

class Thingy
  include ActiveModel::Validations
  attr_accessor :email
  validates :email, :email_format => true
end


class EmailFormatValidatorTest < Test::Unit::TestCase

  def setup
    @thingy = Thingy.new
  end

  def test_valid_formats
    %w[
      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@letters-in-local.org
      01234567890@numbers-in-local.net
      &'*+-./=?^_{}~@other-valid-characters-in-local.net
      mixed-1234-in-{+^}-local@sld.net
      a@single-character-in-local.org
      one-character-third-level@a.example.com
      single-character-in-sld@x.org
      local@dash-in-sld.com
      letters-in-sld@123.com
      one-letter-sld@x.org
      uncommon-tld@sld.museum
      uncommon-tld@sld.travel
      uncommon-tld@sld.mobi
      country-code-tld@sld.uk
      country-code-tld@sld.rw
      local@sld.newTLD
      local@sub.domains.com
    ].each do |email|
      @thingy.email = email
      assert @thingy.valid?, "#{email} should be valid"
    end
  end

  def test_valid_formats_incorrectly_judged_invalid
    %w[
      "quoted"@sld.com
      "\e\s\c\a\p\e\d"@sld.com
      "quoted-at-sign@sld.org"@sld.com
      "escaped\"quote"@sld.com
      "back\slash"@sld.com
      punycode-numbers-in-tld@sld.xn--3e0b707e
      bracketed-IP-instead-of-domain@[127.0.0.1]
      the-total-length@of-an-entire-address-cannot-be-longer-than-two-hundred-and-fifty-four-characters-and-this-address-is-254-characters-exactly-so-it-should-be-valid-and-im-going-to-add-some-more-words-here-to-increase-the-lenght-blah-blah-blah-blah-bla.org
    ].each do |email|
      @thingy.email = email
      assert @thingy.valid?, "#{email} should be valid"
    end
  end

  def test_invalid_formats
    %w[
      @missing-local.org
      !\ #$%`|@invalid-characters-in-local.org
      (),:;`|@more-invalid-characters-in-local.org
      <>@[]\`|@even-more-invalid-characters-in-local.org
      .local-starts-with-dot@sld.com
      local-ends-with-dot.@sld.com
      two..consecutive-dots@sld.com
      partially."quoted"@sld.com
      missing-sld@.com
      sld-starts-with-dashsh@-sld.com
      sld-ends-with-dash@sld-.com
      invalid-characters-in-sld@!\ "#$%(),/;<>_[]`|.org
      missing-dot-before-tld@com
      missing-tld@sld.
      invalid
      the-total-length@of-an-entire-address-cannot-be-longer-than-two-hundred-and-fifty-four-characters-and-this-address-is-255-characters-exactly-so-it-should-be-invalid-and-im-going-to-add-some-more-words-here-to-increase-the-lenght-blah-blah-blah-blah-bl.org
      missing-at-sign.net
      invalid-ip@127.0.0.1.26
    ].each do |email|
      @thingy.email = email
      assert !@thingy.valid?, "#{email} should not be valid"
    end
  end

  def test_invalid_formats_incorrectly_judged_valid
    %w[
      the-local-part-is-invalid-if-it-is-longer-than-sixty-four-characters@sld.net
      unbracketed-IP@127.0.0.1
      another-invalid-ip@127.0.0.256
      IP-and-port@127.0.0.1:25
    ].each do |email|
      @thingy.email = email
      assert !@thingy.valid?, "#{email} should not be valid"
    end
  end

end
