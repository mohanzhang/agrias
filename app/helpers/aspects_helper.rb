module AspectsHelper
  def aspect_tree(node)
    children = node.children.order("weight DESC").map {|c| aspect_tree(c)}.join("\n")
    node_html = node.name

    return "<ul class=\"aspectTree\"><li>#{node_html}#{children}</li></ul>"
  end
  
end
