module ApplicationHelper
    def link_to_active(name, options, html_options = {})
    uri = URI.parse(url_for(options))
    base_path = uri.path
    main_params = { status_category_type: params[:status_category_type] }

    if current_page?(path: base_path, **main_params)
      html_options[:class] = Array(html_options[:class])
      html_options[:class] << 'active'
    end

    link_to name, options, html_options
  end
end
