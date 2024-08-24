class PagesController < ApplicationController
  def index
    @places = Place.all
  end

  def about
  end

  def services
  end

  def pricing
  end

  def roadmap
  end

  def contact
  end

  def blog
  end
end
