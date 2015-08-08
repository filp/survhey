class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :body, null: false
      t.references :survey, index: true, null: false
      t.integer :position, index: true, null: false, default: 0
    end
  end
end
