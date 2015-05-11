def update_quality(items)

    ages_well = []
    ages_poorly = []
    conjured = []
    sulfuras = items.find { |i| i.name.include?("Sulfuras") }
    items.delete(sulfuras)
    items.each do |i|
        ages_well << i if i.name == 'Aged Brie' || i.name == 'Backstage passes to a TAFKAL80ETC concert'
        conjured << i if i.name.include?('Conjured')
        ages_poorly << i unless ages_well.include?(i) || conjured.include?(i) 
    end

    ages_well.each do |w|
        unless w.quality >= 50
            w.quality += 1
            if w.name.include?("concert")
                w.quality += 1 if w.sell_in < 11
                w.quality += 1 if w.sell_in < 6
                w.quality = 0 if w.sell_in <= 0
            else
                w.quality += 1 unless w.sell_in > 0 || w.quality >= 50 
            end
        end
    end

    conjured.each do |c|
        unless c.quality == 0
            c.quality -= 2
            c.quality -= 2 if c.sell_in < 1
        end
    end

    ages_poorly.each do |p|
        unless p.quality == 0
            p.quality -= 1
            p.quality -= 1 if p.sell_in < 1
        end
    end

    items.each do |i|   
        i.sell_in -= 1
    end
end

Item = Struct.new(:name, :sell_in, :quality)
