# Configure will_paginate to use Bootstrap renderer by default
# This is cleaner than overriding the helper method
WillPaginate::ViewHelpers.pagination_options[:renderer] = WillPaginate::ActionView::BootstrapLinkRenderer

