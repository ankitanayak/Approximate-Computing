#include <iostream>
#include <string.h>
#include <cstdio>
#include <fstream>
using namespace std;

int main() {

	//char hex[6];
	char binary_char[24];
	int binary[24];
	int outarray[65536];
	int c_array[32][8][256];
	int i,j,p,q;
	long dec = 0, base = 1;
	float floatdec, floatbase, rem;
	string line;







	ifstream in7("C:/Modeltech_pe_edu_10.4a/examples/output.txt");
	if( !in7.is_open())
	{
		cout << "Input file failed to open\n";
		return 1;
	}
	ofstream out7("C:/Users/Ankita Nayak/Desktop/Ankita/Thesis Docs/simulation dct results/outfile.txt");
	out7<<"C = [";
	q=0;
	while( getline(in7,line) )
	{

		for(p=0; p<24; p++)
		{
			binary_char[p]=line[p];
		}

		for(j=0; j<24; j++)
		{
			if(binary_char[j] == '0')
			{
				binary[j]=0;
			}
			if(binary_char[j] == '1')
			{
				binary[j]=1;
			}
		}

		base=1;
		dec=0;
		for(i=12; i>-1; i--)
		{
			//cout<<"the binary "<<binary[i]<<"\n";
			dec = dec + (binary[i] * base);
			base = base * 2;
		}


		floatdec=0.0;
		floatbase=2.0;
		for(i=13; i<24; i++)
		{
			//cout<<"the binary "<<binary[i]<<"\n";
			floatdec = floatdec + (binary[i]*(1/floatbase));
			floatbase = floatbase * 2;
		}


		rem=dec+floatdec;

		outarray[q]=rem;
		q=q+1;


	}

	for(int l=0; l<32; l++)
	{
		for(int k=0; k<8; k++)
		{
			for(int r=0; r<32; r++)
			{
				for(int s=0; s<8; s++)
				{
					c_array[l][k][(8*r)+s]=outarray[(2048*l)+(8*k)+(64*r)+s];
				}
			}
		}
	}

	for(int m=0; m<32; m++)
	{
		for(int n=0; n<8; n++)
		{
			for(int o=0; o<256; o++)
			{
				out7<<c_array[m][n][o];
				if(o<255)
				{
					out7<<",";
				}
			}
			out7<<";";
			/*if(m<31)
			{
				out7<<";";
			}*/
		}
	}

	out7<<"];";





	in7.close();
	out7.close();

	return 0;
}
