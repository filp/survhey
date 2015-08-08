class AddUidToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :uid, :string, null: false
  end
end
