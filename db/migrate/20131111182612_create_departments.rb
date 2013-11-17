class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phonenumber

      t.timestamps
    end
  end
end
