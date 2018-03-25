# rails g model Student name:string
# rails g model Course name:string
# rails g migration CreateJoinTableStudentCourse student course
#   this will create a join table "courses_students" with two columns
#   "courses_students" ("student_id" integer NOT NULL, "course_id" integer NOT NULL)
#
# Comparing to has_many :through, no joining model is needed for
# has_and_belongs_to_many association. Aslo. HABTM is simple and direct.
# 
# How to choose between the two?
# If the relationship between your models has additional data, you will need a model for it.
# In this case, you should use `has_many :through`. Otherwise, if you only need a relation
# between the two, just use HABTM, but you need to create an additional migration to generate
# the join table.
class Student < ApplicationRecord
  has_and_belongs_to_many :courses
end
