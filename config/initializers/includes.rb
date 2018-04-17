Dir[Rails.root.join('app/modules/**/*.rb')].each { |f| require f }
