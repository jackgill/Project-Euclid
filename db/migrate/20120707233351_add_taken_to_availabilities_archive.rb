class AddTakenToAvailabilitiesArchive < ActiveRecord::Migration
  def change
    add_column :availabilities_archive, :taken, :boolean, null: false, default: false
  end
end
