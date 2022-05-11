# frozen_string_literal: true

# Helpers for the entire application
module ApplicationHelper
  def active_class(path)
    if request.path == path
      'active'
    else
      ''
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


  # category Sidebar Suite

  def nested_sidebar_nav(item)
    return list_of_siblings(item) if item.parent.root?

    list_of_parents_siblings(item)
  end

  def list_of_children(item)
    return if item.children.size.zero?

    tag.li do
      tag.ul do
        item.children.collect do |child|
          concat(tag.li(link_to(child)))
        end
      end
    end
  end

  def list_of_siblings(item)
    tag.ul do
      item.siblings.collect do |sibling|
        next if sibling.root?

        concat(tag.li(item == sibling ? sibling : link_to(sibling)))
        next unless sibling == item

        concat(list_of_children(item))
      end
    end
  end

  def list_of_parents_siblings(item)
    tag.ul do
      item.parent.siblings.collect do |sibling|
        next if sibling.root?

        concat(tag.li(link_to(sibling)))
        concat(tag.li(list_of_siblings(item))) if sibling == item.parent
      end
    end
  end
end
