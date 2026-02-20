class Bixe < ApplicationRecord
  validates :nome, presence: true
  validates :telefone, presence: true
  validates :email, presence: true
  validates :curso, presence: true

  has_one :confirmacao

  enum curso: %i[LIC PURA BCC ESTAT APLICADA BMAC LICNOTURNO].freeze

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
