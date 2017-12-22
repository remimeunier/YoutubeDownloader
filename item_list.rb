class ItemList

  attr_reader :items

  def initialize
    @items = []
  end

  def add(item)
    @items << item
  end

  def to_s
    items.each { |item| item.to_s }
  end
end
