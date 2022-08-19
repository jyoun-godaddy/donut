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
    # TODO: use a round robin algorithm.
    # also think about how to manage late joiners and early quiters
    # https://en.wikipedia.org/wiki/Round-robin_tournament#Scheduling_algorithm

    ################
    # LATE JOINERS #
    ################
    # "15" & "16" are late joiners
    # append late joiners to the end before the rotation
    #
    # 1	  2	  3	  4	  5	  6	7 15
    # 14	13	12	11	10	9	8 16

    #################
    # EARLY QUITERS #
    #################
    # starting lineup
    #
    # 1	  2	  3	  4	  5	  6	7
    # 14	13	12	11	10	9	8

    # quiters from same row
      # 3 & 6 quit early
      #
      # 1	  2	  x	  4	  5	  x	7
      # 14	13	12	11	10	9	8

      # compress to the right?
      # 13 14 1	 2	4	5
      # 12 11	10 9	8 7

      # compress to the left?
      # 1	  2	  4   5	 	7  8
      # 14	13	12	11	10 9
        #
        # no - previously matched pairs will be matched again


    # quiters from separate rows
      # 3 and 9 quits early
      #
      # 1	  2	  x	  4	  5	  6	7
      # 14	13	12	11	10	x	8

      # compress when two participants quit?
      #  yes. example: 4 & 12 have never matched - essentially creating a unique pairing
      #
      # 1	  2	  4	  5	  6	  7
      # 14	13	12	11	10	8




    #########
    # DRAFT #
    #########
    # 7 quits early
    #
    # 1	  2	  3	  4	  5	  6	7
    # 14	13	12	11	10	9	8

    # 8 quits early
    #
    # 1	  2	  3	  4	  5	  6	7
    # 14	13	12	11	10	9	8

    # 7 quits early
    #
    # 1	  2	  3	  4	  5	  6	7
    # 14	13	12	11	10	9	8

    # 1 quits early
    #
    # 1	  2	  3	  4	  5	  6	7
    # 14	13	12	11	10	9	8

    # 14 quits early
    #
    # 1	  2	  3	  4	  5	  6	7
    # 14	13	12	11	10	9	8

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

