module PE #(parameter WIDTH = 8, MY_ROW=0, MY_COL=0, TOTAL_ROW_COUNT = 4, TOTAL_COL_COUNT = 4, TOTAL_COL=8, TOTAL_ROW = 8)
    (clk, rst, state, pre_val, l_in_val, r_in_val, t_in_val, b_in_val, l_out_val, r_out_val, t_out_val, b_out_val);

    input clk;
    input rst;
    input [3:0] state;
    input [WIDTH-1:0] l_in_val;
    input [WIDTH-1:0] r_in_val;
    input [WIDTH-1:0] t_in_val;
    input [WIDTH-1:0] b_in_val;
    input [WIDTH-1:0] pre_val;

    output [WIDTH-1:0] l_out_val;
    output [WIDTH-1:0] r_out_val;
    output [WIDTH-1:0] t_out_val;
    output [WIDTH-1:0] b_out_val;

    reg [WIDTH-1:0] current_val;
    reg [WIDTH-1:0] counter;
    wire [WIDTH-1:0] my_row = MY_ROW;
    wire [WIDTH-1:0] my_col = MY_COL;

    reg [WIDTH-1:0] tmp_current_val;
    reg [WIDTH-1:0] shuffle_val;

    assign l_out_val = current_val;
    assign r_out_val = current_val;
    assign b_out_val = current_val;
    assign t_out_val = current_val;

    reg state_two_done = 0 ;

    always@(posedge clk)begin
        if(rst == 1) begin
            counter <= 0 ;
            current_val <= pre_val; 
            state_two_done <= 0;
        end 
        
        else if (state == 0) begin // odd transpose in first step
            if(my_row[0] == 0) begin // even row
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val < l_in_val ) && (my_col!=0) && (my_col!= (TOTAL_COL_COUNT/2))) begin
                        current_val <= l_in_val;
                    end
                end else begin
                    if((current_val > r_in_val) && (my_col!=(TOTAL_COL_COUNT/2 - 1)) &&(my_col!=(TOTAL_COL_COUNT-1))) begin
                        current_val <= r_in_val;
                    end
                end
            end else begin          // odd row
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val > l_in_val) && (my_col!=0) && (my_col!= (TOTAL_COL_COUNT/2))) begin
                        current_val <= l_in_val;
                    end
                end else begin
                    if((current_val < r_in_val) && (my_col!=(TOTAL_COL_COUNT/2 - 1)) &&(my_col!=(TOTAL_COL_COUNT-1))) begin
                        current_val <= r_in_val;
                    end
                end

            end
            tmp_current_val <= current_val;
        end 
         
        else if (state == 1) begin // even transpose in first step
            if(my_row[0] == 0) begin // even row
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val > r_in_val) ) begin
                        current_val <= r_in_val;
                    end
                end else begin
                    if((current_val < l_in_val) ) begin
                        current_val <= l_in_val;
                    end
                end
            end else begin
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val < r_in_val) ) begin
                        current_val <= r_in_val;
                    end
                end else begin
                    if((current_val > l_in_val) ) begin
                        current_val <= l_in_val;
                    end
                end

            end
            tmp_current_val <= current_val;
        end 
		
        else if (state == 2) begin // odd transpose in first step
            if(my_row[0] == 0) begin // even row
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val < l_in_val ) && (my_col!=0) && (my_col!= (TOTAL_COL_COUNT))) begin
                        current_val <= l_in_val;
                    end
                end else begin
                    if((current_val > r_in_val) && (my_col!=(TOTAL_COL_COUNT - 1)) &&(my_col!=(TOTAL_COL_COUNT-1))) begin
                        current_val <= r_in_val;
                    end
                end
            end else begin          // odd row
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val > l_in_val) && (my_col!=0) && (my_col!= (TOTAL_COL_COUNT))) begin
                        current_val <= l_in_val;
                    end
                end else begin
                    if((current_val < r_in_val) && (my_col!=(TOTAL_COL_COUNT - 1)) &&(my_col!=(TOTAL_COL_COUNT-1))) begin
                        current_val <= r_in_val;
                    end
                end

            end
            tmp_current_val <= current_val;
        end 
         
        else if (state == 3) begin // even transpose in first step
            if(my_row[0] == 0) begin // even row
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val > r_in_val) ) begin
                        current_val <= r_in_val;
                    end
                end else begin
                    if((current_val < l_in_val) ) begin
                        current_val <= l_in_val;
                    end
                end
            end else begin
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val < r_in_val) ) begin
                        current_val <= r_in_val;
                    end
                end else begin
                    if((current_val > l_in_val) ) begin
                        current_val <= l_in_val;
                    end
                end

            end
            tmp_current_val <= current_val;
        end 
		
		else if (state == 4) begin // odd transpose in first step
            //if(my_col[0] == 0) begin // even row
                if(my_row[0] == 0 ) begin  // even col
                    if((current_val < t_in_val ) && (my_row!=0) && (my_row!= (TOTAL_ROW_COUNT))) begin
                        current_val <= t_in_val;
                    end
                end else begin
                    if((current_val > b_in_val) && (my_row!=(TOTAL_ROW_COUNT - 1)) &&(my_row!=(TOTAL_ROW_COUNT-1))) begin
                        current_val <= b_in_val;
                    end
                end
            /*end else begin          // odd row
                if(my_row[0] == 0 ) begin  // even col
                    if((current_val > t_in_val) && (my_row!=0) && (my_row!= (TOTAL_ROW_COUNT))) begin
                        current_val <= t_in_val;
                    end
                end else begin
                    if((current_val < b_in_val) && (my_row!=(TOTAL_ROW_COUNT - 1)) &&(my_row!=(TOTAL_ROW_COUNT-1))) begin
                        current_val <= b_in_val;
                    end
                end

            end*/
            tmp_current_val <= current_val;
        end 
         
        else if (state == 5) begin // even transpose in first step
            //if(my_col[0] == 0) begin // even row
                if(my_row[0] == 0 ) begin  // even col
                    if((current_val > b_in_val) ) begin
                        current_val <= b_in_val;
                    end
                end else begin
                    if((current_val < t_in_val) ) begin
                        current_val <= t_in_val;
                    end
                end
            /*end else begin
                if(my_row[0] == 0 ) begin  // even col
                    if((current_val < b_in_val) ) begin
                        current_val <= b_in_val;
                    end
                end else begin
                    if((current_val > t_in_val) ) begin
                        current_val <= t_in_val;
                    end
                end

            end*/
            tmp_current_val <= current_val;
        end 

