require_relative('../db/sql_runner')

class Student

  attr_reader :id
  attr_accessor :first_name, :last_name, :house_id, :age

  def initialize(options)
    @id = options["id"] if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @house_id = options["house_id"]
    @age = options["age"]
  end

  def pretty_name
    return "#{first_name} #{last_name}"
  end

  def save
    sql = "INSERT INTO students (first_name, last_name, house_id, age)
    VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@first_name, @last_name, @house_id, @age]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.all
    sql = "SELECT*FROM students"
    students = SqlRunner.run(sql)
    students.map { |student| Student.new(student)}
  end

  def self.find(id)
    sql = "SELECT * FROM students WHERE id = $1"
    values = [id]
    students = SqlRunner.run(sql, values)
    result = Student.new(students.first)
    return result
  end

  def self.delete_all
    sql = "DELETE FROM students"
    SqlRunner.run(sql)
  end

  def house
    sql = "SELECT*FROM houses WHERE id = $1"
    values = [@house_id]
    houses = SqlRunner.run(sql, values)
    result = House.new(houses.first)
    return result
  end

end
