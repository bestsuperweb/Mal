# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'onlinemusicalschool'
set :repo_url, 'git@bitbucket.org:dima007/onlinemusicalschool.git'

# config/deploy.rb
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, File.read('.ruby-version').strip

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/rails/onlinemusicalschool'

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :branch, ENV.fetch('BRANCH', 'master')
# set :delayed_job_workers, 2
# set :delayed_job_roles, [:app]

set :faye_pid, "#{deploy_to}/shared/tmp/pids/faye.pid"
set :faye_config, "#{deploy_to}/current/private_pub.ru"

namespace :faye do
  task :start do
    on roles :all do

      execute "cd #{deploy_to}/current ; RAILS_ENV=production ~/.rbenv/bin/rbenv exec bundle exec rackup private_pub.ru -s thin -E production -D -P #{fetch(:faye_pid)}"
    end
  end

  task :stop do
    on roles :all do
      execute "kill `cat #{fetch(:faye_pid)}` || true"
    end
  end
end

after  'deploy:publishing', 'faye:start'
before 'deploy:updating', 'faye:stop'

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
