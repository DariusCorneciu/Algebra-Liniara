#include <iostream>
#include <fstream>

std::ifstream f("C:\\Users\\Darius Corneciu\\CLionProjects\\algebraliniara\\matrix.txt");
using namespace std;

int traditionala(int a[100][100], int n)
{
    int i,j,x,s=0,semn=1;
    int sub[100][100],si,sj;
    if (n == 2)
        return a[0][0] * a[1][1] - a[0][1] * a[1][0];

    else {
        for (x = 0; x < n; x++) {
            si = -1;
            for (i = 0; i < n; i++) {
                sj = 0;
                for (j = 0; j < n; j++)
                    if (j == x or i == 0)
                        continue;
                    else
                        sub[si][sj] = a[i][j], sj++;
                si++;
            }
            s += semn * (a[0][x] * (traditionala(sub, n - 1)));
            semn = -semn;

        }

        return s;
    }

}


int main()
{
    int matrix[100][100],n,i,j;
    f>>n;
    for(i=0;i<n;i++)
        for(j=0;j<n;j++)
            f>>matrix[i][j];
    cout<<"Determinantul: "<<traditionala(matrix,n);
    cout<<endl;
    for(i=0;i<n;i++)
    {
        for(j=0;j<n;j++)
            cout<<matrix[i][j]<<' ';
        cout<<endl;
    }


    return 0;
}
