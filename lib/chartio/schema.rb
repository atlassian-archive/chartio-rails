require 'active_record'
require 'csv'

module Chartio
  class Schema

    ForeignKeyRelationship = Struct.new(
      :parent_table,
      :parent_primary_key,
      :child_table,
      :child_foreign_key
    )

    attr_accessor :models, :formatter, :logger

    def initialize(formatter, logger = STOUT)
      @models    = []
      @formatter = formatter
      @logger    = logger
    end

    # TODO Polymorphic Associations
    # TODO Single Table Inheritance
    # TODO Has and Belongs To Many
    # TODO Need to create the ability to change how CSV and logs are written
    def output_report
      Rails.application.eager_load!

      find_relationships.each do |record|
        begin
          @formatter.write_foreign_key(record)
        rescue => e
          logger.puts "Encountered an error"
          logger.puts e.message
          logger.puts e.backtrace
        end
      end

      @formatter.output_report
    end

    private

    def find_relationships
      @models = ActiveRecord::Base.decendants
      @models.each do |model|
        model.reflections.each do |assoc, assoc_reflect|
          relationship = case assoc_reflect.macro
            when :belongs_to
              belongs_to(assoc, assoc_reflect)
            when :has_and_belongs_to_many
              has_and_belongs_to_many(assoc, assoc_reflect)
            when :has_one
              has_one(assoc, assoc_reflect)
          end
          yield(relationship) if relationship

          #if assoc_reflect.macro == :belongs_to
            #relationship = ForeignKeyRelationship.new(
            #)
            #yield(relationship)
            #yield([
              #"#{model.table_name_prefix}#{model.table_name}#{model.table_name_suffix}",
              #assoc_reflect.foreign_key,
              #assoc_reflect.table_name,
              #assoc_reflect.association_primary_key
            #])
          #end
        end
      end
    end

    def belongs_to(association, association_reflection)
      ForeignKeyRelationship.new(

      )
    end

    def has_and_belongs_to_many(association, association_reflection)
      ForeignKeyRelationship.new(

      )
    end

    def has_one(association, association_reflection)
      ForeignKeyRelationship.new(

      )
    end

  end
end
