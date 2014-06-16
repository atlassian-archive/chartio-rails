module Chartio
  class TestFormatter

    attr_accessor :foreign_keys

    def initialize
      @foreign_keys = []
    end

    def <<(fk)
      @foreign_keys << fk
    end

    def output_report
      nil
    end

    def find_key(search_options = {})
      find(:find, search_options)
    end

    def find_keys(search_options = {})
      find(:find_all, search_options)
    end

    private

    def find(find_type, search_options)
      foreign_keys.send(find_type) { |x|
        search_options.inject(true) do |boolean, option|
          boolean && x.send(option[0]) == option[1]
        end
      }
    end
  end
end
