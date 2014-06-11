require 'active_record'
require 'csv'

module Chartio
  class Schema

    attr_accessor :models

    def initialize
      @models = []
    end

    # TODO Polymorphic Associations
    # TODO Single Table Inheritance
    # TODO Has and Belongs To Many
    # TODO Need to create the ability to change how CSV and logs are written
    def crawl(csv_file_name, log_file_name)
      Rails.application.eager_load!

      log = File.open(log_file_name, "wb")
      csv = CSV.open(csv_file_name, "wb")
      csv << [
        "primary_key_table",
        "primary_key_column",
        "foreign_key_table",
        "foreign_key_column",
        "polymorphic",          # this should be a boolean field True or False
        "polymorphic_types"     # An array of types that are used
      ]

      find_relationships.each do |record|
        begin
          csv << record
        rescue => e
          log.puts "Encountered an error"
          log.puts e.message
          log.puts e.backtrace
        end
      end
      log.close
      csv.close
    end

    private

    def find_relationships
      @models = ActiveRecord::Base.decendants
      @models.each do |model|
        model.reflections.each do |assoc, assoc_reflect|
          if assoc_reflect.macro == :belongs_to
            yield([
              "#{model.table_name_prefix}#{model.table_name}#{model.table_name_suffix}",
              assoc_reflect.foreign_key,
              assoc_reflect.table_name,
              assoc_reflect.association_primary_key
            ])
          end
        end
      end
    end

  end
end
