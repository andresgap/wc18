namespace :wc18 do

  desc 'Seeds database'
  task 'seed' => :environment do |t, args|
    # Admins
    puts 'Creating default users...'
    DEFAULT_ADMINS.each do |user|
      User.where(email: user.email, admin: true).first_or_create
    end
    puts 'Users created'

    # Tournaments
    puts 'Creating default tournaments...'
    DEFAULT_TOURNAMENTS.each do |tournament|
      Tournament.where(code: tournament.code).first_or_create

      # Phases
      puts '  Creating default phases...'
      tournament.phases.each do |phase|
        Phase.where(code: phase.code, level: phase.level, small_points: phase.small_points, big_points: phase.big_points).first_or_create
      end

      # Teams
      puts '  Creating default teams...'
      tournament.teams.each do |team|
        Team.where(code: team.code, group: team.group).first_or_create
      end
    end
    puts 'Tournament created'

  end
end
