require "rubygems"
require "json"

class Store
  attr_accessor :items, :total_sale

  def initialize()
    @items = []
    @total_sale = 0
  end
  
  def import_items(filename)
    raw = JSON.parse(IO.read(filename))
    raw.each do |item|
      new_item = {}
      item.keys.each do |key| 
        new_item[(key.to_sym rescue key) || key] = item.delete(key)
      end
      new_item[:available] = new_item[:in_store] > 0
      @items << new_item
    end
  end

  def is_numeric?(param)
    param.is_a?(Integer) || param.is_a?(Float)
  end

  def search(params)
    found = []
    @items.each do |item|
      found << item if item.values_at(*params.keys) == params.values
    end
    found
  end

  def items_sorted_by(value, order)
    @items.sort!{|x,y| x[value] <=> y[value]}
    order == :desc ? @items.reverse! : @items
  end

  def categories
    @items.collect{|item| item[:category]}.uniq
  end

  def unique_articles_in_category(category)
    self.search(:category => category).collect{|item| item.name}.uniq
  end

  class Cart
    attr_accessor :store, :items

    def initialize(store)
      @store = store
      @items = []
    end

    def total_items
      total = 0
      @items.each do |ci|
        total += ci[:quantity]
      end
      total
    end

    def add_item(item, n=1)
      si = @store.items.detect{|si| si == item}
      unless si[:in_store] < 1
        if si[:in_store] < n
          n = si[:in_store]
        end
        ci = @items.detect{|ci| ci[:item] == item}
        ci.nil? ? @items << {:item => item, :quantity => n} : ci[:quantity] += n
      end
    end

    def unique_items
      @items.collect{|ci| ci[:item]}
    end

    def total_cost
      sum = 0.0
      @items.each do |ci|
        ci[:quantity].times {sum += ci[:item][:price]}
      end
      sum.round(2)
    end

    def checkout!
      @items.each do |ci|
        si = @store.items.detect{|si| si == ci[:item]}
        si[:in_store] -= ci[:quantity]
      end
      @store.total_sale += total_cost
    end
  end
end

class Hash
  def name
    self[:name]
  end
  
  def price
    self[:price]
  end

  def in_store
    self[:in_store]
  end
end
