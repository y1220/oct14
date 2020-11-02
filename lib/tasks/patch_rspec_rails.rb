Rake::Task["spec:prepare"].clear
namespace :spec do
  task :prepare do
    ENV['RACK_ENV'] = ENV['RAILS_ENV'] = 'test'
  end
end
