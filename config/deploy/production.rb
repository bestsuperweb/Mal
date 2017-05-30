server '69.195.128.34', user: 'rails', roles: %w{app db web}

set :rails_env, 'production'
set :nginx_server_name, 'mal.slightred.com'
set :unicorn_workers, 20
set :nginx_use_ssl, false
set :unicorn_use_tcp, false
