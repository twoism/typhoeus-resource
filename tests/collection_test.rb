require 'rubygems'
require 'test/unit'
require 'activesupport'
require 'shoulda'
require "typhoeus"
require "json"
require "../typhoeus_patch"
require '../collection'

class CollectionTest < Test::Unit::TestCase
  context "A Collection instance" do

    should "get some collection action from :all" do
      cols = Collection.all
      cols.each do |c|
        assert_equal(Hash, c.class)
      end
    end   
    
    should "should create with params" do
      c = Collection.create(:params => {:name => "Some Collection"})
      assert_match(/\w+/, c["name"])
    end
    
    should "should return a single collection" do
      c = Collection.show(:id=>1)
      assert_match(/\w+/, c["name"])
    end
    
    should "should update with params" do
      c = Collection.update(:id=>1,:params => {:name => "Some Collection"})
      assert_match(/\w+/, c["name"])
    end
    
    should "should destroy with id 1" do
      c = Collection.destroy(:id => 1)      
      assert_match(/\w+/, c["name"])
    end
    
  end
end