class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :user_id, dependent: :destroy
  has_many :comments, foreign_key: :user_id, dependent: :destroy
  has_many :consultations, foreign_key: :user_id, dependent: :destroy
  has_many :consultations_comments, foreign_key: :user_id, dependent: :destroy
  has_many :likes

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  validates_format_of :password, {with: PASSWORD_REGEX, message: 'には英字（半角）と数字（半角）の両方を含めて設定してください', on: :create}
  
  with_options presence: true do
    validates :nickname
  end 

  # def update_without_current_password(params, *options)
  #   params.delete(:current_password)

  #   if params[:password].blank? && params[:password_confirmation].blank?
  #     params.delete(:password)
  #     params.delete(:password_confirmation)
  #   else
  #     result = update_attributes(params, *options)
  #
  #     clean_up_passwords
  #     result
  #   end
  # end
end

# validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字（半角）と数字（半角）の両方を含めて設定してください'