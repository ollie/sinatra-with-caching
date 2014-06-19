# Just a bunch of random text.
class Data
  WORDS = %w(Lorem Ipsum Dolor Sit Amet Consectetur Adipisicing Elit Molestias
             Molestiae Veniam Earum Velit Vitae Eos Repellat Exercitationem Esse
             Quam Nihil Inventore Illo Totam Harum Nisi Consectetur Optio Vero
             Soluta Ea)

  def self.list
    list = []

    50.times do
      list << {
        id:    number,
        title: words,
        text:  words(50)
      }
    end

    wait_a_bit
    list
  end

  def self.number
    rand(200)
  end

  def self.words(count = 5)
    (1..count).map { WORDS.sample }.join(' ')
  end

  def self.wait_a_bit
    sleep 0.3
  end
end
