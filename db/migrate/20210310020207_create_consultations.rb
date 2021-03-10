class CreateConsultations < ActiveRecord::Migration[6.0]
  def change
    create_table :consultations do |t|
      t.string     :name,       null: false
      t.text       :post_text,  null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end