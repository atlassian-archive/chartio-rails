require 'csv'

module Chartio
  class CSVFormatter < Formatter

    def initialize
      @stringio = StringIO.open
      @csv = CSV.new(@stringio)
      @csv << [
        "primary_key_table",
        "primary_key_column",
        "foreign_key_table",
        "foreign_key_column",
        "polymorphic",          # this should be a boolean field True or False
        "polymorphic_types"     # An array of types that are used
      ]
    end

    def write_foreign_key()
    end

    def output_reoprt
    end

  end
end
