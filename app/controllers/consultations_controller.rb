class ConsultationsController < ApplicationController

  def index
    @consultations = Consultation.includes(:user).order("created_at DESC")
  end

  def new
    @consultation = Consultation.new
  end

end
