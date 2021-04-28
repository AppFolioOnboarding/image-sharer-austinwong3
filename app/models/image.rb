class Image < ApplicationRecord
  validates :url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
end
