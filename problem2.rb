#!/usr/bin/ruby

class Computer
  attr_accessor :tasks, :temp_set, :target

  def initialize(target)
    @tasks = [2,3,17,23,42,98]
    @temp_set = [@tasks]
    @target = target
  end

  # build up the sets
  def find_set()
    while(!found_target?(temp_set,target) and !temp_set.last.empty?)
      add_one_more_item(temp_set, target)
      # Removing duplicates causes an incredible speedup
      temp_set[temp_set.length-1] = temp_set.last.uniq
    end
    temp_set.length
  end

  def found_target?(set,target)
    set.last.include?(target)
  end

  def add_one_more_item(temp_set, target)
    temp = []
    for last_found in temp_set.last
      for available in tasks
        if last_found + available <= target
          temp.push last_found + available
        end
      end
    end
    temp_set.push temp
  end

end

unless ARGV[0]
  puts "Please give a comma separated list of targets\nEX: problem2.rb 2349,2102,2001,1747"
  exit
end

inputs = ARGV[0].split /,/

answers = []
for input in inputs do
  comp = Computer.new(input.to_i)
  answers.push comp.find_set
  puts "#{input}: #{answers.last}"
end

puts "Answer: #{answers.inject(:*)}"


