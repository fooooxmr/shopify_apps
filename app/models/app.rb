class App
  include ActiveModel::Validations
  include Concerns::ModelBase

  attr_accessor :id, :name, :category, :position, :url

  validates :name, :category, :position, :url, presence: true

end