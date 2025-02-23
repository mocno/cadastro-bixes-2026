class Confirmacao < ApplicationRecord
  belongs_to :bixe

  COLORS = [:PURPLE, :ORANGE, :GREEN, :BLUE, :BROWN].freeze

  def self.assign_team
    team_counts = COLORS.map do | time | 
      [time, Confirmacao.where("lower(team) = ?", time.to_s.downcase).count]
    end.to_h

    min_count = team_counts.values.min

    elegible_teams = team_counts.select { |_time, count| count == min_count }.keys

    chosen_team = elegible_teams.sample
    chosen_team.to_s.downcase
  end

  def set_team_color
    self.team = Confirmacao.assign_team
  end

  def team_color
    COLORS[id % COLORS.length()].to_s.downcase
  end
  before_create :set_team_color

end
