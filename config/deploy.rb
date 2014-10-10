# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'track-assignment'
set :repo_url, 'https://github.com/pgengler/track-assignment.git'

set :deploy_to, '/srv/apps/track-assignment'

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart
end
