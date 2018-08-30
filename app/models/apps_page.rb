class AppsPage < ApplicationRecord
  default_scope { where('created_at < ?', ConfigService.get_config.max_date) }
end
