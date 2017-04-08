module ReviewsHelper
  def star_rating(rating)
    return 'No Ratings, Be the first to rate' unless rating.respond_to?(:round)
    remainder = 5 - rating.round
    "★" * rating.round + "☆" * remainder
  end
end
