module WillPaginateBootstrapOverride
  # Override will_paginate to handle Rails 6.1 argument mismatch
  # Rails 6.1 passes 4 arguments (collection, options, block, template_context)
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

    # Call the original method from WillPaginate::ViewHelpers with only collection and options
    # Use method to get the original implementation
    original = WillPaginate::ViewHelpers.instance_method(:will_paginate)
    
    if collection
      original.bind(self).call(collection, options)
    else
      original.bind(self).call(options)
    end
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
