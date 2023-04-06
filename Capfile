# Load DSL and set up stages
require "capistrano/deploy"
require "capistrano/puma"
require "capistrano/rails/migrations"
require "capistrano/setup"
require "capistrano/upload-config"
require 'capistrano/nginx'
require 'capistrano/rvm'
require 'sshkit/sudo'
# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# or
# require "capistrano/scm/svn"
# or
require "capistrano/scm/git"
# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
# require "capistrano/rvm"
# require "capistrano/rbenv"
# require "capistrano/chruby"
# require "capistrano/bundler"
# require "capistrano/rails/assets"
# require "capistrano/passenger"
# Install plugins
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Jungle
install_plugin Capistrano::Puma::Nginx
install_plugin Capistrano::SCM::Git
# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }