def add_course_template_student_submit(org, course_template, org_class, teacher, students)
  course = Course.create_from_template(course_template, org, teacher)
  org_class.courses << course

  course_template.track_templates.each do |track_template|
    track = Track.create_from_template(track_template, course)
    track_template.code_lesson_templates.each do |code_lesson_template|
      code_lesson = CodeLesson.create_from_template(code_lesson_template, track)
      code_lesson.correctness_test ||= "return false;"
      code_lesson.save
    end
  end
  return course
end

def assignment_class(course, org_class, teacher)
  course = Course.find(course.id)

  start_date = 2.days.ago
  end_date = 2.days.from_now

  course.assign_to_students(
    org_class.students,
    teacher,
    start_date,
    end_date
  )
end


def rand_submissions(students, course)
  course.tracks.each do |t|
    t.code_lessons.each do |c|
      students.each do |s|
        rand_num = 1 + rand(10)
        rand_num.times do |i|
          rand_time = 100 + rand(100)
          Submission.create(code_lesson_id: c.id, code:"puts \"Hello World#{rand_num}\"", student_id: s.id, time_taken: rand_time)
        end
        rand_success = 1 + rand(3)
        if rand_success == 3
          rand_time = 100 + rand(100)
          Submission.create(code_lesson_id: c.id, code:"puts \"Hello World#{rand_num}\"", student_id: s.id, time_taken: rand_time, success: true)
        end
      end
    end
  end
end

organisation = Organisation.create(name: "London Academy")
puts "Organisation created"

language_ruby = Language.create(name: "Ruby", ace_slug: "ruby", code_eval_slug: "ruby", code_eval_version: 2)
language_python = Language.create(name: "Python 3", ace_slug: "python", code_eval_slug: "python3", code_eval_version: 2)
language_java = Language.create(name: "Java", ace_slug: "java", code_eval_slug: "java", code_eval_version: 2)

languages = [
  language_ruby,
  language_python,
  language_java
]

first_names = ["James", "John", "Peter", "Mark", "Sam", "Daniel", "Sabrina", "Tiffany", "Chris", "Claire", "Grace", "Sarah", "Toma", "Ross", "Tim"]
last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Anderson", "Yung", "Green", "Popov", "Hunter", "Wheelhouse"]
course_names = ["Variables", "Methods", "Loops", "Recursion"]

list_students = []
list_teachers = []
list_classes_students = []
list_classes_teachers = []
course_templates = []

java_template = CourseTemplate.create(name: "Java", description: "Java is a verbose object oriented programming language that is strongly typed and widely used in industry.")
intro = TrackTemplate.create(name: "Introduction to Java", description: "Basic syntax for Java", course_template_id: java_template.id, order: 1)
4.times do |l|
  lesson_template = CodeLessonTemplate.create(name: course_names[l], instructions: "Test instructions", language_id: languages[2].id, order: l, track_template_id: intro.id, starting_code: "System.out.println(\"test123\");")
  puts "Introduction Code Lesson Template #{l} created"
end

method_calls = TrackTemplate.create(name: "Method Calls", description: "Method calls for objects", course_template_id: java_template.id, order: 2)
4.times do |l|
  lesson_template = CodeLessonTemplate.create(name: course_names[l], instructions: "Test instructions", language_id: languages[2].id, order: l, track_template_id: method_calls.id, starting_code: "System.out.println(\"test123\");")
  puts "Method Calls Code Lesson Template #{l} created"
end

inheritance = TrackTemplate.create(name: "Inheritance", description: "Inheritance for objects", course_template_id: java_template.id, order: 3)
4.times do |l|
  lesson_template = CodeLessonTemplate.create(name: course_names[l], instructions: "Test instructions", language_id: languages[2].id, order: l, track_template_id: inheritance.id, starting_code: "System.out.println(\"test123\");")
  puts "Inheritance Code Lesson Template #{l} created"
end
course_templates << java_template


ruby_template = CourseTemplate.create(name: "Ruby", description: "Ruby is an object oriented language is not strongly typed")
intro_ruby = TrackTemplate.create(name: "Introduction to Ruby", description: "Basic syntax for Ruby", course_template_id: ruby_template.id, order: 1)

