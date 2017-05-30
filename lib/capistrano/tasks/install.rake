namespace :install do
  task :prerequisites do
    on roles(:all) do
      execute "sudo apt-get install -y mysql-client libmysqlclient-dev"
      execute "sudo apt-get install -y logrotate"
      execute "sudo apt-get -y install nodejs"
      execute "sudo apt-get -y install imagemagick"
      execute "sudo apt-get -y install nginx"
      execute "sudo apt-get -y update"
    end
  end
end

before :setup, "install:prerequisites"
