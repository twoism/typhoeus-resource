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