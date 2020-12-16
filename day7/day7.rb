class Bag
  attr_reader :name, :contains

  def initialize(name:)
    @name = name
    @contains = []
  end

  def add_bag(bag, count = 0)
    @contains << { bag: bag, count: count }
  end

  def contains_bag?(bag)
    contains.map{ |child| child[:bag] == bag }.any?
  end

  def can_contain_bag?(bag)
    return true if contains_bag?(bag)
    contains.map { |child| child[:bag].can_contain_bag?(bag) }.any?
  end

  def total_sub_bags
    contains.map{ |child| child[:count] + (child[:count] * child[:bag].total_sub_bags) }.sum
  end
end


@bag_list = []
total = 0

def find_or_create_bag(name)
  bag = @bag_list.find{ |bag| bag.name == name }
  @bag_list << (bag = Bag.new(name: name)) if bag.nil?
  bag
end

File.open("input.txt", "r").each_line do |line|
  line = line.strip
  name = line.split(' bags').first
  bag = find_or_create_bag(name)

  next if line.include?('contain no other bags.')

  line.split('contain').last.strip.split(', ').map{|str| str.split(' ')[0..2] }.each do |child|
    bag_count = child[0].to_i
    child_name = child[1..2].join(' ')
    child_bag = find_or_create_bag(child_name)
    bag.add_bag(child_bag, bag_count) unless bag.contains.include?(child_bag)
  end
end

find_bag = @bag_list.find{ |bag| bag.name == 'shiny gold' }
@bag_list.each { |bag| total += 1 if bag.can_contain_bag?(find_bag) }

puts "Bags containing shiny gold: #{total}"
puts "Shiny gold sub bag count: #{find_bag.total_sub_bags}"
