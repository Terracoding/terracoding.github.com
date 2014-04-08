module ThemeHelpers
  def entity_obfuscate(string)
    string.gsub(/./){ |char| "&##{char[0].ord};" }
  end

  def percent_obfuscate(string)
    "%" + string.unpack("H2" * string.bytesize).join("%").upcase
  end

  def image_collection(dir, type)
    html = '<div class="'+type.to_s+'">'
    source_path = "/images/galleries"
    pattern = "#{Dir.pwd}/source#{source_path}/#{dir}/*.{jpg,jpeg,png,gif}"

    Dir.glob(pattern) do |path|
      filename = File.basename(path)
      file_path = "#{source_path}/#{dir}/#{filename}"

      html += '<a href="'+file_path+'" target="_blank">' if type == :gallery
      html += '<img src="'+file_path+'" alt="" />'
      html += '</a>' if type == :gallery
    end

    html += '</div>'
  end

  def gallery(slug)
    image_collection(slug, :gallery)
  end

  def slideshow(slug)
    image_collection(slug, :slideshow)
  end

  def nav_link_to(title, url, active=nil)
    active = current_page.url.index(url) == 0 if active.nil?
    "<li class=\"#{"active" if active}\">" + link_to(title, url) + "</li>"
  end

  def define(term)
    definition = data.glossary.send(term.downcase)
    raise "Term '#{term}' not defined in glossary" unless definition
    '<span data-toggle="tooltip" title="'+definition+'">'+term+'</span>'
  end

  def slugify(str)
    str.strip.downcase.gsub(/(&|&amp;)/, ' and ').gsub(/[\s\/\\]/, '-').gsub(/[^\w-]/, '').gsub(/[-]{2,}/, '-').gsub(/^-|-$/, '')
  end

  def previous_project(project)
    projects = data.work.keys
    index = projects.index(project)
    index == 0 ? projects.last : projects[index-1]
  end

  def next_project(project)
    projects = data.work.keys
    index = projects.index(project)
    index == projects.size-1 ? projects.first : projects[index+1]
  end

  def icon_tag_options(icon_set, options={})
    options[:class] ||= options["class"]

    modifiers = options[:modify].to_s.split(" ")
    modifiers.map! { |modifier| "#{icon_set}-#{modifier}" }

    options[:class] = modifiers.unshift(options[:class], icon_set).compact.join(" ")
    options.delete_if { |key, val| ["class", :modify].member?(key) }
  end

  def iconic(name, options={})
    options[:modify] ||= "sm"
    options["data-src"] = "/images/iconic/#{name}.svg"
    tag("img", icon_tag_options("iconic", options))
  end

  def fa(name, options={})
    options[:modify] = [name, options[:modify]].compact.join(" ")
    content_tag("i", "", icon_tag_options("fa", options))
  end
end
