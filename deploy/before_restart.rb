rails_env = new_resource.environment['RAILS_ENV']
secret_key_base = new_resource.environment['SECRET_KEY_BASE']

Chef::Log.info('Precompiling assets...')
execute 'precompile assets' do
  cwd release_path
  command 'bin/rake assets:precompile'
  user 'deploy'
  group 'www-data'
  only_if { rails_env == 'production' }
  environment(
    'RAILS_ENV' => rails_env,
    'SECRET_KEY_BASE' => secret_key_base
  )
end
