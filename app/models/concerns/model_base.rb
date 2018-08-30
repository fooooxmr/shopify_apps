module Concerns
  module ModelBase
    extend ActiveSupport::Concern

    included do
      def initialize(attributes = {})
        attributes.each do |name, value|
          send("#{name}=", value)
        end
      end
    end
  end
end
