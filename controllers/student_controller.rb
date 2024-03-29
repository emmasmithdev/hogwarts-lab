require_relative('../models/student.rb')
require_relative('../models/house.rb')

#index
get '/students' do
  @students = Student.all()
  erb(:"students/index")
end

#New
get '/students/new' do
  @houses = House.all
  erb(:"students/new")
end

#create
post '/students' do
  @student = Student.new(params)
  @student.save
  erb(:"students/create")
end
