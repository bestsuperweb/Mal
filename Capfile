require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/rbenv_install'
require 'capistrano/unicorn_nginx'
require 'capistrano/safe_deploy_to'
require 'capistrano/rails/console'
require 'airbrussh/capistrano'
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
