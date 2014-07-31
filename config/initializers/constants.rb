require 'yaml'

Classes = YAML.load( File.open( "#{Rails.root}/config/classes.yml", 'r' ) )
