set :application, "mystore"
set :repository,  "."
set :deploy_to, '/home/ctsimpson/apps/'
set :user, 'ctsimpson'
set :server, '172.16.40.128'
set :use_sudo, false


role :web, "172.16.40.128"
role :app, "172.16.40.128"                   # This may be the same as your `Web` server
role :db,  "172.16.40.128", :primary => true # This is where Rails migrations will run

set :scm, :none
set :deploy_via, :copy
set :keep_releases, 2
set :normalize_asset_timestamps, false

namespace :deploy do
     desc "handle machine specific configs"
     task :handle_configs do
          run "rm -rf #{release_path}/config/nginx.conf"
          run "rm -rf #{release_path}/config/unicorn*"
          run "cp #{shared_path}/config/unicorn.rb #{release_path}/config/"
          run "if [ -d #{shared_path}/config/database.yml ]; then cp #{shared_path}/config/database.yml #{release_path}/config/database.yml; fi"
		run "if [ -d #{shared_path}/config/restart_server.sh]; then cp #{shared_path}/config/restart_server.sh #{release_path}/config/restart_server.sh; fi"
     end
end

namespace :assets do
  desc "Precompile assets locally and then rsync to app servers"
  task :precompile, :only => { :primary => true } do
    run_locally "bundle exec rake assets:precompile;"
    servers = find_servers :roles => [:app], :except => { :no_release => true }
    servers.each do |server|
      run_locally "rsync -av ./public/assets/ #{user}@#{server}:#{release_path}/public/assets/;"
    end
    run_locally "rm -rf public/assets"
  end
end

after 'deploy:update_code','deploy:handle_configs','assets:precompile','deploy:cleanup'
