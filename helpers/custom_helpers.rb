require 'open-uri'
require 'nokogiri'

module CustomHelpers
  def icon(icon, cssclass = "", attrs = {})
    width = attrs[:width] || 76
    height = attrs[:height] || 76
    viewbox_width = attrs[:viewbox_width] || width
    viewbox_height = attrs[:viewbox_height] || height
    label = attrs[:label] || ""
    content_tag :svg, viewbox: "0 0 #{viewbox_width} #{viewbox_height}", width: width, height: height, class: cssclass, aria: { label: label }, role: "img" do
      partial "includes/icons/#{icon}.svg"
    end
  end

  def svg_image(icon, cssclass = "", attrs = {})
    data = attrs[:data] || ""
    content_tag :svg, class: cssclass, role: "img", data: data do
      partial icon
    end
  end

  def xml_feed_content(article)
    content = article.body

    content << if article.data.image_title
                 "<img src='#{data.site.url}#{article.data.image_title}' class='webfeedsFeaturedVisual' style='display: none;' />"
               else
                 "<img src='#{data.site.url}#{image_path('default-blog-image.png')}' class='webfeedsFeaturedVisual' style='display: none;' />"
               end

    h(content)
  end

  def markdown(text)
    # Scope parameter is necessary to make Markdown in YAML work properly
    # See: https://github.com/middleman/middleman/issues/653#issuecomment-9954111
    Tilt['markdown'].new { text }.render(scope: self)
  end

  def kramdown(text)
    Kramdown::Document.new(text).to_html
  end

  def team_size
    data.team.count { |entry| entry['type'] == 'person' }
  end

  def open_roles
    data.roles.select(&:open).sort_by(&:title)
  end

  def salary_avail
    data.roles.select(&:salary).sort_by(&:title)
  end

  def current_role_for_salary_calculator
    current_role = salary_avail.detect do |role|
      role.description.start_with?("/#{File.dirname(current_page.request_path)}")
    end

    if current_role&.levels&.is_a? String
      current_role.levels = data.role_levels.send(current_role.levels)
    end

    current_role
  end

  def find_role_by_description(description)
    data.roles.find { |role| role.description == description }
  end

  def color_code_grades(grade)
    color = "green"  if grade.include? 'A'
    color = "green"  if grade.include? 'B'
    color = "orange" if grade.include? 'C'
    color = "red"    if grade.include? 'D'
    color = "red"    if grade.include? 'F'

    "<span style='color:#{color};'>#{grade}</span>"
  end

  def color_code_health(level)
    case level
    when 3
      color = "green"
      text = "Okay"
    when 2
      color = "orange"
      text = "Attention"
    when 1
      color = "red"
      text = "Problem"
    else
      color = "gray"
      text = "Unknown"
    end

    "<span style='border-radius:0.2em; font-weight:bold; padding-left:1em; padding-right:1em; color:white; background-color:#{color};'>#{text}</span>"
  end

  def color_code_maturity(level)
    color = case level
            when 3
              "green"
            when 2
              "orange"
            when 1
              "red"
            else
              "gray"
            end

    "<span style='border-radius:0.2em; font-weight:bold; padding-left:1em; padding-right:1em; color:white; background-color:#{color};'>Level #{level} of 3</span>"
  end

  def performance_indicators(org)
    kpis = []
    rpis = []

    data.performance_indicators.select { |pi| pi.orgs.include? org }.each do |pi|
      if pi.is_key == true
        kpis.push(pi)
      else
        rpis.push(pi)
      end
    end

    partial('includes/performance_indicators.html.erb', locals: { key_performance_indicators: kpis, regular_performance_indicators: rpis })
  end

  def font_url(current_page)
    fonts = ["Source+Sans+Pro:200,300,400,500,600,700"]

    if current_page.data.extra_font
      fonts = fonts.concat current_page.data.extra_font
    end
    fonts = fonts.join("|")

    "//fonts.googleapis.com/css?family=#{fonts}"
  end

  def highlight_active_nav_link(link_text, url, options = {})
    options[:class] ||= ""
    options[:class] << " active" if url == current_page.url
    link_to(link_text, url, options)
  end

  def full_url(current_page)
    "#{data.site.url}#{current_page.url}"
  end

  def current_version
    ReleaseList.new.release_posts.first.version
  end

  def copy_btn_options(copy_text, tooltip_text = nil, button_class = nil)
    tooltip_text = 'Copy to clipboard' if tooltip_text.nil?
    button_class = 'copy-btn js-copy-btn' if button_class.nil?

    {
      class: "btn #{button_class}", type: 'button',
      title: tooltip_text, 'aria-label' => tooltip_text,
      data: {
        'clipboard-text' => copy_text,
        toggle: 'tooltip', placement: 'top'
      }
    }
  end

  def production?
    ENV['MIDDLEMAN_ENV'] == 'production'
  end

  def add_extra_css(*files)
    current_page.data.extra_css ||= []
    current_page.data.extra_css |= files
  end

  def add_extra_js(*files)
    current_page.data.extra_js ||= []
    current_page.data.extra_js |= files
  end
end
