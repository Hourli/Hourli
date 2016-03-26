class CreateJobRequests < ActiveRecord::Migration
  def change
    create_table :job_requests do |t|
      t.string :title,              null: false
      t.text   :description,        null: false
      t.string :location,           null: false
      t.float  :hourly_rate,       null: false
      t.text   :categories,         null: false
      #t.integer :customer_id,       null: true
      
      t.timestamps null: false
    end
  end
end
