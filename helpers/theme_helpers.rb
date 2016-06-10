module ThemeHelpers
  def nav_link_to(title, url, active=nil)
    active = current_page.url.index(url) == 0 if active.nil?
    "<li class=\"#{"active" if active}\">" + link_to(title, url) + "</li>"
  end

  def define(term)
    definition = data.glossary.send(term.downcase)
    raise "Term '#{term.downcase}' not defined in glossary" unless definition
    '<span data-toggle="tooltip" title="'+definition+'">'+term+'</span>'
  end

  def slugify(str)
    str.strip.downcase.gsub(/(&|&amp;)/, ' and ').gsub(/[\s\/\\]/, '-').gsub(/[^\w-]/, '').gsub(/[-]{2,}/, '-').gsub(/^-|-$/, '')
  end

  def previous_project(project)
    projects = data.work.keys
    index = projects.index(project)
    index == 0 ? projects.last : projects[index.to_i-1]
  end

  def next_project(project)
    projects = data.work.keys
    index = projects.index(project)
    index == projects.size-1 ? projects.first : projects[index.to_i+1]
  end

  #helper to match font-awesome-rails gem
  def fa_icon(names = "flag", options = {})
    classes = ["fa"]
    classes.concat names.split(/\s+/).map { |n| "fa-#{n}" }
    classes.concat Array(options.delete(:class))
    text = options.delete(:text)
    right_icon = options.delete(:right)
    icon = content_tag(:i, nil, options.merge(:class => classes.join(" ")))
    return icon if text.blank?
    elements = [icon, text]
    elements.reverse! if reverse_order
    array.map { |i| ERB::Util.html_escape(i) }.join(" ").html_safe
  end

  def retina_image_tag(url, options={})
    return image_tag(url, options) if url =~ /(https?:)?\/\//
    options[:srcset] ||= "#{image_path(url)} 2x"
    extension = File.extname(url)
    #don't alter URL in development as image won't exist in /source/
    url.sub!(extension, "@1x#{extension}") if build?
    image_tag(url, options)
  end
end
