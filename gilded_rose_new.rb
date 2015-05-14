def update_quality(items)
  items.each { |i| i.updater unless name.include?("Sulfuras") }    
end

class Item
  attr_accessor :name, :quality, :sell_in
 
  def initialize(name, sell_in, quality)
    @name = name
    @quality = quality
    @sell_in = sell_in
  end

  def updater
    @sell_in -= 1 
    normal_updater if name.include?("NORMAL")
    aged_updater if name.include?("Aged")
    concert_updater if name.include?("concert")
    conjured_updater if name.include?("Conjured")
    @quality = 50 if quality > 50
  end
    
  def normal_updater
    sell_in < 1 ? @quality -= 2 : @quality -= 1
    @quality = 0 if quality < 0
  end

  def aged_updater
    @quality += 1
    @quality += 1 if sell_in < 1
  end

  def concert_updater
    sell_in > 9 ? @quality += 1 : @quality += 2 
    @quality += 1 if sell_in < 5
    @quality = 0 if sell_in < 0
  end

  def conjured_updater
    sell_in < 0 ? @quality -= 4 : @quality -= 2
    @quality = 0 if @quality < 0
  end

end
