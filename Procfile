release: bin/rails db:create; bin/rails db:migrate
web: bin/bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-production}