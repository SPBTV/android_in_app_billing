require 'factory_girl'

Dir[File.join(__dir__, 'factories/*')].each { |path| require path }
