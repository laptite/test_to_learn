require 'yaml'

class Todo
  def initialize(title)
    @title = title
    @completed = false
  end

  def title
    @title
  end

  def completed?
    @completed
  end

  def complete
    @completed = true
  end
end

class TodoList
  def initialize(filename)
    @filename = filename
    if File.exists?(filename)
      serialized = File.read(filename)
      @tasks = YAML.load(serialized)
    else
      @tasks = []
    end
  end

  def add(title)
    task = Todo.new(title)
    @tasks << task
  end

  def complete(index)
    task = @tasks[index]
    task.complete
  end

  def to_s
    output = ''
    @tasks.each_with_index do |task, i|
      output << "#{i}: #{task.title}"
    end
    output
  end

  def save
    serialized = YAML.dump(@tasks)
    File.open(@filename, 'w') {|f| f.write(serialized) }
  end
end



list = TodoList.new('todos.yml')
list.add("dry cleaning")
list.save

l2 = TodoList.new('todos.yml')
puts l2.to_s == list.to_s
