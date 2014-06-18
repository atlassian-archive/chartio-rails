require 'active_record'
require 'csv'

module Chartio
  class Schema

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

    def foreign_key_method
      ActiveRecord::VERSION::STRING < '3.1.' ? :primary_key_name : :foreign_key
    end

    def polymorphic_type(association_reflection)
      if ActiveRecord::VERSION::STRING < '3.1.'
        association_reflection.klass.reflections[association_reflection.options[:as]].options[:foreign_type]
      else
        association_reflection.type
      end
    end

    def join_table(association_reflection)
      if ActiveRecord::VERSION::STRING < '4.1' && ActiveRecord::VERSION::STRING >= '4.0'
        association_reflection.join_table
      else
        association_reflection.options[:join_table]
      end
    end

    def find_relationships
      models = ActiveRecord::Base.descendants
      models.each do |model|
        model.reflections.each do |assoc, assoc_reflect|
          relationship = case assoc_reflect.macro
            when :has_many
              has_many(model, assoc_reflect)
            when :belongs_to
              belongs_to(model, assoc_reflect)
            when :has_and_belongs_to_many
              has_and_belongs_to_many(model, assoc_reflect)
            else
              nil
          end
          yield(relationship) if relationship
        end
      end
    end

    def has_and_belongs_to_many(model, association_reflection)
      if ActiveRecord::VERSION::STRING < '4.1.'
        ForeignKeyRelationship.new(
          model.table_name,
          model.primary_key,
          join_table(association_reflection),
          association_reflection.send(foreign_key_method)
        )
      end
    end

    def has_many(model, association_reflection)
      # Were checking for polymorphic associations
      if association_reflection.options[:as]
        ForeignKeyRelationship.new(
          model.table_name,
          model.primary_key,
          association_reflection.table_name,
          association_reflection.send(foreign_key_method),
          polymorphic_type(association_reflection)
        )
      end
    end

    def belongs_to(model, association_reflection)
      if !association_reflection.options[:polymorphic] &&
      !(model.name.include?("HABTM_") && association_reflection.name == :left_side)
        ForeignKeyRelationship.new(
          association_reflection.table_name,
          association_reflection.klass.primary_key,
          model.table_name,
          association_reflection.send(foreign_key_method)
        )
      end
    end

  end
end
