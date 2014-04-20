namespace :db do 
  task :nuke => %w[db:drop db:create db:migrate db:seed db:test:prepare]
end