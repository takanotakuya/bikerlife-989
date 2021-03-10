class CreateConsultationsComments < ActiveRecord::Migration[6.0]
  def change
    create_table :consultations_comments do |t|
      t.references :user,         null: false, foreign_key: true
      t.references :consultation, null: false, foreign_key: true
      t.text :comment_text,       null: false
      t.timestamps
    end
  end
end
