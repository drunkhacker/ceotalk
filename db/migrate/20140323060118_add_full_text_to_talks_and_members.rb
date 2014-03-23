class AddFullTextToTalksAndMembers < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE talks ADD FULLTEXT talks_indexes (title, description)"
    execute "ALTER TABLE users ADD FULLTEXT users_indexes (name, tagline, introduction)"
    execute "ALTER TABLE companies ADD FULLTEXT companies_indexes (name, tagline, introduction)"
  end

  def self.down
    execute "DROP INDEX talks_indexes ON talks"
    execute "DROP INDEX users_indexes ON users"
    execute "DROP INDEX companies_indexes ON companies"
  end
end
