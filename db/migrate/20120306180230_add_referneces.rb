class AddReferneces < ActiveRecord::Migration
  def change
   change_table :users_votes do |f|
    f.references :user
    f.references :vote
   end
  end
end
