# Some Notes on Migration

The `change` method is the primary way of writing migrations if not using generator. `change` is reversible for most cases. 
`change_table` is also reversible, as long as the block does not call `change`, `change_default` or `remove`.

For `remove_column`, if you provide the info when you created the column, it is also reversible.

When running migrations with a VERSION parameter, if current version is behind VERSION, Rails will migrate up to the VERSION including the VERSION. If current version is ahead of VERSION, Rails will migrate down to but not including the VERSION. 

So it looks like this using open interval symbol:
`(VERSION_111 ... current_version ... VERSION_123]`

Rails stores migration metadata in `schema_migrations` and `ar_internal_metadata` table.

### db Commands
- `db:create` creates the database for the current RAILS_ENV environment. If not specified, it defaults to development and test.
- `db:setup` runs `db:create`, `db:schema:load` and `db:seed`
- `db:reset` runs `db:drop` and `db:setup`

[See this well summarized page for detials](https://jacopretorius.net/2014/02/all-rails-db-rake-tasks-and-what-they-do.html)

### Practices
- When starting from stratch, use generators, aka `rails g model Xxx ...` or `rails g migration CreateXxx ...`.
- When fixing or modifying existing schema and data, write your new migrations.
- Generally, it's always better to create new migrations than mingle changes with existing migrations.
- The `revert` method can be helpful when writing a new migration to undo previous migrations in whole or in part.
- Migrations are not the authoritative source of your database schema. That role fails to `db/schema.rb` or `db/structure.sql`
- Schema files
  - are authoritative source for your database schema (so check them into source control :)
  - are database independent (so database specific features like triggers, procedures, etc. are not supported)
  - are not designed to be edited
  - can be useful for model attributes lookup
- The Active Record way claims that **intelligence resides in your models, not in your database**. As such, features such as triggers or constraints, which push some of that intelligence back into the database, are not heavily used. So, use standard database features as possible as you can if you foresee the possibility of switching to another db in the future.
- Use `seeds.rb` database data initialization
