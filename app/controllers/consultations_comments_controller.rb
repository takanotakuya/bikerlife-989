class ConsultationsCommentsController < ApplicationController
  def create
    consultations_comment = ConsultationsComment.create(consultations_comment_params)
    redirect_to "/consultations/#{consultations_comment.consultation.id}"
  end

  private
  def consultations_comment_params
    params.require(:consultations_comment).permit(:comment_text).merge(user_id: current_user.id, consultation_id: params[:consultation_id])
  end
end
