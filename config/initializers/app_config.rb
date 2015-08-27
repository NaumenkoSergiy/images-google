require 'yaml'

yaml_data = YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 'application.yml'))).result)
yaml_data[Rails.env].each do |key, value|
  ENV[key.to_s] = value
end
