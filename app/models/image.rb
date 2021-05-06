class Image < ApplicationRecord
  validates :url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :tag_list, presence: true
  acts_as_taggable_on :tags
end
