class CreateIpAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :ip_addresses do |t|
      t.string :address, index: true
      t.jsonb :geolocation_data, null: false, default: '{}'

      t.timestamps
    end

    add_index  :ip_addresses, :geolocation_data, using: :gin
  end
end
