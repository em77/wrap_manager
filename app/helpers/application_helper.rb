module ApplicationHelper
  def flash_class(flash_type)
    case flash_type
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
    end
  end

  # Override will_paginate to use Bootstrap renderer and handle Rails 6.1 signature changes
  # Rails 6.1 may pass 4 arguments (collection, options, block, template_context) but
  # will_paginate only expects 2 (collection, options)
  def will_paginate(collection = nil, options = {}, *extra_args, &block)
    # Handle case where first argument is actually options hash
    if collection.is_a?(Hash) && !collection.is_a?(ActiveRecord::Relation)
      options, collection = collection, nil
    end

    # Set Bootstrap renderer if not already set
    options = options.dup if options
    options ||= {}
    options[:renderer] ||= WillPaginate::ActionView::BootstrapLinkRenderer

    # Call parent with only collection and options (will_paginate only accepts 2 args)
    # Rails 6.1 may pass extra args, but we ignore them
    if collection
      super(collection, options)
    else
      super(options)
    end
  end

end
