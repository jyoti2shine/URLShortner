class CreateShortUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :short_urls do |t|
      t.string :original_url
      t.string :shorty
      t.integer :visits, :default => 0
      t.references :user, foreign_key: true

      t.timestamps
    end
    execute "ALTER TABLE short_urls AUTO_INCREMENT = 1000"
  end
end