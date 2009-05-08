require 'rubygems'
require 'test/unit'
require 'activesupport'
require 'shoulda'
require "typhoeus"
require "json"

module Typhoeus
  module ClassMethods
    
    def build_resource_methods
      methods = {
        :all => {
          :path => "/#{self.to_s.tableize}.json"
        },
        :show => {
          :path => "/#{self.to_s.tableize}/:id.json"
        },
        :update => {
          :path => "/#{self.to_s.tableize}/:id.json"
        },
        :destroy => {
          :path => "/#{self.to_s.tableize}/:id.json"
        },
        :create => {
          :path => "/#{self.to_s.tableize}/:id.json"
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
   
     should "return some results from search" do
       prods = @collection.search_products(:query => "123s")
       assert_equal(Array, prods.class)
     end
     
     should "get some collection action from :all" do
       cols = @collection.all
       cols.each do |c|
         puts c.inspect
         assert_equal(Hash, c["collection"].class)
       end
     end     
   end
 end