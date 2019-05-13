module Middleman::Metaman::Helpers

  def set_meta_tags(tags)
    @meta_tags ||= ActiveSupport::HashWithIndifferentAccess.new
    @meta_tags.merge!(tags)
  end

  def display_meta_tags
    @meta_tags ||= ActiveSupport::HashWithIndifferentAccess.new
    @meta_tags[:og] ||= ActiveSupport::HashWithIndifferentAccess.new
    @meta_tags[:twitter] ||= ActiveSupport::HashWithIndifferentAccess.new
    site_meta_tags = (data.meta_tags || {}).with_indifferent_access
    @meta_tags = site_meta_tags.merge(@meta_tags)

    # get meta from translation
    t_page = current_page.path.gsub('.html', '').gsub('-', '_').gsub('/', '.')
    t_key = "#{t_page}.meta"
    @meta_tags.merge!(I18n.t(t_key)) if I18n.exists?(t_key)

    # get meta from frontmatter
    @meta_tags.merge!(
      {
        title: current_page.data.title,
        description: current_page.data.description
      }.compact
    )


    html = []
    @meta_tags[:title] = full_title(@meta_tags[:title])
    html.push content_tag(:title, @meta_tags[:title])

    excluded_keys = %w(site_name separator title image)
    meta_hash = @meta_tags.reject { |k| excluded_keys.include?(k) }.merge(
      og: meta_open_graph,
      twitter: meta_twitter
    )

    meta_hash.each do |key, value|
      next unless value

      html.push generate_meta_html(key, value)
    end
    html.flatten.join
  end

  private

  def full_title(title)
    if title.is_a?(Hash) && title[:site_name].nil?
      title[:title]
    else
      title + " #{@meta_tags[:separator] || '|'} " + @meta_tags[:site_name]
    end
  end

  def generate_meta_html(key, value)
    return unless key && value
    return generate_meta_hash(key, value) if value.is_a?(Hash)
    return generate_meta_array(key, value) if value.is_a?(Array)

    value += current_page.url if key == 'og:url'
    value = meta_image_url(value) if key.to_s.include?('image')

    [tag(:meta, "#{meta_key(key)}" => key, content: value)]
  end

  def generate_meta_hash(key, value)
    html = []
    value.each do |hk, hv|
      html.push generate_meta_html("#{key}:#{hk}", hv)
    end
    html
  end

  def generate_meta_array(key, value)
    html = []
    value.each do |av|
      html.push generate_meta_html(key, av)
    end
    html
  end

  # determine key for meta tag based on name
  def meta_key(key)
    key.match?(/^(og|music|video|article|book|profile):/i) ? 'propery' : 'name'
  end

  # generate open graph meta
  def meta_open_graph
    og = ActiveSupport::HashWithIndifferentAccess.new
    og[:url] = default_value(:og, :url) || host
    og[:type] = default_value(:og, :type, 'website')
    og[:site_name] = default_value(:og, :site_name)
    og[:title] = default_value(:og, :title)
    og[:description] = default_value(:og, :description)
    og[:image] = default_value(:og, :image)

    @meta_tags[:og].reject { |k| og.keys.include?(k) }.each do |k, v|
      og[k] = v
    end

    og
  end

  # generate twitter meta
  def meta_twitter
    twitter = ActiveSupport::HashWithIndifferentAccess.new
    twitter[:url] = default_value(:twitter, :url) || host
    twitter[:title] = default_value(:twitter, :title)
    twitter[:description] = default_value(:twitter, :description)
    twitter[:image] = default_value(:twitter, :image)

    @meta_tags[:twitter].reject { |k| twitter.keys.include?(k) }.each do |k, v|
      twitter[k] = v
    end

    twitter
  end

  # get the meta image url
  def meta_image_url(image)
    "#{host}#{image_path(image)}" if image
  end

  def default_value(scope, key, default = nil)
    @meta_tags[scope][key] || @meta_tags[key] || default
  end

  def host
    Middleman::MetamanExtension.options.host
  end

end