/*
        else if ((state == 2) && (state_two_done == 0)) begin // shift left to right
            current_val<= l_in_val;
            counter <= counter + 1 ;
            if (my_col[0] == 0) begin // even col
                // left input 
                if (counter == (MY_COL/2)) begin // r-n
                    shuffle_val <= current_val;
                    state_two_done <= 1 ;
                    counter <= 0 ; 

                end 

            end           

        end
        else if (state == 3) begin // aux state for reset
            state_two_done <= 0 ;
            counter <= 0;
            current_val <= tmp_current_val;
        end if ((state == 4) && (state_two_done == 0)) begin
            current_val<= r_in_val;
            counter <= counter + 1 ;
            if (my_col[0] != 0) begin // odd col
                // left input 
                if (counter == (((TOTAL_COL_COUNT - MY_COL - 1 )/2))) begin // r-n
                    shuffle_val <= current_val;
                    state_two_done <= 1 ;
                    counter <= 0 ; 

                end 

            end           

        end else if (state == 5) begin
            counter <= 0 ; 
            current_val <= shuffle_val;
 
         
        end else if (state == 6) begin // even transpose in first step
            if(my_row[0] == 0) begin // even row
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val > r_in_val) ) begin
                        current_val <= r_in_val;
                    end
                end else begin  // odd col
                    if((current_val < l_in_val) ) begin
                        current_val <= l_in_val;
                    end
                end 
            end else begin
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val < r_in_val) ) begin
                        current_val <= r_in_val;
                    end
                end else begin  // odd col
                    if((current_val > l_in_val) ) begin
                        current_val <= l_in_val;
                    end
                end 
            end
        end else if (state == 7) begin // odd transpose in first step
            if((my_row[0] == 0) ) begin // even row
                if((my_col[0] == 0 ) && (my_row!=0)) begin  // even col
                    if((current_val < t_in_val ) ) begin
                        current_val <= t_in_val;
                    end
                end else begin
                    if((current_val > b_in_val) ) begin
                        current_val <= b_in_val;
                    end
                end
            end else if ((my_row[0]!=0) && (my_row!=(TOTAL_ROW_COUNT-1))) begin          // odd row
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val > b_in_val ) ) begin
                        current_val <= b_in_val;
                    end
                end else begin
                    if((current_val < t_in_val) ) begin
                        current_val <= t_in_val;
                    end
                end

            end
        end 
		*/
        else if (state == 6) begin // odd transpose in first step
            if(my_row[0] == 0) begin // even row
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val < l_in_val ) && (my_col!=0)) begin
                        current_val <= l_in_val;
                    end else if (my_col == 0) begin
                        if((my_row!=0) && (current_val < t_in_val)) begin
                            current_val <= t_in_val;
                        end
                    end
                end else begin
                    if((current_val > r_in_val) && (my_col!=(TOTAL_COL_COUNT-1))) begin
                        current_val <= r_in_val;
                    end else if (my_col == (TOTAL_COL_COUNT -1)) begin
                        if((my_row != (TOTAL_ROW_COUNT-1)) && (current_val > b_in_val)) begin
                            current_val <= b_in_val;
                        end
                    end
                end
            end else begin          // odd row
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val > l_in_val ) && (my_col!=0)) begin
                        current_val <= l_in_val;
                    end else if (my_col == 0) begin
                        if((my_row!=(TOTAL_ROW_COUNT-1)) && (current_val > b_in_val)) begin
                            current_val <= b_in_val;
                        end
                    end
                end else begin
                    if((current_val < r_in_val) && (my_col!=(TOTAL_COL_COUNT-1))) begin
                        current_val <= r_in_val;
                    end else if (my_col == (TOTAL_COL_COUNT -1)) begin
                        if( (current_val < t_in_val)) begin
                            current_val <= t_in_val;
                        end
                    end
                end
            end
        end 
        
        else if (state == 7) begin // even transpose in first step
            if(my_row[0] == 0) begin // even row
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val > r_in_val) ) begin
                        current_val <= r_in_val;
                    end
                end else begin
                    if((current_val < l_in_val) ) begin
                        current_val <= l_in_val;
                    end
                end
            end else begin
                if(my_col[0] == 0 ) begin  // even col
                    if((current_val < r_in_val) ) begin
                        current_val <= r_in_val;
                    end
                end else begin
                    if((current_val > l_in_val) ) begin
                        current_val <= l_in_val;
                    end
                end

            end
        end 

        
    end 

endmodule
