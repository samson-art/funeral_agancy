set :application, 'funeral_agancy'
set :repo_url, 'git@github.com:samson-art/funeral_agancy.git'

set :deploy_to, '/root/n0lic/funeral_agancy'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:funeral_agancy), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end