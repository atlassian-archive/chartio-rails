require 'spec_helper'
require 'chartio/test_formatter'

describe "Chartio Rails" do

  before(:all) do
    @test_formatter = Chartio::TestFormatter.new
    @schema = Chartio::Schema.new(@test_formatter)
    @schema.output_report
  end

  it "should handle a belongs_to relationship" do
    expected_key = {
      :parent_table => 'accounts',
      :parent_primary_key => 'id',
      :child_table => 'users',
      :child_foreign_key => 'account_id',
      :polymorphic_field => nil
    }
    fk = @test_formatter.find_key(expected_key)
    expect(fk).to be_truthy
    expect(fk.to_h).to match(expected_key)
  end

  it "should handle a has_and_belongs_to_many" do
    fks = @test_formatter.find_keys(:child_table => 'assemblies_parts')
    expect(fks.length).to eq(2)
    expect(fks.map(&:to_h)).to match_array([
      {
        :parent_table => 'parts',
        :parent_primary_key => 'id',
        :child_table => 'assemblies_parts',
        :child_foreign_key => 'part_id',
        :polymorphic_field => nil
      },
      {
        :parent_table => 'assemblies',
        :parent_primary_key => 'id',
        :child_table => 'assemblies_parts',
        :child_foreign_key => 'assembly_id',
        :polymorphic_field => nil
      }
    ])
  end

end
