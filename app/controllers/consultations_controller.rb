class ConsultationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @consultations = Consultation.includes(:user).order("created_at DESC")
  end

  def new
    @consultation = Consultation.new
  end

  def create
    @consultation = Consultation.new(consultation_params)
    if @consultation.save
      redirect_to consultations_path
    else
      render :new
    end
  end

  def show
    @consultation = Consultation.find(params[:id])
    @consultations_comment = ConsultationsComment.new
    @consultations_comments = @consultation.consultations_comments.includes(:user).order("created_at DESC")
  end

  def edit
    @consultation = Consultation.find(params[:id])
    redirect_to consultations_path if @consultation.user != current_user
  end

  def update
    @consultation = Consultation.find(params[:id])
    redirect_to consultations_path if @consultation.user != current_user
    if @consultation.update(consultation_params)
      redirect_to consultation_path(@consultation.id)
    else
      render :editf
    end
  end

  def destroy
    @consultation = Consultation.find(params[:id])
    redirect_to consultations_path if @consultation.user != current_user
    @consultation.destroy
    redirect_to consultations_path
  end

  private

  def consultation_params
    params.require(:consultation).permit(:name, :post_text).merge(user_id: current_user.id)
  end
end
