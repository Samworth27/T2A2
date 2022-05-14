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
    tag_class: { branch: 'branch', leaf: 'leaf' },
    tier_class: { grand_p: 'grand-parent', p: 'parent', s: 'sibling', c: 'child' }
  )
    tag.send(tag_type[:branch], tag_class[:branch]) do
      concat(link_to(item.grandparent, item.grandparent, class: "#{tag_class[:leaf]} #{tier_class[:grand_p]}"))
      if item.parent.root?
        concat(list_of_siblings(item, tag_type, tag_class, tier_class))
      else
        concat(list_of_parents_siblings(item, tag_type, tag_class, tier_class))
      end
    end
  end

  def list_of_children(item, _tag_type, tag_class, _tier_class)
    return if item.children.size.zero?

    # tag.send(tag_type[:branch], class: tag_class[:branch]) do
    item.children.collect do |child|
      # concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) { link_to(">#{child}", child, class:'') })
      concat(link_to(child.to_s, child, class: tag_class[:leaf] + ' child'))
    end
    # end
  end

  def list_of_siblings(item, tag_type, tag_class, tier_class)
    tag.send(tag_type[:branch], class: tag_class[:branch]) do
      item.siblings.collect do |sibling|
        next if sibling.root?

        # concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) { item == sibling ? sibling.display : link_to(sibling) })
        if item == sibling
          concat(tag.div(sibling.display, class: "#{tag_class[:leaf]} active"))
        else
          concat(link_to(sibling.to_s, sibling, class: tag_class[:leaf]))
        end
        next unless sibling == item && item.children.size != 0

        concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) do
                 list_of_children(item, tag_type, tag_class, tier_class)
               end)
      end
    end
  end

  def list_of_parents_siblings(item, tag_type, tag_class, tier_class)
    tag.send(tag_type[:branch], class: tag_class[:branch]) do
      item.parent.siblings.collect do |p_sibling|
        next if p_sibling.root?

        # concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) { link_to(p_sibling, p_sibling, class: tag_class[:leaf])})
        concat(link_to(p_sibling, p_sibling, class: tag_class[:leaf]))
        next unless p_sibling == item.parent

        concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) do
                 list_of_siblings(item, tag_type, tag_class, tier_class)
               end)
      end
    end
  end

  def flash_class(level)
    { notice: 'alert alert-info',
      success: 'alert alert-success',
      error: 'alert alert-danger',
      alert: 'alert alert-warning' }[level.to_sym]
  end
end
