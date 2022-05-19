# frozen_string_literal: true

# Methods required to create a flattened list of items to pass to the sidebar partial
module Sidebar
  # category Sidebar Suite
  def flat_sidebar_nav(item)
    list = Category.root.own_tree
    unroll_sidebar(list)
  end

  def unroll_sidebar(list, depth = 0)
    list.collect do |node|
      level = [{item: node[:self], depth:}] 

      node.key?(:children) ? level.append(unroll_sidebar(node[:children], depth + 1)) : level
    end.flatten
  end

  # Second retired sidebar
  # def flat_list_of_children(item)
  #   return if item.children.size.zero?

  #   item.children.collect do |child|
  #     child
  #   end
  # end

  # def flat_list_of_siblings(item)
  #   list = []
  #   item.siblings.collect do |sibling|
  #     next if sibling.root?

  #     list.append(sibling)
  #     next unless sibling == item && !item.children.empty?

  #     list.append(flat_list_of_children(item))
  #   end
  #   list
  # end

  # def flat_list_of_parents_siblings(item)
  #   list = []
  #   item.parent.siblings.collect do |p_sibling|
  #     next if p_sibling.root?

  #     list.append(p_sibling)
  #     next unless p_sibling == item.parent

  #     list.append(flat_list_of_siblings(item))
  #   end
  #   list
  # end

  #
  # Retired original implementation
  # Now the displaying the items can be controlled directly by the view instead of passing
  # symbols for tags and strings for class values
  #
  # An example of the code used for displaying the list as list-group-items
  # <% leaf_attr = {tag: :div, class:'leaf list-group-item list-group-item-action list-group-item-primary p-3 px-2'} %>
  # <% branch_attr = {tag: :div, class: 'branch' }%>
  #
  # def nested_sidebar_nav(
  #   item,
  #   tag_type: { branch: :ul, leaf: :li },
  #   tag_class: { branch: 'branch', leaf: 'leaf' },
  #   tier_class: { grand_p: 'grand-parent', p: 'parent', s: 'sibling', c: 'child' }
  # )

  #   tag.send(tag_type[:branch], tag_class[:branch]) do
  #     concat(link_to(item.grandparent, item.grandparent, class: "#{tag_class[:leaf]} #{tier_class[:grand_p]}"))
  #     if item.parent.root?
  #       concat(nested_list_of_siblings(item, tag_type, tag_class, tier_class))
  #     else
  #       concat(nested_list_of_parents_siblings(item, tag_type, tag_class, tier_class))
  #     end
  #   end
  # end

  # def nested_list_of_children(item, _tag_type, tag_class, _tier_class)
  #   return if item.children.size.zero?

  #   # tag.send(tag_type[:branch], class: tag_class[:branch]) do
  #   item.children.collect do |child|
  #     # concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) { link_to(">#{child}", child, class:'') })
  #     concat(link_to(child.to_s, child, class: "#{tag_class[:leaf]} child"))
  #   end
  #   # end
  # end

  # def nested_list_of_siblings(item, tag_type, tag_class, tier_class)
  #   tag.send(tag_type[:branch], class: tag_class[:branch]) do
  #     item.siblings.collect do |sibling|
  #       next if sibling.root?

  #       # concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) { item == sibling ? sibling.display : link_to(sibling) })
  #       if item == sibling
  #         concat(tag.div(sibling.display, class: "#{tag_class[:leaf]} active"))
  #       else
  #         concat(link_to(sibling.to_s, sibling, class: tag_class[:leaf]))
  #       end
  #       next unless sibling == item && !item.children.empty?

  #       concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) do
  #                nested_list_of_children(item, tag_type, tag_class, tier_class)
  #              end)
  #     end
  #   end
  # end

  # def nested_list_of_parents_siblings(item, tag_type, tag_class, tier_class)
  #   tag.send(tag_type[:branch], class: tag_class[:branch]) do
  #     item.parent.siblings.collect do |p_sibling|
  #       next if p_sibling.root?

  #       # concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) { link_to(p_sibling, p_sibling, class: tag_class[:leaf])})
  #       concat(link_to(p_sibling, p_sibling, class: tag_class[:leaf]))
  #       next unless p_sibling == item.parent

  #       concat(tag.send(tag_type[:leaf], class: tag_class[:leaf]) do
  #                nested_list_of_siblings(item, tag_type, tag_class, tier_class)
  #              end)
  #     end
  #   end
  # end
  #
end
