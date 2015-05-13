def update_quality(items)
    sulfuras = items.find { |i| i.name.include?("Sulfuras") }
    items.delete(sulfuras)
  QualityUpdater.new.update(items)
end

class QualityUpdater
  def update(items)
    items.each do |i|
      i.quality -= 1 
      i.quality -= 1 if i.sell_in <= 0
      AgedUpdater.new.update(i) if i.name.include?('Aged')
      ConcertUpdater.new.update(i) if i.name.include?('concert')
      ConjuredUpdater.new.update(i) if i.name.include?('Conjured')
      i.sell_in -= 1
      reset_item(i)
    end 
  end

  def reset_item(item)
    item.quality = 0 if item.quality < 0
    item.quality = 50 if item.quality > 50
  end
end

class AgedUpdater
  def update(item)
    item.quality += 2
    item.quality += 2 if item.sell_in <= 0
  end
end

class ConcertUpdater
  def update(item)
    item.quality += 2 
    item.quality += 1 if item.sell_in < 11
    item.quality += 1 if item.sell_in < 6
    item.quality = 0 if item.sell_in < 1
  end
end

class ConjuredUpdater
  def update(item)
    item.quality -= 1
    item.quality -= 1 if item.sell_in < 1
  end
end
    



Item = Struct.new(:name, :sell_in, :quality)
