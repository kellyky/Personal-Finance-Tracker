class Session < ApplicationRecord
  belongs_to :user
  before_create :generate_token

  private

  # TODO look into Digest class, SecureRandom, JWT
  def generate_token
    # Placeholder
    # TODO: Replace with a different way to generate the token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

end
