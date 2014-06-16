module Chartio
  class Railtie < Rails::Railtie
    railtie_name :chartio

    rake_tasks do
      load "tasks/chartio.rake"
    end

    config.to_prepare do
      Rails.application.eager_load!
      puts "[WARNING] chartio-rails eager loads all of your models in development mode"
    end
  end
end
