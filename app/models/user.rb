class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :user_id, dependent: :destroy
  has_many :comments, foreign_key: :user_id, dependent: :destroy
  has_many :consultations, foreign_key: :user_id, dependent: :destroy
  has_many :consultations_comments, foreign_key: :user_id, dependent: :destroy

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  with_options presence: true do
    validates :nickname
  end  

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    else
      result = update_attributes(params, *options)
      validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字（半角）と数字（半角）の両方を含めて設定してください'
      clean_up_passwords
      result
      # @user = User.find(params[:id])
      # if @user.save
      #   redirect_to root_path
      # else
      #   render :edit
      # end
    end
  end
end

# validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字（半角）と数字（半角）の両方を含めて設定してください'