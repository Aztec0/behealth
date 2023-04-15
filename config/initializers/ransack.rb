# frozen_string_literal: true

Ransack.configure do |c|
  c.search_key = :query
  c.strip_whitespace = false
end
