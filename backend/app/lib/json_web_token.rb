class JsonWebToken
  JWT_SECRET = Rails.application.secret_key_base

  def self.encode(payload, expiry = 12.hours.from_now)
    payload[:expiry] = expiry.to_i
    
    JWT.encode(payload, JWT_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, JWT_SECRET).first

    ashWithIndifferentAccess.new(body)
  end
end
