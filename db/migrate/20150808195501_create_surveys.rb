class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :public_url, null: false
      t.string :private_url, null: false

      t.string :title, null: false
      t.text :description

      t.index :public_url, unique: true
      t.index :private_url, unique: true
      t.timestamps
    end
  end
end
