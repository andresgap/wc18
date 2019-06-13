namespace :quiniela do

  desc 'Seeds database'
  task 'seed_gc19' => :environment do |t, args|
    # Clean up old tournament
    wc18 = Tournament.where(code: 'WC18').first_or_create
    gc19 = Tournament.where(code: 'GC19').first_or_create
    ca19 = Tournament.where(code: 'CA19').first_or_create
    Team.where(created_at: 7.days.ago..Time.current).update_all(tournament_id: gc19.id)
    Phase.where(created_at: 7.days.ago..Time.current).update_all(tournament_id: gc19.id)
    Match.where(created_at: 7.days.ago..Time.current).update_all(tournament_id: gc19.id)
    PredictionSet.where(created_at: 7.days.ago..Time.current).update_all(tournament_id: gc19.id)
    wc18.update_attributes(active: false)
    ca19.update_attributes(active: false)

    puts 'GC19 updated'

  end
end
