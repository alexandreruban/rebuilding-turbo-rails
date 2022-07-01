def run_turbo_install_template(path)
  system "bin/rails app:template LOCATION=#{File.expand_path("../install/#{path}.rb", __dir__)}"
end

def redis_installed?
  if Gem.win_platform?
    system "where redis-server > NUL 2>&1"
  else
    system "which redis-server > /dev/null"
  end
end

def switch_on_redis_if_available
  if redis_installed?
    Rake::Task["turbo_clone:install:redis"].invoke
  else
    puts "Run turbo_clone:install:redis to switch on Redis and use it in development"
  end
end

namespace :turbo_clone do
  desc "Install Turbo into the application"
  task :install do
    run_turbo_install_template "turbo_with_importmap"
    switch_on_redis_if_available
  end

  namespace :install do
    desc "Switch on Redis and use it in development"
    task :redis do
      run_turbo_install_template "turbo_needs_redis"
    end
  end
end
