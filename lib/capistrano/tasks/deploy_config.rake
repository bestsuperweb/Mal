namespace :deploy do
  task :config do
    on roles(:all) do
      fetch(:linked_files, []).each do |file|
        upload! file, "#{shared_path}/#{file}"
      end

      upload! 'config/logrotate.conf', '/tmp/onlinemusicalschool.conf'
      execute 'sudo mv /tmp/onlinemusicalschool.conf /etc/logrotate.d/onlinemusicalschool'
    end
  end
end
