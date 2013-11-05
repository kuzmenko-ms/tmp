class CreateUsersVotes < ActiveRecord::Migration
  def change
    create_table :users_votes do |t|

      t.timestamps
    end
  end
end
