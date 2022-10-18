require 'colorize'

class Player
  attr_accessor :name
end

@board = Array.new(7) { Array.new(8, " ")}
$places = Array.new()

def display_board()

  system("clear")

  puts "| #{@board[6][1]} | #{@board[6][2]} | #{@board[6][3]} | #{@board[6][4]} | #{@board[6][5]} | #{@board[6][6]} | #{@board[6][7]} |"
  puts "| #{@board[5][1]} | #{@board[5][2]} | #{@board[5][3]} | #{@board[5][4]} | #{@board[5][5]} | #{@board[5][6]} | #{@board[5][7]} |"
  puts "| #{@board[4][1]} | #{@board[4][2]} | #{@board[4][3]} | #{@board[4][4]} | #{@board[4][5]} | #{@board[4][6]} | #{@board[4][7]} |"
  puts "| #{@board[3][1]} | #{@board[3][2]} | #{@board[3][3]} | #{@board[3][4]} | #{@board[3][5]} | #{@board[3][6]} | #{@board[3][7]} |"
  puts "| #{@board[2][1]} | #{@board[2][2]} | #{@board[2][3]} | #{@board[2][4]} | #{@board[2][5]} | #{@board[2][6]} | #{@board[2][7]} |"
  puts "| #{@board[1][1]} | #{@board[1][2]} | #{@board[1][3]} | #{@board[1][4]} | #{@board[1][5]} | #{@board[1][6]} | #{@board[1][7]} |"

end

def winner(arrayPos)

  a = Array.new()
  b = Array.new()

  for num in arrayPos
    a.push(num.keys[0])
    b.push(num.values[0])
  end

  oriz = 1
  vert = 1
  diag = 1
  if arrayPos.length >= 4
    if oriz < 4 and vert < 4 and diag < 4
      (0..arrayPos.length - 1).to_a.each do |i|
        oriz = 1
        vert = 1
        diag = 1
        (1..4).each do |j|
          if arrayPos.include? ({a[i] => b[i]+j})
            oriz += 1
            if oriz == 4
              return true
            end
          else
            oriz = 0
          end
        end
        (1..4).to_a.each do |j|
          if arrayPos.include? ({a[i]+j => b[i]})
            vert += 1
            if vert == 4
              return true
            end
          else
            vert = 0
          end
        end
        (1..4).to_a.each do |j|
          if arrayPos.include? ({a[i]+j => b[i]+j})
            diag += 1
            if diag == 4
              return true
            end
          else
            diag = 0
          end
        end
        diag = 1
        (1..4).to_a.each do |j|
          if arrayPos.include? ({a[i]-j => b[i]+j})
            diag += 1
            if diag == 4
              return true
            end
          else
            diag = 0
          end
        end
      end
    end
  end
end



def check_position(y)
  isInvalid = true
  while isInvalid
    isInvalid = false
    if y  == 0 or y > 7
      puts "Invalid number, choose between 1 and 7: "
      y = gets.to_i
      isInvalid = true
    else
      (1..6).to_a.each do |x|
        if $places.index ({x => y})
          if x == 6
            puts "column full, choose another one: "
            y = gets.to_i
            isInvalid = true
          end
        else
            $places.push({x => y})
            break
        end
      end
    end
  end
end




def start
  player1 = Player.new()
  player2 = Player.new()


  plOneList = Array.new()
  plTwoList = Array.new()

  puts "Enter player1 name: "
  player1.name = gets
  puts "Enter player2 name: "
  player2.name = gets

  display_board

  isEnded = false

  while isEnded == false
    if $places.length < 41
      puts "\nIt's your turn, " + player1.name.chomp.red + "! Insert the column number: "

      validator = true

      while validator
        begin
          positionP1 = gets.to_i
          validator = false
        rescue
          puts "Insert only a number between 1 and 7:  "
          position = gets.to_i
        end
      end

      check_position(positionP1)
      plOneList.push($places[-1])

      @board[$places[-1].keys[0]][$places[-1].values[0]] = "X".red

      # It's not necessary to sort plOneList and plTwoList, but I guess it makes the "winner" function a bit more efficient.

      sort1 = plOneList.sort {|a, b| a.first <=> b.first}

      display_board
      if winner(sort1) == true
        puts "\n" + player1.name.chomp.red + " WINS!\n"
        isEnded = true
        break
      end

      puts "\nIt's your turn, " + player2.name.chomp.blue + "! Insert the column number: "
      while validator == false
        begin
          positionP2 = gets.to_i
          validator = true
        rescue
          puts "Insert only a number between 1 and 7:  "
          position = gets.to_i
        end
      end

      check_position(positionP2)
      plTwoList.push($places[-1])
      @board[$places[-1].keys[0]][$places[-1].values[0]] = "O".blue
      display_board
      sort2 = plTwoList.sort {|a, b| a.first <=> b.first}

      if winner(sort2) == true
        isEnded = true
        puts "\n" + player2.name.chomp.blue + " WINS!\n"
      end
    else
      puts "Tie!".yellow
      isEnded = true
    end

  end

end

start
