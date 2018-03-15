# To fine tune a migration and its output, use the following three methods:
#     1. suppress_message
#     2. say
#     3. say_with_time
#
#
# Console output:
#
# == 20180315161902 MigrationWithCustomMessage: migrating =======================
# -- Added a new column named groups to table trains and type is integer
# -- Now trying to load some data into it...
#    -> 0.1022s
#    -> 100 rows
# == 20180315161902 MigrationWithCustomMessage: migrated (0.1036s) ==============
#
class MigrationWithCustomMessage < ActiveRecord::Migration[5.1]
  def change
    suppress_messages do
      change_table :trains do |t|
        t.integer :groups
      end
    end

    say "Added a new column named groups to table trains and type is integer"

    say_with_time "Now trying to load some data into it..." do
      100.times do |i|
        user = User.new
        user.name = "User_#{i}"
        user.age = 18
        user.occupation = "Student"
        user.save
      end
    end
  end
end
