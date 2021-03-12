class ConsultationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, except: [:index, :show, :search]

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

  def search
    @consultations = Consultation.search(params[:keyword])
  end

  private

  def consultation_params
    params.require(:consultation).permit(:name, :post_text).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
