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

  def nested_sidebar_nav(
    item,
    tag_type: { branch: :ul, leaf: :li },
    tag_class: { branch: 'branch', leaf: 'leaf' }
  )
    item.parent.root? ? list_of_siblings(item, tag_type, tag_class) : list_of_parents_siblings(item, tag_type, tag_class)
  end

  def list_of_children(item, tag_type, tag_class)
    return if item.children.size.zero?

    tag.send(tag_type[:branch], class: tag_class[:branch]) do
      item.children.collect do |child|
        # concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) { link_to(">#{child}", child, class:'') })
        concat(link_to(">#{child}", child, class: tag_class[:leaf]))
      end
    end
  end

  def list_of_siblings(item, tag_type, tag_class)
    tag.send(tag_type[:branch], class: tag_class[:branch]) do
      item.siblings.collect do |sibling|
        next if sibling.root?

        # concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) { item == sibling ? sibling.display : link_to(sibling) })
        if item == sibling
          concat(tag.div(" > #{sibling.display}", class: tag_class[:leaf]))
        else
          concat(link_to(sibling.to_s, sibling, class: tag_class[:leaf]))
        end
        next unless sibling == item && item.children.size != 0

        concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) { list_of_children(item, tag_type, tag_class) })
      end
    end
  end

  def list_of_parents_siblings(item, tag_type, tag_class)
    tag.send(tag_type[:branch], class: tag_class[:branch]) do
      item.parent.siblings.collect do |p_sibling|
        next if p_sibling.root?

        concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) { link_to(p_sibling) })
        next unless p_sibling == item.parent

        concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) { list_of_siblings(item, tag_type, tag_class) })
      end
    end
  end
end

