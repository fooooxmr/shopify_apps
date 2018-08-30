module AppsPagesHelper
  def parse_json(state)
    return [] unless state
    JSON.parse(state.page_state).map do |json_app|
      App.new(json_app)
    end.group_by(&:category)
  end
end