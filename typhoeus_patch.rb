module Typhoeus
  module ClassMethods
    # just playing around with ideas here
    # still need to dig through Typhoeus some more
    def build_resource_methods
      resource_name = self.to_s.tableize
      {
        :all => {
          :path => "/#{resource_name}.json",
          :method => :get
        },
          :create => {
          :path => "/#{resource_name}.json",
          :method => :post
        },
        :show => {
          :path => "/#{resource_name}/:id.json",
          :method => :get
        },
        :update => {
          :path => "/#{resource_name}/:id.json",
          :method => :post
        },
        :destroy => {
          :path => "/#{resource_name}/:id.json",
          :method => :delete
        }
      }.each do |m,args|
        define_remote_method m, args
      end
    end
    # overides Typhoeus::ClassMethods::remote_defaults
    def remote_defaults(options)
      @remote_defaults = options
      build_resource_methods unless options[:is_resource].nil?
    end
  end
end