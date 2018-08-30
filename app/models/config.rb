class Config
  include ActiveModel::Validations

  attr_accessor :analyse_every, :max_date

  validates :analyse_every, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :max_date, presence: true

  def initialize(analyse_every:, max_date:)
    @analyse_every = analyse_every
    @max_date = DateTime.parse(max_date)
  end
end