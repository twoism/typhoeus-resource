require 'rubygems'
require 'test/unit'
require 'activesupport'
require 'shoulda'
require "typhoeus"
require "json"

module Typhoeus
  module ClassMethods
    
    def build_resource_methods
      # just playing around with ideas here
      # still need to dig through Typhoeus some more
      {
        :all => {
          :path => "/#{self.to_s.tableize}.json",
          :method => :get
        },
        :show => {
          :path => "/#{self.to_s.tableize}/:id.json",
          :method => :get
        },
        :update => {
          :path => "/#{self.to_s.tableize}/:id.json",
          :method => :put
        },
        :destroy => {
          :path => "/#{self.to_s.tableize}/:id.json",
          :method => :delete
        },
        :create => {
          :path => "/#{self.to_s.tableize}.json",
          :method => :post
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
   
    setup do
      @collection = Collection
    end

    should "return be an instance of da same thing" do
      assert_equal @collection, Collection
    end
   
    should "get some collection action from :all" do
      cols = @collection.all
      cols.each do |c|
        assert_equal(Hash, c["collection"].class)
      end
    end     
  end
end