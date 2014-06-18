require 'spec_helper'

describe "CSV Formatter" do

  it "should output a header if no schema is provided" do
    allow(ActiveRecord::Base).to receive(:descendants) { [] }
    csv = CSV.parse(output_csv)
    expect(csv.length).to eq(1)
    first_row_should_be_header(csv)
  end

  context "with a full schema" do

    before(:all) do
      @csv = CSV.parse(output_csv)
    end

    it "should complete successfully" do
      expect(@csv.length).to eq(11)
    end

    it "should output a has_and_belongs_to_many association" do
      results = @csv.find_all do |x|
        x == ["parts", "id", "assemblies_parts", "part_id", nil] ||
        x == ["assemblies", "id", "assemblies_parts", "assembly_id", nil]
      end
      expect(results.length).to eq(2)
    end

    it "should output a self join" do
      results = @csv.find_all { |x| x == ["employees", "id", "employees", "manager_id", nil] }
      expect(results.length).to eq(1)
    end

  end

end

def first_row_should_be_header(csv)
  expect(csv[0]).to match_array(Chartio::ForeignKeyRelationship::FIELDS.map(&:to_s))
end

def output_csv
  csv_formatter = Chartio::CSVFormatter.new
  schema = Chartio::Schema.new(csv_formatter)
  schema.output_report
end
