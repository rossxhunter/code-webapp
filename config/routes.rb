Rails.application.routes.draw do
  root to: 'pages#home'

  mount ActionCable.server => '/cable'

  get '/teacher-dashboard', to: 'dashboard#teacher', as: :teacher_dashboard
  get '/student-dashboard', to: 'dashboard#student', as: :student_dashboard

  get '/dashboard/change-class/:id', to: 'dashboard#change_class', as: :change_class
  get '/students/leaderboard', to: 'students#leaderboard', as: :students_leaderboard

  get '/assignments/:id/cancel', to: 'assignments#cancel', as: :cancel_assignment

  post '/dashboard/get-tracks', to: 'dashboard#get_tracks', as: :ajax_tracks
  post '/dashboard/get-code-lessons', to: 'dashboard#get_code_lessons', as: :ajax_code_lessons
  post '/dashboard/get-students', to: 'dashboard#get_students', as: :ajax_students

  get '/assignments/old-assignments/:id', to: 'assignments#old_assignments', as: :student_old_assignments

  get '/code-lessons/:code_lesson_id/submissions/:student_id', to: 'submissions#student_submissions', as: :student_lesson_submissions
  get 'submissions/:id', to: 'submissions#show', as: :submission

  get '/insights/course/:id', to: 'insights#course', as: :course_insights
  get '/insights/track/:id', to: 'insights#track', as: :track_insights
  get '/insights/student/:id', to: 'insights#student', as: :student_insights
  get '/insights/code_lesson/:id', to: 'insights#code_lesson', as: :code_lesson_insights
  post '/insights/get-course-submissions', to: 'insights#get_course_submissions', as: :ajax_course_submissions
  post '/insights/get-track-submissions', to: 'insights#get_track_submissions', as: :ajax_track_submissions
  post '/insights/get-code-lesson-submissions', to: 'insights#get_code_lesson_submissions', as: :ajax_code_lesson_submissions
  post '/insights/get-student-submissions', to: 'insights#get_student_submissions', as: :ajax_students_submissions
  post '/insights/get-student-time-spent', to: 'insights#get_student_time_spent', as: :ajax_students_time_spent


  resources :organisation_classes, path: 'classes'

  get '/classes/:id/courses', to: 'organisation_classes#courses', as: :organisation_class_courses
  post '/courses/:course_id/assign-to-classes', to: 'courses#assign_to_classes', as: :assign_course_to_classes

  resources :courses, shallow: true do
    resources :tracks do
      resources :code_lessons, path: 'code-lessons' do
        resources :submissions
      end
    end
  end

  post '/code-lessons/:id/run-code', to: 'code_lessons#run_code', as: :run_code
  post '/code-lessons/:id/get-hint', to: 'code_lessons#get_hint', as: :get_hint
  post '/code-lessons/:id/get-starting-code', to: 'code_lessons#get_starting_code', as: :get_starting_code
  post '/code-lessons/:id/get-next-lesson', to: 'code_lessons#get_next_lesson', as: :get_next_lesson
  get '/code-lessons/:code_lesson_id/chat/:chat_id', to: 'code_lessons#chat', as: :code_lesson_chat

  get '/library', to: 'course_templates#index', as: :course_templates
  post '/library', to: 'course_templates#create'
  post '/course-templates/:course_template_id/add-to-organisation', to: 'course_templates#add_to_organisation', as: :add_course_template_to_organisation

  resources :course_templates, path: 'course-templates', shallow: true, except: :index do
    resources :track_templates, path: 'track-templates' do
      resources :code_lesson_templates, path: 'code-lesson-templates'
    end
  end

  resources :chat_messages do
    resources :chats
  end

  resources :live_coding_sessions, path: 'live-coding-sessions'
  get '/live-coding-sessions/:id/resolve', to: 'live_coding_sessions#resolve', as: :resolve_live_coding_session
  post '/live-coding-sessions/:live_coding_session_id/publish-code', to: 'live_coding_sessions#publish_code', as: :live_coding_session_publish_code

  get '/students/:id/get-assignments', to: 'students#get_assignments', as: :student_get_assignments

  get '/students/new', to: 'students#new', as: :new_student
  post '/students', to: 'students#create'

  devise_for :admins, skip: [:registrations]
  devise_for :teachers
  devise_for :students
  resources :students, only: [:index, :show, :edit, :destroy, :update]

end
