ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :accounts do |t|
    t.string :name
  end

  create_table :account_histories do |t|
    t.integer :account_id
  end

  create_table :suppliers do |t|
    t.string :name
  end

  create_table :users do |t|
    t.string  :name
    t.integer :account_id
  end

  create_table :employees do |t|
    t.integer :manager_id
  end

  create_table :products do |t|
  end

  create_table :pictures do |t|
    t.integer :imageable_id
    t.string  :imageable_type
  end

  create_table :assemblies do |t|
  end

  create_table :assemblies_parts, :id => false do |t|
    t.integer :assembly_id
    t.integer :part_id
  end

  create_table :parts do |t|
  end

  create_table :physicians do |t|
  end

  create_table :appointments do |t|
    t.integer :physician_id
    t.integer :patient_id
  end

  create_table :orders do |t|
    t.integer :user_id
  end
end
