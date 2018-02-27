# coding: utf-8
# ruby

#require "pstore"
require "yaml/store"

class Base
  # more about File.expand_path at
  # https://stackoverflow.com/questions/4474918/file-expand-path-gemfile-file-how-does-this-work-where-is-the-fil
  #DB_FILE = File.expand_path("../../db/db.pstore", __FILE__)
  DB_FILE = File.expand_path("../../db/db.yaml", __FILE__)

  module ClassMethods

    def find(id)
      db.transaction(true) do
        db[derive_db_id(self.name, id)]
      end
    end

    def all
      db.transaction(true) do |db|
        extract_model_ids(db).map {|key| db[key]}
      end
    end

    def save(object)
      db.transaction do
        db[derive_db_id(object.class.name, object.id)] = object
      end
    end

    def next_available_id
      last_id = all_ids.map do |id|
        id.sub("#{self.name}_", "").to_i
      end.max.to_i # here to_i converts nil to 0 when db is empty
      last_id + 1
    end

    private

    def db
      @db ||= YAML::Store.new(DB_FILE)
    end

    def derive_db_id(model_name, obj_id)
      "#{model_name}_#{obj_id}"
    end

    def all_ids
      db.transaction(true) do |db|
        extract_model_ids(db)
      end
    end

    def extract_model_ids(store)
      store.roots.select { |key| key.start_with? self.name}
    end
    
  end
  extend ClassMethods

  def save
    ensure_presence_of_id
    self.class.save(self)
  end

  private

  def ensure_presence_of_id
    self.id ||= self.class.next_available_id
  end
  
end
