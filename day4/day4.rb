class Passport
  attr_accessor :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid

  def initialize(byr: '', iyr: '', eyr: '', hgt: '', hcl: '', ecl: '', pid: '', cid: '')
    @byr = byr
    @iyr = iyr
    @eyr = eyr
    @hgt = hgt
    @hcl = hcl
    @ecl = ecl
    @pid = pid
    @cid = cid
  end

  def byr_valid?
    !byr.empty? && byr.to_i >= 1920 && byr.to_i <= 2002
  end

  def iyr_valid?
    !iyr.empty? && iyr.to_i >= 2010 && iyr.to_i <= 2020
  end

  def eyr_valid?
    !eyr.empty? && eyr.to_i >= 2020 && eyr.to_i <= 2030
  end

  def hgt_valid?
    return false if hgt.empty?

    height = hgt.split(/(\D+)/)

    (height[1] == 'cm' && height[0].to_i >= 150 && height[0].to_i <= 193) || (height[1] == 'in' && height[0].to_i >= 59 && height[0].to_i <= 76)
  end

  def hcl_valid?
    !(hcl.empty? || hcl.length != 7 || hcl[0] != '#' || !hcl[1..6].match(/\A[a-zA-Z0-9]*\z/))
  end

  def ecl_valid?
    !ecl.empty? && %w[amb blu brn gry grn hzl oth].include?(ecl)
  end

  def pid_valid?
    pid.length == 9 && pid[1..6].match(/\A[0-9]*\z/)
  end

  def valid?
    byr_valid? && iyr_valid? && eyr_valid? && hgt_valid? && hcl_valid? && ecl_valid? && pid_valid?
  end
end

valid_count = 0
passports = []
current_passport = Passport.new

File.open("input.txt", "r").each_line do |line|
  if line.strip.empty?
    valid_count += 1 if current_passport.valid?
    current_passport = Passport.new
  else
    attributes = line.split(' ')
    attributes.each do |attr|
      key = attr.split(':').first
      val = attr.split(':').last

      current_passport.send("#{key}=", val)
    end
  end
end

valid_count += 1 if current_passport.valid?
puts valid_count