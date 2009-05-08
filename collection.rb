class Collection
  include Typhoeus
  remote_defaults :on_success => lambda {|response| JSON.parse(response.body)},
                  :on_failure => lambda {|response| puts "error code: #{response.code}"},
                  :base_uri   => "http://209-20-87-228.slicehost.net/feeds",
                  :is_resource => true
                    
  define_remote_method :search_products, :path => '/product_lines.json?query=:query'
end