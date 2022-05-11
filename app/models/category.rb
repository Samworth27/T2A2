# frozen_string_literal: true

# path_to_root returns list of objects
class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :children, foreign_key: :category_id, class_name: 'Category'
  belongs_to :parent, foreign_key: :category_id, class_name: 'Category'
  has_many :items, foreign_key: :category_id, class_name: 'Item'

  def to_s
    display
  end

  def root?
    self == parent
  end

  def siblings
    parent.children
  end

  def grandparent
    parent.parent
  end

  def path_to_root
    path = []
    node = self
    loop do
      path.append(node)
      node = node.parent
      return path if node == node.parent
    end
  end

  def tree(max_depth = 1000)
    puts children.size
    return display.to_sym if children.size.zero? || max_depth.zero?
    return display.to_sym => children.map { |child| child.tree(max_depth - 1) } if max_depth.positive?
  end
end
