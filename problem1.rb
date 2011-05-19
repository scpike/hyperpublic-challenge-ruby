#!/usr/bin/ruby


class Computer
  attr_accessor :lines, :scores
  def initialize(file)

    file = File.open(file)
    @lines = []
    while (line = file.gets)
      @lines.push line.chars.to_a
    end
    @scores = Array.new(@lines.length)

  end

  def score(line_num)
   # puts "scoring #{line_num}"
    unless self.scores[line_num]
      friends = friends(line_num)
    #  puts "Friends were #{friends}\n"
      friend_score_total = 0
      if !friends.empty?
        friend_scores = friends.collect{ |friend| score(friend)}
        if friend_scores
          friend_score_total = friend_scores.inject(:+)
        end
      end

      self.scores[line_num] = friends.length + friend_score_total
    end
    scores[line_num]

  end

  def friends(line_num)
    line = self.lines[line_num]
    res = []
    for x in (0..line.length-1) do
      if line[x] == 'X'
        res.push x
      end
    end
    res
  end
end

unless ARGV[0]
  puts "Please pass a filename\nEX: problem1.rb challenge1input.txt"
  exit
end

file = ARGV[0]

comp = Computer.new(file)
for line in (0.. comp.lines.length-1) do
  comp.score(line)
end

res = comp.scores.sort

puts "Top 3 scores were"
puts res[res.length-3..res.length-1]
puts "Answer: #{res[res.length-3..res.length-1].reverse}"
