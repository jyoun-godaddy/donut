require 'bundler/setup'
require 'pry'
require 'json'

class Donut
  def initialize(participants, history_file_path)
    @participants = participants
    @history_file_path = history_file_path
    @history = fetch_history
  end

  def call
    throw 'Odd number of participants' if @participants.length.odd?

    pairs = group_pairs

    pairs.each do |pair|
      p pair
    end
  end

  def group_pairs
    results = []
    while @participants.length > 2
      index_1, index_2 = random_indexes(@participants.length - 1)

      participants_to_pair = [@participants[index]]
      participant_1 = @participants.delete_at(index_1)
      participant_2 = @participants.delete_at(index_2)

      results << [participant_1, participant_2]
    end

    results << @participants
  end

  def random_indexes(length)
    index_1 = rand(length)
    index_2 = rand(length)

    while index_1 == index_2
      index_2 = rand(length)
    end

    [index_1, index_2]
  end

  def fetch_history
    if File.exist?(@history_file_path)
      file = File.read(@history_file_path)

      Set.new(JSON.parse(file))
    else
      Set.new()
    end
  end

  def store_history(histo)
end

participants = [
  'yutaro',
  'claire',
  'katie',
  'josh',
  'james',
  'aniza',
]

d = Donut.new(participants, './history.json')
d.call