ruby_lesson_template_1 = CodeLessonTemplate.create(name: "Methods", instructions: "Write two methods in ruby that will add and multiply its two parameters respectively.\r\n\r\nRemember you define functions like this:\r\n\r\n```\r\ndef function(a, b)\r\n  # your code here...\r\nend\r\n```", language_id: languages[0].id, order: 0, track_template_id: intro_ruby.id, starting_code: "def sum_of_vars(a, b)\r\n  # your code here...\r\n  \r\nend\r\n\r\ndef product_of_vars(a, b)\r\n  # your code here...\r\n  \r\nend\r\n", correctness_test: "return sum_of_vars(10, 20) == 30 && product_of_vars(2, 5) == 10")
ruby_lesson_template_2 = CodeLessonTemplate.create(name: "Loops", instructions: "Loop over all the elements in the given array and return the sum.\r\n\r\nYou can loop  over arrays like this:\r\n\r\n```\r\narray.each do |elem|\r\n  # code\r\nend\r\n```", language_id: languages[0].id, order: 1, track_template_id: intro_ruby.id, starting_code: "def sum_array(array)\r\n  # sum the array...\r\n  \r\nend", correctness_test: "return sum_array([1, 2, 3]) == 6 && sum_array([10, 20, 30]) == 60")
ruby_lesson_template_2 = CodeLessonTemplate.create(name: "Recursion", instructions: "Recursive functions are functions that call themselves.\r\n\r\nThe `n`th Fibonacci number is defined as the sum of the `n - 1` fibonacci number and the `n - 2` fibonacci number.", language_id: languages[0].id, order: 2, track_template_id: intro_ruby.id, starting_code: "def fib(i)\r\n  # base case(s) here...\r\n  \r\n  # recursive case here...\r\n  \r\nend\r\n", correctness_test: "return fib(1) == 1 && fib(2) == 1 && fib(3) == 2 && fib(4) == 3 && fib(29) == 514229")

method_calls = TrackTemplate.create(name: "Method Calls", description: "Method calls for objects", course_template_id: ruby_template.id, order: 2)
4.times do |l|
  lesson_template = CodeLessonTemplate.create(name: course_names[l], instructions: "Test instructions", language_id: languages[0].id, order: l, track_template_id: method_calls.id, starting_code: "puts 'test'")
  puts "Method Calls Code Lesson Template #{l} created"
end
course_templates << ruby_template



python_template = CourseTemplate.create(name: "Python", description: "Python is a easy language to start learning programming.")
intro_python_track = TrackTemplate.create(name: "Introduction to Python", description: "Basic syntax for Python", course_template_id: python_template.id, order: 1)
4.times do |l|
  lesson_template = CodeLessonTemplate.create(name: course_names[l], instructions: "Test instructions for Python Intro lesson", language_id: languages[1].id, order: l, track_template_id: intro_python_track.id, starting_code: "print('test')")
  puts "Introduction Code Lesson Template #{l} created"
end
course_templates << python_template

teacher_admin = Teacher.create(email: "teacher@gmail.com", password: "password", first_name: "Tom", last_name: "Peters", organisation_id: organisation.id)
puts "Teacher created"

student_123 = Student.create(email: "student@gmail.com", password: "password", first_name: "John", last_name: "Smith", organisation_id: organisation.id)
puts "Student created"

classes = []
3.times do |i|
  org_class = organisation.organisation_classes.create(name: "Year 1#{i}", code: "Y1#{i}")
  classes << org_class
  puts "Year1#{i} created"

  org_class.teachers << teacher_admin
  org_class.students << student_123

  list_students = []
  10.times do |j|
    rand_first = rand(first_names.length)
    rand_last = rand(last_names.length)
    first_name = first_names[rand_first]
    last_name = last_names[rand_last]
    s = Student.create(email: "#{first_name}_#{last_name}#{rand(100)}@gmail.com", password: "password", first_name: "#{first_name}", last_name: "#{last_name}", organisation_id: organisation.id)
    puts "#{s.name} created"
    org_class.students << s
    list_students << s
  end
  list_classes_students[i] = list_students

  list_teachers = []

  2.times do |k|
    rand_first = rand(first_names.length)
    rand_last = rand(last_names.length)
    first_name = first_names[rand_first]
    last_name = last_names[rand_last]
    teacher = Teacher.create(email: "#{first_name}_#{last_name}#{rand(100)}@gmail.com", password: "password", first_name: "#{first_name}", last_name: "#{last_name}", organisation_id: organisation.id)
    puts "#{teacher.name} created"
    org_class.teachers << teacher
    list_teachers << teacher
  end
  list_classes_teachers[i] = list_teachers
end

list_classes_students[0] << student_123
add_course_template_student_submit(organisation, python_template, classes[0], teacher_admin, list_classes_students[0])
add_course_template_student_submit(organisation, ruby_template, classes[0], teacher_admin, list_classes_students[0])
add_course_template_student_submit(organisation, ruby_template, classes[1], teacher_admin, list_classes_students[1])
c1 = add_course_template_student_submit(organisation, java_template, classes[2], teacher_admin, list_classes_students[2])
assignment_class(c1, classes[2], teacher_admin)
rand_submissions(list_classes_students[2], c1)
