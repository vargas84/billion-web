rails_env = new_resource.environment['RAILS_ENV']

Chef::Log.info('Precompiling assets...')
execute 'precompile assets' do
  cwd release_path
  command 'RAILS_ENV=production bin/rake assets:precompile'
  user 'deploy'
  group 'www-data'
  only_if { rails_env == 'production' }
end
