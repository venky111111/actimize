
set -o errexit

bundle install --gemfile="Gemfile-2.6.5"
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate