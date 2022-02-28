module Tb;
    reg clk;
    reg rst;
    parameter WIDTH = 8;
    parameter ROW = 8;
    parameter COL = 8;

    reg [WIDTH * COL - 1:0] init_values[0:ROW-1];
    wire [WIDTH * COL *ROW - 1:0] init_values_wire;
    Sort #(.WIDTH(WIDTH), .ROW(ROW), .COL(COL)) sort (.clk(clk), .rst(rst), .init_values(init_values_wire));

    genvar i;
    genvar j;
    generate
        for(i = 0 ; i < ROW ; i = i + 1 ) begin
            for(j = 0 ; j < COL ; j = j + 1 ) begin
                assign init_values_wire [(i * COL + j + 1)*WIDTH - 1: (i * COL + j)*WIDTH ] = init_values[i][(j+1)*WIDTH - 1: j*WIDTH];
            end
        end
    endgenerate

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,Tb);
        // row 0
        init_values[0][1*WIDTH -1 :0 *WIDTH] = 0;
        init_values[0][2*WIDTH -1 :1 *WIDTH] = 12;
        init_values[0][3*WIDTH -1 :2 *WIDTH] = 4;
        init_values[0][4*WIDTH -1 :3 *WIDTH] = 9;
        init_values[0][5*WIDTH -1 :4 *WIDTH] = 50;
        init_values[0][6*WIDTH -1 :5 *WIDTH] = 3;
        init_values[0][7*WIDTH -1 :6 *WIDTH] = 12;
        init_values[0][8*WIDTH -1 :7 *WIDTH] = 19;

        // row 1
        init_values[1][1*WIDTH -1 :0 *WIDTH] = 12;
        init_values[1][2*WIDTH -1 :1 *WIDTH] = 5;
        init_values[1][3*WIDTH -1 :2 *WIDTH] = 9;
        init_values[1][4*WIDTH -1 :3 *WIDTH] = 12;
        init_values[1][5*WIDTH -1 :4 *WIDTH] = 18;
        init_values[1][6*WIDTH -1 :5 *WIDTH] = 35;
        init_values[1][7*WIDTH -1 :6 *WIDTH] = 9;
        init_values[1][8*WIDTH -1 :7 *WIDTH] = 12;

        // row 2
        init_values[2][1*WIDTH -1 :0 *WIDTH] = 30;
        init_values[2][2*WIDTH -1 :1 *WIDTH] = 29;
        init_values[2][3*WIDTH -1 :2 *WIDTH] = 19;
        init_values[2][4*WIDTH -1 :3 *WIDTH] = 24;
        init_values[2][5*WIDTH -1 :4 *WIDTH] = 10;
        init_values[2][6*WIDTH -1 :5 *WIDTH] = 9;
        init_values[2][7*WIDTH -1 :6 *WIDTH] = 12;
        init_values[2][8*WIDTH -1 :7 *WIDTH] = 4;

        // row 3
        init_values[3][1*WIDTH -1 :0 *WIDTH] = 7;
        init_values[3][2*WIDTH -1 :1 *WIDTH] = 11;
        init_values[3][3*WIDTH -1 :2 *WIDTH] = 20;
        init_values[3][4*WIDTH -1 :3 *WIDTH] = 19;
        init_values[3][5*WIDTH -1 :4 *WIDTH] = 39;
        init_values[3][6*WIDTH -1 :5 *WIDTH] = 54;
        init_values[3][7*WIDTH -1 :6 *WIDTH] = 17;
        init_values[3][8*WIDTH -1 :7 *WIDTH] = 35;

        // row 4
        init_values[4][1*WIDTH -1 :0 *WIDTH] = 37;
        init_values[4][2*WIDTH -1 :1 *WIDTH] = 42;
        init_values[4][3*WIDTH -1 :2 *WIDTH] = 49;
        init_values[4][4*WIDTH -1 :3 *WIDTH] = 33;
        init_values[4][5*WIDTH -1 :4 *WIDTH] = 99;
        init_values[4][6*WIDTH -1 :5 *WIDTH] = 10;
        init_values[4][7*WIDTH -1 :6 *WIDTH] = 25;
        init_values[4][8*WIDTH -1 :7 *WIDTH] = 40;

        // row 5
        init_values[5][1*WIDTH -1 :0 *WIDTH] = 4;
        init_values[5][2*WIDTH -1 :1 *WIDTH] = 43;
        init_values[5][3*WIDTH -1 :2 *WIDTH] = 59;
        init_values[5][4*WIDTH -1 :3 *WIDTH] = 31;
        init_values[5][5*WIDTH -1 :4 *WIDTH] = 64;
        init_values[5][6*WIDTH -1 :5 *WIDTH] = 69;
        init_values[5][7*WIDTH -1 :6 *WIDTH] = 76;
        init_values[5][8*WIDTH -1 :7 *WIDTH] = 16;

        // row 6
        init_values[6][1*WIDTH -1 :0 *WIDTH] = 5;
        init_values[6][2*WIDTH -1 :1 *WIDTH] = 93;
        init_values[6][3*WIDTH -1 :2 *WIDTH] = 10;
        init_values[6][4*WIDTH -1 :3 *WIDTH] = 14;
        init_values[6][5*WIDTH -1 :4 *WIDTH] = 59;
        init_values[6][6*WIDTH -1 :5 *WIDTH] = 74;
        init_values[6][7*WIDTH -1 :6 *WIDTH] = 99;
        init_values[6][8*WIDTH -1 :7 *WIDTH] = 12;

        // row 7
        init_values[7][1*WIDTH -1 :0 *WIDTH] = 18;
        init_values[7][2*WIDTH -1 :1 *WIDTH] = 25;
        init_values[7][3*WIDTH -1 :2 *WIDTH] = 84;
        init_values[7][4*WIDTH -1 :3 *WIDTH] = 32;
        init_values[7][5*WIDTH -1 :4 *WIDTH] = 44;
        init_values[7][6*WIDTH -1 :5 *WIDTH] = 53;
        init_values[7][7*WIDTH -1 :6 *WIDTH] = 94;
        init_values[7][8*WIDTH -1 :7 *WIDTH] = 79;

        rst = 1 ;
        #1 clk = 0 ;
        #1 clk = 1;

        #1 clk = 0 ;
        #1 clk = 1;
        rst = 0 ;
        
        repeat (300) begin
            #1 clk = 0 ;
            #1 clk = 1;
            
        end 
        

    end


endmodule
