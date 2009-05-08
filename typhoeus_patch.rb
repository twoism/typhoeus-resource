module Typhoeus
  module ClassMethods
    # Allow for renaming of the remote resource
    # ex: :is_resource => {:resource_name => "collections"}
    def resource_name
      unless @remote_defaults[:is_resource].is_a? Hash
        self.to_s.tableize
      else
        @remote_defaults[:is_resource][:resource_name] || self.to_s.tableize
      end
    end
    # Build REST paths and add them as remote methods
    def build_resource_methods
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
        # this should be a :put but Typhoeus isn't 
        # sending params along with :put operations so
        # :post will have to do for now.
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