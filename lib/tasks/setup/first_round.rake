namespace :setup do
  task first_round: :environment do
    competition = Competition.current_competition
    round = Round.new competition: competition

    # create round
    round.round_number = 1
    round.started_at = Time.now
    round.ended_at = 12.hours.from_now
    round.save

    # create matches
    active_projects = competition.projects
      .where(eliminated_at: nil)
      .sort_by { |p| 0 - p.points_donated }
    matches_needed = active_projects.size / 2
    (0..matches_needed - 1).each do |i|
      Match.create({
        round: round,
        project_1: active_projects[i],
        project_2: active_projects[-(i+1)],
      })
    end
  end
end
