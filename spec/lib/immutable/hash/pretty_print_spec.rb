require "spec_helper"
require "pp"
require "stringio"

describe Immutable::Hash do
  describe "#pretty_print" do
    let(:hash) { Immutable::Hash.new(DeterministicHash.new(1,1) => "tin", DeterministicHash.new(2,2) => "earwax", DeterministicHash.new(3,3) => "neanderthal") }
    let(:stringio) { StringIO.new }


    it "prints the whole Hash on one line if it fits" do
      PP.pp(hash, stringio, 80)
      stringio.string.chomp.should == 'Immutable::Hash[1 => "tin", 2 => "earwax", 3 => "neanderthal"]'
    end

    it "prints each key/val pair on its own line, if not" do
      PP.pp(hash, stringio, 20)
      stringio.string.chomp.should == 'Immutable::Hash[
 1 => "tin",
 2 => "earwax",
 3 => "neanderthal"]'
    end

    it "prints keys and vals on separate lines, if space is very tight" do
      PP.pp(hash, stringio, 15)
      # the trailing space after "3 =>" below is needed, don't remove it
      stringio.string.chomp.should == 'Immutable::Hash[
 1 => "tin",
 2 => "earwax",
 3 => 
  "neanderthal"]'
    end
  end
end