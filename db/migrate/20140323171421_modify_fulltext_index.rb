class ModifyFulltextIndex < ActiveRecord::Migration
  def self.up
    execute "DROP INDEX talks_indexes ON talks"
    execute "DROP INDEX users_indexes ON users"
    execute "DROP INDEX companies_indexes ON companies"

    execute "ALTER TABLE talks ADD FULLTEXT talks_indexes (title, description)"
    execute "ALTER TABLE users ADD FULLTEXT users_indexes (name, career, introduction)"
  end

  def self.down
    execute "ALTER TABLE talks ADD FULLTEXT talks_indexes (title, description)"
    execute "ALTER TABLE users ADD FULLTEXT users_indexes (name, tagline, introduction)"
    execute "ALTER TABLE companies ADD FULLTEXT companies_indexes (name, tagline, introduction)"
  end
end
