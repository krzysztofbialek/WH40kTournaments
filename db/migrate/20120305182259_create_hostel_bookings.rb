class CreateHostelBookings < ActiveRecord::Migration
  def change
    create_table :hostel_bookings do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :payment,   :default => false

      t.timestamps
    end
  end
end
