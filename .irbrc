# Autocompletion on tab.
# In order for completion to work on Macs, install your ruby like this:
# brew install readline
# CONFIGURE_OPTS="-c --enable-shared -c --with-readline-dir=$(brew --prefix readline)" rbenv install ree-1.8.7-2011.03
require 'irb/completion'

#History configuration
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"

def clear
  system 'clear'
end

if false # if we want to display query log for all queries
  require 'logger'

  if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
    Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
  end
end
