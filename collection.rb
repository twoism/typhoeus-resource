class Collection
  include Typhoeus
  remote_defaults :on_success => lambda {|response| JSON.parse(response.body)},
                  :on_failure => lambda {|response| puts "error code: #{response.code}"},
                  :base_uri   => "http://localhost:9292",
                  :is_resource => true
                    
  define_remote_method :search, :path => '/search.json'
end