class ConsultationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_q, only: [:index, :search]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :redirect, only: [:edit, :destroy]

  def index
    @consultations = Consultation.includes(:user).page(params[:page]).per(9).order("created_at DESC")
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
    @consultations_comment = ConsultationsComment.new
    @consultations_comments = @consultation.consultations_comments.includes(:user).order("created_at DESC")
  end

  def edit
  end

  def update
    return redirect_to consultations_path if @consultation.user != current_user
    if @consultation.update(consultation_params)
      redirect_to consultation_path(@consultation.id)
    else
      render :edit
    end
  end

  def destroy
    @consultation.destroy
    redirect_to consultations_path
  end

  def search
    @results = @q.result
  end

  private

  def consultation_params
    params.require(:consultation).permit(:name, :post_text).merge(user_id: current_user.id)
  end

  def set_q
    @q = Consultation.ransack(params[:q])
  end

  def set_item
    @consultation = Consultation.find(params[:id])
  end

  def redirect
    redirect_to consultations_path if @consultation.user != current_user
  end
end
