# frozen_string_literal: true

class CreateFilers < ActiveRecord::Migration[6.1]
  def change
    create_table :filers do |t|
      t.integer :ein
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code, limit: 10

      t.index :ein, unique: true

      t.timestamps
    end

    create_table :receivers do |t|
      t.integer :ein
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code, limit: 10

      t.index :ein, unique: true

      t.timestamps
    end

    create_table :awards do |t|
      t.integer :grant_cash_amount
      t.string :grant_purpose

      t.references :receiver

      t.timestamps
    end
  end
end
