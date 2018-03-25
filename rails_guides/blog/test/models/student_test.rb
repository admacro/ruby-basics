require 'test_helper'

class StudentTest < ActiveSupport::TestCase

  test "should have 10 students in math course and 20 in english course" do
    math = Course.find_by(name: "Mathematics")
    english = Course.find_by(name: "English")
    
    students = Student.all
    students.each_with_index do |s, index|
      if index < 10
        s.courses << math
      else
        s.courses << english
      end
    end

    assert_equal 10, math.students.size
    assert_equal 20, english.students.size
  end

  test "should have all students in all courses" do
    courses = Course.all
    students = Student.all
    courses.each { |c| c.students = students }
    students.each { |s| assert_equal 2, s.courses.size}
  end

end
