class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # user와 identity가 nil이 아니라면 받는다
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user

    # user가 nil이라면 새로 만든다.
    if user.nil?

      # 이미 있는 이메일인지 확인한다.
      email = auth.info.email
      user = User.where(:email => email).first

      unless self.where(email: auth.info.email).exists?
        # 없다면 새로운 데이터를 생성한다.
        if user.nil?
          # 트위터는 email을 제공하지 않음
          if auth.provider == "twitter"
            user = User.new(
              remote_profile_img_url: auth.info.image.gsub('http://','https://'),
              password: Devise.friendly_token[0,20]
            )

          else
            user = User.new(
              email: auth.info.email,
              remote_profile_img_url: auth.info.image.gsub('http://','https://'),
              password: Devise.friendly_token[0,20]
            )
          end
          user.save!
        end
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user

  end

  # email이 없어도 가입이 되도록 설정
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
