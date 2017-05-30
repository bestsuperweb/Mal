namespace :redis do
  %w[start stop restart].each do |command|
    desc "#{command} redis"
    task command do
      on roles(:web), in: :groups, limit: 3, wait: 10 do
        execute "sudo service redis-server #{command}"
      end
    end
  end
end
