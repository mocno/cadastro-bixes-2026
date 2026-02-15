class Confirmacao < ApplicationRecord
  belongs_to :bixe

  TEAMS = [:FANTASMA, :BALAO, :BANANA, :AMENDOIM, :NUVEM].freeze

  def self.assign_team
    team_counts = TEAMS.map do | time | 
      [time, Confirmacao.where("lower(team) = ?", time.to_s.downcase).count]
    end.to_h

    min_count = team_counts.values.min

    elegible_teams = team_counts.select { |_time, count| count <= min_count }.keys

    chosen_team = elegible_teams.sample


    return chosen_team.to_s.downcase
  end

  def set_team
    self.team = Confirmacao.assign_team
  end

  def team
    # TEAMS[id % TEAMS.length()].to_s.downcase
    self[:team]
  end
  before_create :set_team

end
