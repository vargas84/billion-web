desc 'Invite user to billion'
task :invite_user, [:email] => :environment do |_, args|
  User.invite!(email: args.email)
end
