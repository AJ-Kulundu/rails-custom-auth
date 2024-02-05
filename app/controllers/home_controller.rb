class HomeController < ApplicationController
  skip_before_action :authenticated!
  def index
  end
end
