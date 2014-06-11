require 'chartio-rails'
require 'rails'

module Chartio
  class Railtie < Rails::Railtie
    railtie_name :chartio

    rake_tasks do
      load "tasks/chartio.rake"
    end
  end
end
