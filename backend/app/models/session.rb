class Session < ApplicationRecord

  belongs_to :user
  before_validation :generate_token, on: :create

  private

  def generate_token
    self.token = JsonWebToken.encode({jit: user.id})
  end

end
