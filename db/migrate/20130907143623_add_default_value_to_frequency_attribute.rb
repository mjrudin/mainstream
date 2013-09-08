class AddDefaultValueToFrequencyAttribute < ActiveRecord::Migration
  def change
    change_column :urls, :frequency, :integer, default: 0
  end
end
