# frozen_string_literal: true

class CreateFollowJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :follower_id
      t.integer :following_id
    end

    add_index :follows, :following_id
    add_index :follows, :follower_id
    add_index :follows, %i[following_id follower_id], unique: true
  end
end
