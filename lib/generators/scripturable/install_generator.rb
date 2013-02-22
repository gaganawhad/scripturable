module Scripturable
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path("../templates", __FILE__)

    def self.next_migration_number(path)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end

    def create_model_file
      template "scripture_reference.rb", "app/models/scripture_reference.rb"
      template "scripture_verse.rb", "app/models/scripture_verse.rb"
      migration_template "create_scripture_references.rb", "db/migrate/create_scripture_references.rb"
    end
  end
end
