if (cable_config_path = Rails.root.join("config/cable.yml")).exist?
  say "Enable Redis in bundle"
  gemfile_content = File.read(Rails.root.join("Gemfile"))
  pattern = /gem ["']redis['"]/

  if gemfile_content.match?(pattern)
    uncomment_lines "Gemfile", pattern
  else
    append_file "Gemfile", "\n# Use Redis for ActionCable"
    gem 'redis', '~> 4.0'
  end

  run_bundle

  say "Switch development cable to use Redis"
  gsub_file cable_config_path, /development:\n\s+adapter: async/, "development:\n  adapter: redis\n  url: redis://localhost:6379/1"
else
  say "Turbo requires ActionCable to work"
end
