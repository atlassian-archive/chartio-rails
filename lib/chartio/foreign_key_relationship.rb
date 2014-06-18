module Chartio
  class ForeignKeyRelationship

    FIELDS = [
      :parent_table, :parent_primary_key, :child_table,
      :child_foreign_key, :polymorphic_field
    ]

    attr_accessor(*FIELDS)

    def initialize(*args)
      args.each_with_index do |ele, index|
        instance_variable_set("@#{FIELDS[index]}", ele)
      end
    end

    def to_a
      FIELDS.map { |x| self.send(x) }
    end

    def to_h
      FIELDS.inject({}) do |hash, element|
        hash[element] = self.send(element)
        hash
      end
    end

  end
end
