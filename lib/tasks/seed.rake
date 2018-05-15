namespace :wc18 do

  desc 'Seeds database'
  task 'seed' => :environment do |t, args|
    # Admins
    puts 'Creating default users...'
    DEFAULT_ADMINS.each do |user|
      User.where(email: user.email, admin: true).first_or_create
    end
    puts 'Users created'

    # Phases
    puts 'Creating default phases...'
    DEFAULT_PHASES.each do |phase|
      Phase.where(
        code: phase.code,
        level: phase.level,
        small_points: phase.small_points,
        big_points: phase.big_points,
        active: phase.active
      ).first_or_create
    end
    puts 'Phases created'

    # Teams
    puts 'Creating default teams...'
    DEFAULT_TEAMS.each do |team|
      Team.where(code: team.code, group: team.group).first_or_create
    end
    puts 'Teams created'

    # Matches
    puts 'Creating default matches...'
    teams = Team.all
    phases = Phase.all
    DEFAULT_MATCHES.each_with_index do |match, index|
      date = DateTime.parse(match.date)
      phase = phases.find { |phase| phase.code == match.phase }
      if match.team1 && match.team2
        team1 = teams.find { |team| team.code == match.team1 }
        team2 = teams.find { |team| team.code == match.team2 }
        match_params = {
          number: index + 1,
          date: date,
          team1: team1,
          team2: team2,
          phase: phase,
          ready: phase.active
        }
        Match.where(match_params).first_or_create
      else
        match_params = {
          number: index + 1,
          date: date,
          phase: phase,
          team1_label: match.team1_label,
          team2_label: match.team2_label,
          ready: phase.active
        }
        Match.where(match_params).first_or_create
      end
    end
    puts 'Matches created'

  end
end
