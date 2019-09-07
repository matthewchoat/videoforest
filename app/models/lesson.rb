class Lesson < ApplicationRecord
  belongs_to :section
  mount_uploader :video, VideoUploader

  include RankedModel
  ranks :row_order, with_same: :section_id

  def next_lesson
    lesson = section.lessons.where("row_order > ?", self.row_order).rank(:row_order).first
    if lesson.blank? && section.next_section
      return section.next_section.lessons.rank(:row_order).first
    end
    return lesson
  end

    def destroy
    @lesson = Lesson.find(params[:id])
    if @lesson.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end

    @lesson.destroy
    redirect_to root_path
  end

end
