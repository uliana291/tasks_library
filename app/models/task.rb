class Task < ActiveRecord::Base

  default_scope -> { order('number ASC') }
  validates :variant, presence: true, numericality: {:greater_than => 0}
  validates :number, presence: true, numericality: {:greater_than => 0}
  validates :univer, presence: true
  validates :solved, exclusion: { in: [nil] }

  has_attached_file :photo,
                    :url  => "/assets/tasks/:id/:basename.:extension",
                    :path => ":rails_root/public/assets/tasks/:id/:basename.:extension"
  validates_attachment_size :photo, :less_than => 6.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
end
