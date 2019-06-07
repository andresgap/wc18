begin
  defaults = YAML.load_file("#{Rails.root}/config/defaults/GC19.yml")
  DEFAULT_ADMINS = JSON.parse(defaults['admins'].to_json, object_class: OpenStruct)
  DEFAULT_PHASES = JSON.parse(defaults['phases'].to_json, object_class: OpenStruct)
  DEFAULT_TEAMS = JSON.parse(defaults['teams'].to_json, object_class: OpenStruct)
  DEFAULT_MATCHES = JSON.parse(defaults['matches'].to_json, object_class: OpenStruct)
rescue Errno::ENOENT, Psych::SyntaxError
  Rails.logger.error 'An error occured while loading defaults.yml'
end
DEFAULT_ADMINS ||= []
DEFAULT_PHASES ||= []
DEFAULT_TEAMS ||= []
DEFAULT_TOURNAMENTS ||= []
