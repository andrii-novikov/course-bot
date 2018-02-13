role :app, %w[blockchain@13.57.221.147]
role :web, %w[blockchain@13.57.221.147]
role :db,  %w[blockchain@13.57.221.147]

set :branch, 'master'

server '13.57.221.147', user: 'blockchain', roles: %w[web app]