class CoursesController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @courses = pagy(Course.all)
  end

  def show
    @course = Course.find(params[:id])
  end

end
