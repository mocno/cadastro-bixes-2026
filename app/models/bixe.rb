class Bixe < ApplicationRecord
  validates :nome, presence: true
  validates :curso, presence: true

  has_one :confirmacao

  enum curso: {
    "Licenciatura Matutino" => 0,
    "Matemática Pura" => 1,
    "Ciência da Computação - BCC" => 2,
    "Estatística" => 3,
    "Matemática Aplicada" => 4,
    "Matemática Aplicada e Computacional - BMAC" => 5,
    "Licenciatura Noturno" => 6
  }

  delegate :team, to: :confirmacao

  def confirmed?
    confirmacao.present?
  end

  def self.confirmed
    all
      .select(&:confirmed?)
      .sort_by(&:team)
  end

  def self.non_confirmed
    all.reject(&:confirmed?)
  end
end
