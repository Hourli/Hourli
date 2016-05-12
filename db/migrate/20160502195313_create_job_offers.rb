class CreateJobOffers < ActiveRecord::Migration
  def change
    create_table :job_offers do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.float :hourly_rate, null: false
      t.timestamps null: false
      t.references :contractor, index: true, foreign_key: true, null: false
      t.references :job_request, index: true, foreign_key: true, null: false


    end
  end
end
