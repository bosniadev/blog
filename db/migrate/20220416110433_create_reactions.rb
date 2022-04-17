# frozen_string_literal: true

class CreateReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :reactions do |t|
      t.integer :kind, null: false
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :comment, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :reactions, %i[user_id kind comment_id], unique: true
  end
end
