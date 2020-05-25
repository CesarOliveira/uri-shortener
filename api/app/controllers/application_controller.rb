class ApplicationController < ActionController::API

  def generate_unique_token(identifier)
    identifier_md5 = Digest::MD5.hexdigest identifier
    time = Time.now.to_f
    secure_random_hash = SecureRandom.hex(rand(7..42))
    (Digest::MD5.hexdigest "#{secure_random_hash}-#{time}-#{identifier_md5}")
  end
end
