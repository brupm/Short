class UrlShortner
  ALPHA_SEQUENCE = [('a'..'z'),('0'..'9')].map(&:to_a).flatten

  def initialize(container = 's.bopia.com')
    @container = container
  end

  def short_code
    code = random_string
    while $redis.get("#{@container}:#{code}") != nil
      code = random_string
    end
    code
  end

  def random_string(length = 5)
    (0..length).map{ ALPHA_SEQUENCE[rand(ALPHA_SEQUENCE.length)] }.join
  end
end
