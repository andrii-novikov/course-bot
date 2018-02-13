lock '~> 3.10.0'

set :application, 'course-bot'
set :repo_url, "https://github.com/andy1341/course-bot.git"
set :use_sudo,    false
set :user,        'blockchain'

set :pty,             false
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/sites/#{fetch(:application)}"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :bundle_binstubs, nil

set :linked_files, %w{ config/application.yml }
set :linked_dirs,  %w{ log tmp/pids tmp/cache tmp/sockets }

namespace :deploy do
  desc 'Upload config'
  task :setup do
    on roles(:all) do
      upload!("config/application.yml", "#{deploy_to}/shared/config/application.yml")
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do

    end
  end
end