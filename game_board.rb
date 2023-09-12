require_relative "../../src/models/position.rb"
require_relative "../../src/models/ship.rb"
class GameBoard
    # @max_row is an `Integer`
    # @max_column is an `Integer`
    attr_reader :max_row, :max_column

    def initialize(max_row, max_column)
        @max_row = max_row
        @max_column = max_column
        @board = Array.new(max_row){Array.new(max_column)}
        @successful_attacks = 0
    end

    # adds a Ship object to the GameBoard
    # returns Boolean
    # Returns true on successfully added the ship, false otherwise
    # Note that Position pair starts from 1 to max_row/max_column
    def add_ship(ship)
        @coordinate_row = ship.start_position.row - 1
        @coordinate_col = ship.start_position.column - 1
        i = ship.size

        if @coordinate_row > @max_row - 1|| @coordinate_col > @max_column - 1|| @coordinate_row < 0 ||
            @coordinate_col < 0 then
                return false
        end


        if check_space(ship) == false then
            return false
        end

        if ship.orientation == "Right" then
            column_count = @coordinate_col
            while i > 0 do
                @board[@coordinate_row][column_count] = "B"
                column_count += 1
                i -= 1
            end
        elsif ship.orientation == "Left" then
            column_count = @coordinate_col
            while i > 0 do
                @board[@coordinate_row][column_count] = "B"
                column_count -= 1
                i -= 1
            end
        elsif ship.orientation == "Up" then
            row_count = @coordinate_row
            while i > 0 do
                @board[row_count][@coordinate_col] = "B"
                row_count -= 1
                i -= 1
            end
        elsif ship.orientation == "Down" then
            row_count = @coordinate_row
            while i > 0 do
                @board[row_count][@coordinate_col] = "B"
                row_count += 1
                i -= 1
            end
        end


        true
 
    end

    # return Boolean on whether attack was successful or not (hit a ship?)
    # return nil if Position is invalid (out of the boundary defined)
    def attack_pos(position)
        position_row = position.row
        position_col = position.column

        if position_row > @max_row || position_row < 1 then
            return nil
        end
        if position_col > @max_column || position_col < 1 then
            return nil
        end

        if @board[position_row - 1][position_col - 1] == "B" then
            @board[position_row - 1][position_col - 1] = "B, A"
            @successful_attacks += 1
            return true
        elsif @board[position_row - 1][position_col - 1] == "B, A" then
            return true
        end
        # check position

        # update your grid

        # return whether the attack was successful or not
        false
    end

    # Number of successful attacks made by the "opponent" on this player GameBoard
    def num_successful_attacks
        return @successful_attacks
    end

    # returns Boolean
    # returns True if all the ships are sunk.
    # Return false if at least one ship hasn't sunk.
    def all_sunk?
        @board.each do |value|
            value.each do |content|
                if content == "B" then
                    return false
                end
            end
        end
        true
    end

    def check_space(ship)
        @column = ship.start_position.column - 1
        @row = ship.start_position.row - 1
        i = ship.size

        if ship.orientation == "Right" then
            column_count = @column
            while i > 0 do
                if column_count > max_column - 1 || column_count < 0 then
                    return false
                end
                if @board[@row][column_count] != nil then
                    return false
                end
                column_count += 1
                i -= 1
            end
        elsif ship.orientation == "Left" then
            column_count = @column
            while i > 0 do
                if column_count > @max_column - 1 || column_count < 0 then
                    return false
                end
                if @board[@row][column_count] != nil then
                    return false
                end
                column_count -= 1
                i -= 1
            end
        elsif ship.orientation == "Up" then
            row_count = @row
            while i > 0 do
                if row_count > @max_row - 1 || row_count < 0 then
                    return false
                end
                if @board[row_count][@column] != nil then
                    return false
                end
                row_count -= 1
                i -= 1
            end
        elsif ship.orientation == "Down" then
            row_count = @row
            while i > 0 do
                if row_count > @max_row - 1 || row_count < 0 then
                    return false
                end
                if @board[row_count][@column] != nil then
                    return false
                end
                row_count += 1
                i -= 1
            end
        end 
        

        
        true
    end


    # String representation of GameBoard (optional but recommended)
    def to_s
        @board.each do |value|
            print value
            print "\n"
        end
    end
end

# game1 = GameBoard.new(5, 5)
# ship1 = Ship.new(Position.new(4,5), "Down", 5)
# ship2 = Ship.new(Position.new(1,4), "Left", 2)
# ship3 = Ship.new(Position.new(5,2), "Left", 2)
# game1.add_ship(ship1)
# game1.add_ship(ship2)
# game1.add_ship(ship3)
# target = Position.new(1,3)
# target1 = Position.new(1,4)
# target2 = Position.new(1,3)
# game1.attack_pos(target)
# game1.attack_pos(target1)
# game1.attack_pos(target2)
# game1.to_s
# print game1.all_sunk?
# print game1.num_successful_attacks