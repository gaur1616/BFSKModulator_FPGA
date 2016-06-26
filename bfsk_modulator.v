module  bfsk_modulator(CLOCK_50,
				  signal1, signal2,
				  signal);
				  
input CLOCK_50;
input [15:0] signal1;
input [15:0] signal2;
output [15:0] signal;

reg [15:0] signal;

//Variables for BFSK generation
parameter integer ldata = 8;
parameter integer nb = 256;
integer nb_count = 0;
reg [ldata - 1:0] data = 8'd170;
reg [$clog2(ldata):0] bit_ctl = 3'd0;

always@(posedge CLOCK_50)
begin
	if(bit_ctl < ldata)
	begin
		if(nb_count == nb - 1)
		begin
			nb_count <= 0;
			bit_ctl <= bit_ctl + 3'd1;
		end
		else
		begin
			nb_count <= nb_count + 1;
		end
		if(data[bit_ctl] == 0)
		begin
			signal <= signal1;
		end
		else
		begin
			signal <= signal2;
		end
	end
	else
	begin
		signal <= 16'd32768;
	end
end

endmodule
