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

    def output_report
      @csv << Chartio::ForeignKeyRelationship::FIELDS.map(&:to_s)

      @foreign_keys.each do |key|
        @csv << key.to_a
      end

      @csv.string
    end

  end
end
