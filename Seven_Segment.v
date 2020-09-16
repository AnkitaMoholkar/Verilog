module seven_segment(
    input wire clk,
    input wire [3:0] val3,
    input wire [3:0] val2,
    input wire [3:0] val1,
    input wire [3:0] val0,
    output wire an3,
    output wire an2,
    output wire an1, 
    output wire an0,
    output wire ca,
    output wire cb,
    output wire cc,
    output wire cd,
    output wire ce,
    output wire cf,
    output wire cg,
    output wire dp
    );
    
    // We are not using the decimal point, so deactivate this signal
    // it is an active low signal
    
    assign dp = 1'b1;
    
    // Assign counter and variable sizes
    reg [15:0] counter = 0;
    reg [1:0] step = 0;
    reg [3:0] val;
    reg [6:0] Display;
    
    assign {ca, cb, cc, cd, ce, cf, cg} = Display;
    
    always @ (*)
    begin 
    case(val)
    4'h0: Display = 7'b0000001;    // "0"
    4'h1: Display = 7'b1001111;    // "1"
    4'h2: Display = 7'b0010010;    // "2"
    4'h3: Display = 7'b0000110;    // "3"
    4'h4: Display = 7'b1001100;    // "4"
    4'h5: Display = 7'b0100100;    // "5"
    4'h6: Dispaly = 7'b0100000;    // "6"
    4'h7: Display = 7'b0001111;    // "7"
    4'h8: Display = 7'b0000000;    // "8"
    4'h9: Display = 7'b0000100;    // "9"
    4'hA: Display = 7'b0001000;    // "A"
    4'hB: Display = 7'b1100000;    // "b"
    4'hC: Display = 7'b0110001;    // "C"
    4'hD: Display = 7'b1000010;    // "d"
    4'hE: Display = 7'b0110000;    // "E"
    4'hF: Display = 7'b0111000;    // "F"
    default: Display = 7'b0000001; // "0"
    endcase
    end
    
    always @(posedge clk)
    begin
    if (counter == 20000) counter <= 0;
    else counter <= counter + 1;
    end
    
    always @(posedge clk)
    begin 
    if (counter == 20000) step <= step + 1;
    end
    
    always @*
    begin
    case(step)
    0: val = val0;
    1: val = val1;
    2: val = val2;
    3: val = val3;
    endcase
    end
    
    assign an0 = !(step == 0);
    assign an1 = !(step == 1);
    assign an2 = !(step == 2);
    assign an3 = !(step == 3);
    
    
endmodule
