# See http://docs.opscode.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "adamdaigian"
client_key               "#{current_dir}/adamdaigian.pem"
validation_client_name   "elasticbox_adam-validator"
validation_key           "#{current_dir}/elasticbox_adam-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/elasticbox_adam"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
