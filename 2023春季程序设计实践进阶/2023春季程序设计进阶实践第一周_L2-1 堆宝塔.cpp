#include <bits/stdc++.h>
#define int long long
#define x first
#define y second 
#define debug cout << "__LINE__" << __LINE__ << endl ;
using namespace std ; typedef long long ll ; typedef pair<int,int> pii ;
const int INF = 0x3f3f3f3f3f3f3f3f ; const double eps=1e-6 ; const int P = 1e9 + 7 ;
inline ll gcd(ll a, ll b) { return b == 0 ? a : gcd(b,a%b);}
inline ll lcm(ll a, ll b) { return a / gcd(a, b) * b;}
inline ll mod(ll x,ll p=P) { return (x%p + p)%p;}
inline ll qpow(ll a,ll b,ll p=P) { ll res = 1;a=mod(a,p); while (b) { if (b&1) res=mod(res*a,p);a=mod(a*a,p);b>>=1;}return res;}

void solve(){
    int n ; cin >> n ; 
    stack<int> A, B ; 
    int ret_length = 0 ; int ret_size = 0 ;
    for(int i = 0 ; i < n ; ++ i) {
        int c ; cin >> c ;
        if(A.empty()) {
            A.push(c) ;
        } else {
            int a = A.top() ;
            if(c < a) {
                A.push(c) ;
            } else {
                if(B.empty() || B.top() < c) {
                    B.push(c) ;
                } else {
                    ret_size ++ ;
                    ret_length = max(ret_length, (int)A.size()) ;
                    A = stack<int>() ;
                    while(B.size() && B.top() > c) {
                        A.push(B.top()) ;
                        B.pop() ;
                    }
                    A.push(c) ;
                }
            }
        }
    }
    if(A.size()) {
        ret_size ++ ;
        ret_length = max(ret_length, (int)A.size()) ;
    }
    if(B.size()) {
        ret_size ++ ;
        ret_length = max(ret_length, (int)B.size()) ;
    }
    cout << ret_size << " " << ret_length << endl ;
}

signed main(){
    ios::sync_with_stdio(false) ; 
    cin.tie(nullptr) ; cout.tie(nullptr) ;
    int t = 1 ; // cin >> t ;
    while( t -- ) solve() ;
    return 0 ;
}
