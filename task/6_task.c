#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

extern double f1(double);
extern double f2(double);
extern double f3(double);

int cnt_root = 0;

int sgn(double n)
{
   return (0 < n) - (n < 0);
}

double root (double (*f)(double), double (*g)(double), double a, double b, double eps1)
{
    double length = fabs(b - a);
    double tmp, medium, f_med, g_med;
    length /= 2;
    
    if(a > b)
    {
        tmp = b;
        b = a;
        a = tmp;
    }
    
    while(1)
    {
        cnt_root++;
        medium = a + length;

        f_med = (*f)(medium);
        g_med = (*g)(medium);
        
        if(fabs(f_med - g_med) <= eps1)
            return medium;

        if(sgn((*f)(a) - (*g)(a)) != sgn(f_med - g_med))
            b = medium;
        else 
            a = medium;
        
        length /= 2;
    }
}

double integral(double (*f)(double), double a, double b, double eps2)
{
    double h = (b - a)/eps2;
    double answer = 0;

    int i;

    answer += (*f)(a) / 2;

    for(i = 1; i < eps2-1; i++)
        answer += (*f)(a + i * h);

    answer += (*f)(b) / 2;
    answer *= h;

    return answer;
}


//1: 2^x+1
//2: x^5
//3: (1-x)/3

int main(int argc, char *argv[])
{
    double x12, x13, x23, integral1, integral2, integral3, area, lower_limit, upper_limit, left_limit, right_limit, epsilon;
    char command[15];
    int number, intervals, first_function, second_function, x12_cnt, x13_cnt, x23_cnt, flag = 0;

    x12 = root(f1, f2, 1, 2, 0.0001);
    x12_cnt = cnt_root;
    cnt_root = 0;
    x13 = root(f1, f3, -3, -2, 0.0001);
    x13_cnt = cnt_root;
    cnt_root = 0;
    x23 = root(f2, f3, 0, 1, 0.0001);
    x23_cnt = cnt_root;
    cnt_root = 0;

    integral1 = integral(f1, x13, x12, 6400);
    integral2 = integral(f2, x23, x12, 6400);
    integral3 = integral(f3, x13, x23, 6400);

    double (*f_array[])(double) = {f1, f2, f3};
   
    area = integral1 - integral2 - integral3;

    for (int i = 1; i < argc; ++i) 
    {
        if(strcmp(argv[i], "-help") == 0)
        {
            printf("Type in '1' to show x coordinate of intersection of 2^x + 1 and x^5\n");
            printf("Type in '2' to show x coordinate of intersection of 2^x + 1 and (1-x)/3\n");
            printf("Type in '3' to show x coordinate of intersection of x^5 and (1-x)/3\n");
            printf("Type in '-area' to show the area between curves\n");
            printf("Type in '-integral' to test the integral()\n\n");

            printf("Type in '0' to test the 2^x + 1 after root and integral\n");
            printf("Type in '1' to test the x^5 after root and integral\n");
            printf("Type in '2' to test the (1-x)/3 after root and integral\n\n");

            printf("Type in '-root' to test the root():\n");
        }

        else if (strcmp(argv[i], "-area") == 0) 
            printf("Area = %f\n", area);

        else if (strcmp(argv[i], "1") == 0)
        {
            printf("Intersection of 2^x + 1 and x^5 = %f\n", x12); 
        }

        else if (strcmp(argv[i], "2") == 0)
        {
            printf("Intersection of 2^x + 1 and (1-x)/3 = %f\n", x13);
        }

        else if (strcmp(argv[i], "3") == 0)
        {
            printf("Intersection of x^5 and (1-x)/3 = %f\n", x23);  
        }

        else if (strcmp(argv[i], "-integral") == 0)
        {
            printf("Integral = %f\n", integral(f_array[atoi(argv[i+1])], atof(argv[i+2]), atof(argv[i+3]), atoi(argv[i+4])));
            i+=4;
        }

        else if (strcmp(argv[i], "-root") == 0)
        {
            printf("Root = %lf\n", root(f_array[atoi(argv[i+1])], f_array[atoi(argv[i+2])], atof(argv[i+3]), atof(argv[i+4]), atof(argv[i+5])));
            i+=5;   
            
        }
        else if(strcmp(argv[i], "-iter") == 0)
        {
            flag = 1;
        }
        else
            printf("Wrong command\n");
    }

    if(flag == 1)
        printf("Amount of iterations = %d\n", cnt_root);
    return 0;
}
