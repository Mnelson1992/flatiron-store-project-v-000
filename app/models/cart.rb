class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def total
    total = 0
    self.line_items.each do |line_item|
      total += (line_item.item.price * line_item.quantity)
    end
    total
  end

  def add_item(item_id)
    if self.item_ids.include?(item_id.to_i)
      line_item = self.line_items.find_by(:item_id => item_id)
      line_item.quantity += 1
      line_item
    else
      line_item = self.line_items.build(:item_id => item_id)
      line_item
    end
  end

  def checkout
    self.status = "submitted"
    change_inventory
  end

  def change_inventory
    if self.status = "submitted"
      self.line_items.each do |line_item|
        line_item.item.inventory -= line_item.quantity
        line_item.item.save
      end
    end
  end

end
