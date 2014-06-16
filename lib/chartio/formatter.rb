module Chartio
  class Formatter

    def <<(incoming_foreign_key)
      foreign_key(incoming_foreign_key)
    end

    def foreign_key(incoming_foreign_key)
      raise NotImplementedError
    end

  end
end
