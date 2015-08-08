class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :uid, null: false

      t.references :choice, index: true, foreign_key: true, null: false
      t.references :survey, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
