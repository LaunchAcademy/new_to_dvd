class CreateReleaseInfos < ActiveRecord::Migration
  def up
    execute "CREATE EXTENSION hstore"
    create_table :release_infos do |t|
      t.hstore :data
      t.timestamps
    end
  end

  def down
    drop_table :release_infos
    execute "DROP EXTENSION hstore"
  end
end

