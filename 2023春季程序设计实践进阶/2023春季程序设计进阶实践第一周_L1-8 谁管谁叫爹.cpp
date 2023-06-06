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

int getnum(int x) {
    int ret = 0 ;
    while(x) {
        ret += x % 10 ;
        x /= 10 ;
    }
    return ret ;
}

void solve(){
    int n ; cin >> n ;
    for(int i = 0 ; i < n ; ++ i) {
        int x, y ; cin >> x >> y ;
        int sx = getnum(x) ;
        int sy = getnum(y) ;
        if(x % sy == 0 && y % sx == 0) {
            if(x > y) {
                cout << 'A' << endl ;
            } else {
                cout << 'B' << endl ;
            }
        }else if(x % sy == 0) cout << 'A' << endl ;
        else if(y % sx == 0) cout << 'B' << endl ;
        else {
            if(x > y) {
                cout << 'A' << endl ;
            } else {
                cout << 'B' << endl ;
            }
        }
    }
}

signed main(){
    ios::sync_with_stdio(false) ; 
    cin.tie(nullptr) ; cout.tie(nullptr) ;
    int t = 1 ; // cin >> t ;
    while( t -- ) solve() ;
    return 0 ;
}
