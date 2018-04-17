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
      tournament_obj = Tournament.where(code: tournament.code).first_or_create

      # Phases
      puts '  Creating default phases...'
      tournament.phases.each do |phase|
        Phase
          .where(code: phase.code, level: phase.level, small_points: phase.small_points,
            big_points: phase.big_points, active: phase.active, tournament: tournament_obj)
          .first_or_create
      end

      # Teams
      puts '  Creating default teams...'
      tournament.teams.each do |team|
        Team.where(code: team.code, group: team.group, tournament: tournament_obj).first_or_create
      end

      # Matches
      puts '  Creating default matches...'
      teams = Team.all
      phases = Phase.all
      tournament.matches.each do |match|
        date = DateTime.parse(match.date)
        phase = phases.find { |phase| phase.code == match.phase }
        if match.team1 && match.team2
          team1 = teams.find { |team| team.code == match.team1 }
          team2 = teams.find { |team| team.code == match.team2 }
          match_params = {
            date: date,
            team1: team1,
            team2: team2,
            phase: phase,
            tournament: tournament_obj,
            active: phase.active,
            open: phase.active
          }
          Match.where(match_params).first_or_create
        else
          match_params = {
            date: date,
            phase: phase,
            tournament: tournament_obj,
            active: phase.active,
            open: phase.active
          }
          Match.where(match_params).first_or_create
        end
      end
    end
    puts 'Tournament created'

  end
end
