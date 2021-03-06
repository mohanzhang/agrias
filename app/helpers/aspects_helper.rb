module AspectsHelper
  def aspect_tree(node)
    children = node.children.order("weight DESC").map {|c| aspect_tree(c)}.join("\n")
    node_html = link_to node.name, aspect_path(node), :remote => true, "data-output-mode" => "extend"

    return "<ul class=\"aspectTree\"><li>#{node_html}#{children}</li></ul>"
  end
  
end
