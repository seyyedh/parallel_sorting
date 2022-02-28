module Sort #(parameter WIDTH = 8 , ROW = 4, COL = 4) (clk,rst,init_values);
    input clk;
    input rst;
    input [WIDTH * ROW * COL - 1:0] init_values;

    wire [WIDTH * COL -1:0] init_values_wire [0:ROW-1];

    genvar i;
    genvar j;

    reg [9:0] counter = 0 ;
    reg [3:0] state_machine = 0 ;
    always@(posedge clk) begin
        if(rst == 1 ) begin
            state_machine <= 0;
        end else begin
            if(state_machine == 0 ) begin
                state_machine <= 1;
                counter <= counter + 1;
            end else if (state_machine == 1) begin
                if(counter == (COL/2-1)) begin
                    counter <= 0 ;
                    state_machine <= 2;
                end else begin
                    counter <= counter + 1 ;
                    state_machine <= 0;

                end
            end else if(state_machine == 2 ) begin
                state_machine <= 3;
                counter <= counter + 1;
            end else if (state_machine == 3) begin
                if(counter == (COL-1)) begin
                    counter <= 0 ;
                    state_machine <= 4;
                end else begin
                    counter <= counter + 1 ;
                    state_machine <= 2;

                end
            end else if(state_machine == 4 ) begin
                state_machine <= 5;
                counter <= counter + 1;
            end else if (state_machine == 5) begin
                if(counter == (ROW-1)) begin
                    counter <= 0 ;
                    state_machine <= 6;
                end else begin
                    counter <= counter + 1 ;
                    state_machine <= 4;

                end
            /*end else if (state_machine == 6) begin
                state_machine <= 7;
                counter <= counter + 1;
            end else if (state_machine == 7) begin
                if(counter == (2*COL-1)) begin
                    counter <= 0 ;
                    state_machine <= 8;
                end else begin
                    counter <= counter + 1 ;
                    state_machine <=6 ;

                end*/
            end else if (state_machine == 6) begin
                state_machine <= 7;
                counter <= counter + 1;
            end else if (state_machine == 7) begin
                if(counter == (COL)) begin
                    counter <= 0 ;
                    state_machine <= 8;
                end else begin
                    counter <= counter + 1 ;
                    state_machine <=6 ;

                end
            end 

        end
    end

    generate
        for(i = 0 ; i < ROW ; i = i + 1) begin : FOR1
            for(j = 0 ;j < COL ; j = j + 1) begin : FOR2
                assign init_values_wire[i][(j+1)*WIDTH-1:j*WIDTH] = init_values[(i * COL + j + 1)*WIDTH - 1: (i * COL + j)*WIDTH ];
            end
        end
    endgenerate

    wire [WIDTH * COL -1:0] mesh_conn_v[0:ROW-1]; // vertical connection
    wire [WIDTH * COL -1:0] mesh_conn_h[0:ROW-1]; // horizontal connection

    generate
        for(i = 0 ; i < ROW; i = i + 1 ) begin : FOR3

            for(j = 0 ; j < COL; j = j + 1) begin : FOR4
                wire [WIDTH-1:0] pre_val = init_values_wire[i][(j+1)*WIDTH-1:j*WIDTH];

                // left to right connection
                wire [WIDTH-1:0] l_in_val;
                if(j == 0) begin
                    assign l_in_val = mesh_conn_h[i][(COL) *WIDTH-1:(COL-1)*WIDTH];
                end else begin
                    assign l_in_val = mesh_conn_h[i][(j) *WIDTH-1:(j-1)*WIDTH];
                end

                wire [WIDTH-1:0] r_in_val;
                if(j == (COL-1)) begin
                    assign r_in_val = mesh_conn_h[i][WIDTH-1:0];
                end else begin
                    assign r_in_val = mesh_conn_h[i][(j+2) *WIDTH-1:(j+1)*WIDTH];
                end

                wire [WIDTH-1:0] t_in_val;
                if(i == 0) begin
                    assign t_in_val = mesh_conn_v[ROW-1][(j+1) *WIDTH-1:(j)*WIDTH];
                end else begin
                    assign t_in_val = mesh_conn_v[i-1][(j+1) *WIDTH-1:(j)*WIDTH];
                end

                wire [WIDTH-1:0] b_in_val;
                if(i == (ROW-1)) begin
                    assign b_in_val = mesh_conn_v[0][(j+1) *WIDTH-1:(j)*WIDTH];
                end else begin
                    assign b_in_val = mesh_conn_v[i+1][(j+1) *WIDTH-1:(j)*WIDTH];
                end


                wire [WIDTH-1:0] l_out_val;
                wire [WIDTH-1:0] r_out_val;
                assign mesh_conn_h[i][(j+1) *WIDTH-1:(j)*WIDTH] = r_out_val;
                wire [WIDTH-1:0] t_out_val;
                wire [WIDTH-1:0] b_out_val;
                assign mesh_conn_v[i][(j+1) *WIDTH-1:(j)*WIDTH] = b_out_val;

                // end LTR

                PE #(.WIDTH(WIDTH), .MY_ROW(i), .MY_COL(j), .TOTAL_ROW_COUNT(ROW), .TOTAL_COL_COUNT(COL))
                    pe (.clk(clk), .rst(rst), .state(state_machine), .pre_val(pre_val), .l_in_val(l_in_val), .r_in_val(r_in_val), 
                        .t_in_val(t_in_val), .b_in_val(b_in_val), .l_out_val(l_out_val), .r_out_val(r_out_val), .t_out_val(t_out_val), 
                        .b_out_val(b_out_val));
            end
        end

    endgenerate 

endmodule