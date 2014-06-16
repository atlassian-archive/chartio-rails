require 'csv'

module Chartio
  class CSVFormatter < Formatter

    attr_accessor :foreign_keys

    def initialize
      @foreign_keys = []
      @stringio = StringIO.open
      @csv = CSV.new(@stringio)
    end

    def foreign_key(incoming_foreign_key)
      @foreign_keys << incoming_foreign_key
    end

    def output_reoprt
      @csv << [
        "primary_key_table",
        "primary_key_column",
        "foreign_key_table",
        "foreign_key_column",
        "polymorphic_type"
      ]
    end

  end
end
