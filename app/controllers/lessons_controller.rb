class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrolled_in_current_course

  def require_enrolled_in_current_course
    if current_user.enrolled_in?(current_lesson.section.course) != true
      redirect_to course_url, alert: 'You must enroll for this course.'
    end
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end  
end
