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
  # Rails 6.1 may pass extra arguments (collection, options, block, template_context)
  # but will_paginate only expects (collection, options)
  def will_paginate(collection = nil, options = nil, *extra_args, &block)
    # Handle case where first argument is actually options hash
    if collection.is_a?(Hash) && !collection.is_a?(ActiveRecord::Relation)
      options, collection = collection, nil
    end

    # Set Bootstrap renderer if not already set
    options = options.dup if options.is_a?(Hash)
    options ||= {}
    options[:renderer] ||= WillPaginate::ActionView::BootstrapLinkRenderer

    # Find the original will_paginate method from WillPaginate::ActionView::Helper
    # This needs to be done at runtime because in production eager loading may change module order
    helper_module = WillPaginate::ActionView::Helper
    original_method = helper_module.instance_method(:will_paginate)

    # Call the original method with only collection and options (not the extra Rails 6.1 args)
    if collection
      original_method.bind(self).call(collection, options)
    else
      original_method.bind(self).call(options)
    end
  end

end
