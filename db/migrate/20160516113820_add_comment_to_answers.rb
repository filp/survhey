class AddCommentToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :comment, :text, null: true
    add_column :surveys, :allow_free_form, :boolean, null: false, default: false
    add_column :choices, :free_form, :boolean, null: false, default: false

    add_index :choices, :free_form
  end
end
