# Some Notes on Migration

The `change` method is the primary way of writing migrations if not using generator. `change` is reversible for most cases. 
`change_table` is also reversible, as long as the block does not call `change`, `change_default` or `remove`.

For `remove_column`, if you provide the info when you created the column, it is also reversible.

When running migrations with a VERSION parameter, if current version is behind VERSION, Rails will migrate up to the VERSION including the VERSION. If current version is ahead of VERSION, Rails will migrate down to but not including the VERSION. 

So it looks like this using open interval symbol:
`(VERSION_111 ... current_version ... VERSION_123]`

### db Commands
`db:create` creates the database for the current RAILS_ENV environment. If not specified, it defaults to development and test.
`db:setup` runs `db:create`, `db:schema:load` and `db:seed`
`db:reset` runs `db:drop` and `db:setup`
