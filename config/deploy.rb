# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "qna"
set :repo_url, "git@github.com:dronky/qna.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deployer/qna"

set :deploy_user, 'deployer'
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :linked_files is []
append :linked_files, "config/thinking_sphinx.yml", "config/database.yml", ".env"
# , "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"
set :bundle_binstubs, nil

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :default_shell, '/bin/bash -l'


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      invoke 'unicorn:restart'
    end
  end

  desc 'Runs rake db:seed'
  task :seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc 'thinking_sphinx:stop'
  task :ts_stop do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'ts:stop'
        end
      end
    end
  end

  desc 'thinking_sphinx:start'
  task :ts_start do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'ts:start'
        end
      end
    end
  end

  desc 'thinking_sphinx:index'
  task :ts_index do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'ts:index'
        end
      end
    end
  end

  desc 'thinking_sphinx:restart'
  task :ts_restart do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'ts:stop ts:configure ts:start'
        end
      end
    end
  end

  desc 'thinking_sphinx:index_start'
  task :ts_index_start do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'ts:index'
          execute :rake, 'ts:start'
        end
      end
    end
  end

  after :publishing, :restart
  # after :publishing, :ts_restart
  before :publishing, :ts_stop
  after :publishing, :ts_index_start
  # after :publishing, :ts_start

  # after :publishing, :ts_start

end

# namespace :private_pub do
#   desc 'Start private_pub server'
#   task :start do
#     on roles(:app) do
#       within current_path do
#         with rails_env: fetch(:rails_env) do
#           execute :bundle, "exec thin -C config/private_pub_thin.yml start"
#         end
#       end
#     end
#   end
#
#   desc 'Stop private_pub server'
#   task :stop do
#     on roles(:app) do
#       within current_path do
#         with rails_env: fetch(:rails_env) do
#           execute :bundle, "exec thin -C config/private_pub_thin.yml stop"
#         end
#       end
#     end
#   end
#
#   desc 'Restart private_pub server'
#   task :restart do
#     on roles(:app) do
#       within current_path do
#         with rails_env: fetch(:rails_env) do
#           execute :bundle, "exec thin -C config/private_pub_thin.yml restart"
#         end
#       end
#     end
#   end
# end