class CreateShortVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :short_visits do |t|
      t.references :short_url, foreign_key: true
      t.string :visitor_ip
      t.string :visitor_city
      t.string :visitor_state
      t.string :visitor_country
      t.string :visitor_zip

      t.timestamps
    end
  end
end
