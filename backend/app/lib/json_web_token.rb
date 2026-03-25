class JsonWebToken
  JWT_SECRET = Rails.application.secret_key_base

  def self.encode(payload, exp = 12.hours.from_now)
    payload[:exp] = exp.to_i

    JWT.encode(payload, JWT_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, JWT_SECRET).first

    HashWithIndifferentAccess.new(body)
  end
end
