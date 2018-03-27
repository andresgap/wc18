begin
  defaults = YAML.load_file("#{Rails.root}/config/defaults.yml")
  DEFAULT_ADMINS = JSON.parse(defaults['admins'].to_json, object_class: OpenStruct)
  DEFAULT_TOURNAMENTS = JSON.parse(defaults['tournaments'].to_json, object_class: OpenStruct)
rescue Errno::ENOENT, Psych::SyntaxError
  Rails.logger.error 'An error occured while loading defaults.yml'
end
DEFAULT_ADMINS ||= []
DEFAULT_TOURNAMENTS ||= []
