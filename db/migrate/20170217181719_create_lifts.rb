class CreateLifts < ActiveRecord::Migration[5.0]
  def change
    create_table :lifts do |t|
      t.date :date
      t.string :liftName
      t.boolean :isMetric
      t.integer :weightLifted
      t.integer :repsPerformed
      t.integer :oneRm

      t.timestamps
    end
  end
end
