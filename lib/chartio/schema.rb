require 'active_record'
require 'csv'

module Chartio
  class Schema

    ForeignKeyRelationship = Struct.new(
      :parent_table,
      :parent_primary_key,
      :child_table,
      :child_foreign_key,
      :polymorphic_field
    ) do

      def to_h
        {
          parent_table: self.parent_table,
          parent_primary_key: self.parent_primary_key,
          child_table: self.child_table,
          child_foreign_key: self.child_foreign_key,
          polymorphic_field: self.polymorphic_field
        }
      end
    end

    attr_accessor :formatter, :logger

    def initialize(formatter, logger = STDOUT)
      @formatter = formatter
      @logger    = logger
    end

    def output_report
      find_relationships do |record|
        begin
          @formatter << record
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
      models = ActiveRecord::Base.descendants
      models.each do |model|
        model.reflections.each do |assoc, assoc_reflect|
          relationship = case assoc_reflect.macro
            when :has_many
              has_many(model, assoc_reflect)
            when :belongs_to
              belongs_to(model, assoc_reflect)
            else
              nil
          end
          yield(relationship) if relationship
        end
      end
    end

    def has_many(model, association_reflection)
      # Were checking for polymorphic associations
      if association_reflection.options[:as]
        ForeignKeyRelationship.new(
          model.table_name,
          model.primary_key,
          association_reflection.table_name,
          association_reflection.foreign_key,
          association_reflection.type
        )
      end
    end

    def belongs_to(model, association_reflection)
      if !association_reflection.options[:polymorphic] &&
      !(model.name.include?("HABTM_") && association_reflection.name == :left_side)
        ForeignKeyRelationship.new(
          association_reflection.table_name,
          model.primary_key,
          model.table_name,
          association_reflection.foreign_key
        )
      end
    end

  end
end
