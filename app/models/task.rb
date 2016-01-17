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

  def self.univer_search(univer_search)
    if !univer_search.nil? && !univer_search.empty?
      where('univer = ?', "#{univer_search}")
    else
      where(nil)
    end
  end

  def self.variant_search(variant_search)
    # if variant_search
    if !variant_search.nil? && !variant_search.empty?

        where('variant LIKE ?', "%#{variant_search}%")
    else
      where(nil)
    end
  end

  def self.type_t_search(type_t_search)
    # if type_t_search
    if !type_t_search.nil? && !type_t_search.empty?
        where('type_t LIKE ?', "%#{type_t_search}%")
    else
      where(nil)
    end
  end

  def self.solved_search(solved_search)
    # if solved_search
    if !solved_search.nil? && !solved_search.empty?
      logger.info('solved_search'+solved_search)
      where('solved = ?', "#{solved_search}")
    else
      where(nil)
    end
  end

end
