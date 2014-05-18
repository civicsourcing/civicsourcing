# config valid only for Capistrano 3.1
lock '3.1.0'
 
set :application, 'civicsourcing'
set :deploy_user, 'deploy'
 
set :scm, :git
set :repo_url, 'https://github.com/civicsourcing/civicsourcing.git'

set :linked_dirs, %w{public/uploads}
 
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
 
# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/deploy/civicsourcing'
 
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.0.0-p451'
 
 
set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
 
namespace :deploy do
 
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  #after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
end