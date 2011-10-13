# Email addresses are notoriously difficult to validate.  The only real way is to
# try to send an email to the address and receive confirmation that it arrived.
# Clearly this is impractical most of the time.
#
# The regexp below is James Watts and Francisco Martin Moreno's one from
# http://fightingforalostcause.net/misc/2006/compare-email-regex.php
#
# There are better ones on that page but they displease Ruby.
#
# It's worth reading the discussion there.
class EmailFormatValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'is not an email address') unless
      value =~ /^([\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+\.)*[\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+@((((([a-z0-9]{1}[a-z0-9\-]{0,62}[a-z0-9]{1})|[a-z])\.)+[a-z]{2,6})|(\d{1,3}\.){3}\d{1,3}(\:\d{1,5})?)$/i
  end

end
