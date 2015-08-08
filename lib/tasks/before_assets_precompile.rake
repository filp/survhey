task :before_assets_precompile do
  if Rails.env.production?
    Rake::Task["emoji"].invoke
  end
end

# every time you execute 'rake assets:precompile'
# run 'before_assets_precompile' first
Rake::Task["assets:precompile"].enhance ["before_assets_precompile"]
