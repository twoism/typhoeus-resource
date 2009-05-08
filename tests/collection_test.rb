require 'rubygems'
require 'test/unit'
require 'activesupport'
require 'shoulda'
require "typhoeus"
require "json"

module Typhoeus
  module ClassMethods
    # just playing around with ideas here
    # still need to dig through Typhoeus some more
    def build_resource_methods
      {
        :all => {
          :path => "/#{self.to_s.tableize}.json",
          :method => :get
        },
          :create => {
          :path => "/#{self.to_s.tableize}.json",
          :method => :post
        },
        :show => {
          :path => "/#{self.to_s.tableize}/:id.json",
          :method => :get
        },
        :update => {
          :path => "/#{self.to_s.tableize}/:id.json",
          :method => :post
        },
        :destroy => {
          :path => "/#{self.to_s.tableize}/:id.json",
          :method => :delete
        }
      }.each do |m,args|
        define_remote_method m, args
      end
    end
    
    def remote_defaults(options)
      @remote_defaults = options
      build_resource_methods unless options[:is_resource].nil?
    end
  end
end

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