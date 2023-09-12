require_relative '../models/game_board'
require_relative '../models/ship'
require_relative '../models/position'

# return a populated GameBoard or nil
# Return nil on any error (validation error or file opening error)
# If 5 valid ships added, return GameBoard; return nil otherwise
def read_ships_file(path)
    output = GameBoard.new 10, 10
    direction = ""
    start_pos_row = 0
    start_pos_col = 0
    ship_size = 0
    ships_added = 0
    
    read_file_lines(path) do |line|
        if line =~ /^\(\d+,\d+\), (Right|Left|Up|Down), [0-9]{1,5}$/ then
            if line =~ /(\d+).(\d+).+(\d+)/ then
                start_pos_row = $1
                start_pos_col = $2
                ship_size = $3
            end

            if line =~ /(Right|Left|Down|Up)/ then
                direction = $1
            end

            int_pos_row = start_pos_row.to_i
            int_pos_col = start_pos_col.to_i
            int_size = ship_size.to_i


            if int_pos_row > 0 && int_pos_row <= 10 && int_pos_col > 0 && int_pos_col <= 10 then
                ship_position = Position.new(int_pos_row, int_pos_col)
                input = Ship.new(ship_position, direction, int_size)
                if output.add_ship(input) == true then
                    ships_added += 1
                end
            end

        end

        if ships_added == 5 then
            return output
        end




    end

    if ships_added != 5 then
        return nil
    end



    # if ships_added == 5 then
    #     return output
    # else
    #     return nil
    # end







    
end


# return Array of Position or nil
# Returns nil on file open error
def read_attacks_file(path)
    if !File.file?(path) then
        return nil
    end
    output = []
    row_coordinate = 0
    col_coordinate = 0
    read_file_lines(path) do |line|
        if line =~ /^\(\d+,\d+\)/ then
            if line =~ /(\d+),(\d+)/ then
                row_coordinate = $1.to_i
                col_coordinate = $2.to_i
                output.append(Position.new(row_coordinate, col_coordinate))
            end

        end

    end
    
    output


end


# ===========================================
# =====DON'T modify the following code=======
# ===========================================
# Use this code for reading files
# Pass a code block that would accept a file line
# and does something with it
# Returns True on successfully opening the file
# Returns False if file doesn't exist
def read_file_lines(path)
    return false unless File.exist? path
    if block_given?
        File.open(path).each do |line|
            yield line
        end
    end

    true
end
