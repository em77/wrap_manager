module WillPaginateBootstrapOverride
  # HACK: Override will_paginate to handle Rails 6.1 argument mismatch
  # Rails 6.1 passes 4 arguments but will_paginate only expects 2
  # We'll completely bypass the original method and implement it ourselves
  def will_paginate(collection = nil, options = nil, *extra_args, &block)
    # Ignore all the extra Rails 6.1 args
    # Handle case where first argument is actually options hash
    if collection.is_a?(Hash) && !collection.is_a?(ActiveRecord::Relation)
      options, collection = collection, nil
    end

    # Set Bootstrap renderer
    options = options.dup if options.is_a?(Hash)
    options ||= {}
    options[:renderer] ||= WillPaginate::ActionView::BootstrapLinkRenderer

    # Completely bypass the original method and render manually
    # This is hacky but it avoids all the argument mismatch issues
    # Based on will_paginate source code in view_helpers.rb
    return nil unless collection && collection.respond_to?(:total_pages) && collection.total_pages > 1
    
    # Merge with global pagination options
    options = WillPaginate::ViewHelpers.pagination_options.merge(options)
    
    # Set default labels if not present
    options[:previous_label] ||= I18n.t('will_paginate.previous_label', default: '&#8592; Previous')
    options[:next_label] ||= I18n.t('will_paginate.next_label', default: 'Next &#8594;')
    
    # Get renderer instance (same logic as original)
    renderer = case options[:renderer]
    when nil
      WillPaginate::ActionView::BootstrapLinkRenderer.new
    when String
      options[:renderer].constantize.new
    when Class then options[:renderer].new
    else options[:renderer]
    end
    
    # Prepare and render (same as original)
    renderer.prepare(collection, options, self)
    renderer.to_html.html_safe
  end
end

module ApplicationHelper
  prepend WillPaginateBootstrapOverride
  
  def flash_class(flash_type)
    case flash_type
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
    end
  end

end
