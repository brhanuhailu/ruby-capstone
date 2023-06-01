require 'spec_helper'
require_relative '../src/music/genre'

RSpec.describe Genre do
    let(:name) { "Action" }
    let(:id) { 42 }
    let(:item) { double("Item") }
    subject { Genre.new(name, id: id) }
  
    describe "#initialize" do
      it "sets the name" do
        expect(subject.name).to eq(name)
      end
  
      it "sets the id" do
        expect(subject.id).to eq(id)
      end
  
      it "initializes an empty items array" do
        expect(subject.items).to be_empty
      end
    end
  
    describe "#add_item" do
      it "adds the item to the items array" do
        subject.add_item(item)
        expect(subject.items).to include(item)
      end
  
      it "sets the genre on the item" do
        expect(item).to receive(:genres=).with(subject)
        subject.add_item(item)
      end
    end
  end
  