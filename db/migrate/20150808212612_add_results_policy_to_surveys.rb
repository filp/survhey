class AddResultsPolicyToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :public, :boolean, null: false, default: false
  end
end
