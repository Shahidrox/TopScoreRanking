class Score < ApplicationRecord
  validates :player, :presence => true
  validates :time, :presence => true

  validates_each :score do |record, attr, value|
    if value.blank?
      record.errors.add(attr, "can't be blank")
    elsif !value.positive?
      record.errors.add(attr, 'must be a number greater then zero')
    end
  end
  
  # Get max score of user
  scope :max_score, -> { select('time, score').order("score DESC").limit(1) }
  scope :min_score, -> { select('time, score').order("score ASC").limit(1) }

  def self.search(params)
    player, before, after, from_date, to_date  = params[:player], params[:before], params[:after], params[:from_date], params[:to_date]
    # Set query for all record
    score = self

    # Filter by name
    if player.present?
      name = player.downcase.split(',')
      score = score.where("lower(player) IN (?)", name.collect(&:strip))
    end

    # Filter by before and after
    if before.present? && after.present?
      score = score.where("date(time) > ? AND date(time) < ?", after.to_date, before.to_date)
    elsif before.present?
      score = score.where("date(time) < ?", before.to_date)
    elsif after.present?
      score = score.where("date(time) > ?", after.to_date)
    end
    
    score = score.present? ? score.order('time DESC') : score
    return score
  end

end
