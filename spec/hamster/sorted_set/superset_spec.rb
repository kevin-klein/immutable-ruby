require "spec_helper"
require "hamster/sorted_set"

describe Hamster::SortedSet do
  describe "#superset?" do
    [
      [[], [], true],
      [["A"], [], true],
      [[], ["A"], false],
      [["A"], ["A"], true],
      [%w[A B C], ["B"], true],
      [["B"], %w[A B C], false],
      [%w[A B C], %w[A C], true],
      [%w[A C], %w[A B C], false],
      [%w[A B C], %w[A B C], true],
      [%w[A B C], %w[A B C D], false],
      [%w[A B C D], %w[A B C], true],
    ].each do |a, b, expected|

      describe "for #{a.inspect} and #{b.inspect}" do
        before do
          @result = Hamster.sorted_set(*a).superset?(Hamster.sorted_set(*b))
        end

        it "returns #{expected}"  do
          @result.should == expected
        end
      end
    end
  end

  describe "#proper_superset?" do
    [
      [[], [], false],
      [["A"], [], true],
      [[], ["A"], false],
      [["A"], ["A"], false],
      [%w[A B C], ["B"], true],
      [["B"], %w[A B C], false],
      [%w[A B C], %w[A C], true],
      [%w[A C], %w[A B C], false],
      [%w[A B C], %w[A B C], false],
      [%w[A B C], %w[A B C D], false],
      [%w[A B C D], %w[A B C], true],
    ].each do |a, b, expected|

      describe "for #{a.inspect} and #{b.inspect}" do
        before do
          @result = Hamster.sorted_set(*a).proper_superset?(Hamster.sorted_set(*b))
        end

        it "returns #{expected}"  do
          @result.should == expected
        end
      end
    end
  end
end