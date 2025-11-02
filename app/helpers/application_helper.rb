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
  # Rails 6.1 may pass 4 arguments instead of 3, so we use *args to handle it flexibly
  def will_paginate(*args)
    # Parse arguments - Rails 6.1 may pass: collection, options, and additional args
    if args.empty?
      # No arguments - just pass through
      return super
    end

    # Find the options hash (usually the 2nd argument, but might be first)
    options_index = args.find_index { |arg| arg.is_a?(Hash) }
    options = options_index ? args[options_index].dup : {}

    # Set Bootstrap renderer if not already set
    options[:renderer] ||= WillPaginate::ActionView::BootstrapLinkRenderer

    # Reconstruct arguments with modified options
    new_args = args.dup
    if options_index
      new_args[options_index] = options
    else
      # No options hash found, add it after collection
      new_args << options
    end

    # Call parent with all arguments (Rails 6.1 expects the full signature)
    super(*new_args)
  end

end
