class HomeController < ApplicationController
  def index
  	@categories = Category.sort_alpha
  end
end
