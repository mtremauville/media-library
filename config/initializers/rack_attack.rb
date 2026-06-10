class Rack::Attack
  # Bloque les IPs qui font trop de requêtes
  throttle("req/ip", limit: 300, period: 5.minutes) do |req|
    req.ip
  end

  # Protège les logins
  throttle("logins/ip", limit: 5, period: 20.seconds) do |req|
    req.ip if req.path == "/users/sign_in" && req.post?
  end

  # Bloque les IPs malveillantes
  blocklist("block bad IPs") do |req|
    BlockedIp.exists?(ip: req.ip) rescue false
  end
end
