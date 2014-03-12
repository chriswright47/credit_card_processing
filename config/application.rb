# Here we require all of the files which are necessary for the specs and the application itself to run

Dir[File.dirname(__FILE__) + '/../app/helpers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../app/models/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../spec/data/*.rb'].each {|file| require file }