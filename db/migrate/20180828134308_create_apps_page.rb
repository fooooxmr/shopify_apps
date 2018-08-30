class CreateAppsPage < ActiveRecord::Migration[5.2]
  def change
    create_table :apps_pages do |t|
      t.json :page_state, null: false, default: {}

      t.timestamp :created_at, null: false
    end
  end
end
