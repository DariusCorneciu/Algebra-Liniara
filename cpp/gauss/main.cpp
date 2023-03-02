#include <iostream>
#include <fstream>
using namespace std;
ifstream f("C:\\Users\\Darius Corneciu\\CLionProjects\\algebraliniara\\cpp\\traditional\\matrix.txt");

int main()
{
    double matrix[100][100], det = 1,n,t,retin;
    bool ok = false;
    f>>n;
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            f >> matrix[i][j];
        }
    }

    for (int i = 0; i < n; ++i)
    {
       
        if (matrix[i][i] == 0)
        {
            ok = true;
            for (int j = i; j < n; ++j)
            {
                if (matrix[j][i] != 0) {
                    det *= -1;
                    for (int k = 0; k < n; ++k) {
                        t = matrix[i][k];
                        matrix[i][k] = matrix[j][k];
                        matrix[j][k] = t;
                        ok = false;
                    }
                }
            }
        }

        if (ok) {
            det = 0;
            break;
        }

        else {

            for (int j = i+1; j < n; ++j)
            {
                retin = matrix[j][i];
                for (int k = i; k < n; ++k) {
                    matrix[j][k] -= (matrix[i][k]*retin)/matrix[i][i];

                }
            }
            det *= matrix[i][i];
        }
    }

    cout << "Determinant: " << det;
    return 0;
}
