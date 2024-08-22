module PlacesHelper
  def progress_bar_class(rating)
    case rating
    when 0..1.9
      'bg-danger'
    when 2..3.9
      'bg-warning'
    when 4..4.9
      'bg-primary'
    else
      'bg-success'
    end
  end

  def badge_class(rating)
    case rating
    when 0..1.9
      'text-bg-danger'
    when 2..3.9
      'text-bg-warning'
    when 4..4.9
      'text-bg-primary'
    else
      'text-bg-success'
    end
  end
end
