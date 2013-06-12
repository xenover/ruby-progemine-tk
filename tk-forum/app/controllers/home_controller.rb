class HomeController < ApplicationController
  def index
  	@categories = Category.sort_prt
  end
end
