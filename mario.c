#include <stdio.h>

int main(void) 
{
    // solution to:
    // https://cs50.harvard.edu/x/2022/psets/1/mario/less/
    int height = 8;
    for(int i = 0; i < height; i++)
    {
        for(int j = height - i; j > 1; j--) 
        {
            printf(" ");
        }
        for(int j = i + 1; j > 0; j--) 
        {
            printf("#");
        }
        puts("");
    }
}
