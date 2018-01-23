class CreateAdjustedProportions < ActiveRecord::Migration[5.0]
  def change
    create_table :adjusted_proportions do |t|
      t.string :amount
      t.references :saved_drink, foreign_key: true
      t.references :ingredient, foreign_key: true
    end
  end
end
