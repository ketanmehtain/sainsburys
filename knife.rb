# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "ketanmehta"
client_key               "#{current_dir}/ketanmehta.pem"
validation_client_name   "ketan-validator"
validation_key           "#{current_dir}/ketan-validator.pem"
chef_server_url          "https://api.chef.io/organizations/ketan"
cookbook_path            ["#{current_dir}/cookbooks"]
