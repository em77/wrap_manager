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
    return '' unless collection
    
    # Use WillPaginate's internal rendering directly
    renderer_class = options[:renderer] || WillPaginate::ActionView::BootstrapLinkRenderer
    renderer = renderer_class.new(collection, self, options)
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
