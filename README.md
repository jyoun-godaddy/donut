# pairing algo
https://en.wikipedia.org/wiki/Round-robin_tournament#Scheduling_algorithm

```
# TODO
create state
  creating, adding, removing participants
  storing and retrieving state
    - current position of round robin
    - matched history

add functionality
  balance participants
    add placeholder if odd count
    compress when 2+ placeholders
  rotate


##########
# ROTATE #
##########
# Starting positions
#
# 1	  2	  3	  4	  5	  6	7
# 14	13	12	11	10	9	8

# Rotated position
#
# 14 1	2	  3	 4 5 6
#	13 12	11	10 9 8 7

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
  # 13  14  1	  2	4	 5
  # 12  11	10  9	8  7

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

##########
# DESIGN #
##########
2 rows
balance rows
  add placeholder for odd number of participants
find participant
remove participant(s)
add participant(s)
compress
  when 2 or more placeholders (null) are in rows
rotate
  ```
  top_row = [1,2,3]
  bottom_row = [4,5,6]

  top_mover = top_row.pop
  bottom_mover = bottom_row.shift

  top_row.unshift(bottom_mover)
  bottom_row.push(top_mover)

  # new rows:
  [4,1,2]
  [5,6,3]
  ```
store previous matches

```
