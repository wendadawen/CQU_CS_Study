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
    int n0, n1, n ; cin >> n0 >> n1 >> n ;
    // 女生x间房间，男生y间房间 y = n - x 
    int dif = INT_MAX ; int ret = -1 ;
    for(int x = 1 ; x < n ; ++ x) {
        int y = n - x ;
        if(n0 % x != 0 || n1 % y != 0 || n0 == x) continue ;
        int temp = abs(n0/x - n1/y) ;
        if(temp < dif) {
            dif = temp ;
            ret = x ;
        }
    }
    if(ret == -1) {
        cout << "No Solution" << '\n' ;
        return ;
    }
    cout << ret << " " << n - ret << '\n' ;
}

signed main(){
    ios::sync_with_stdio(false) ; 
    cin.tie(nullptr) ; cout.tie(nullptr) ;
    int t = 1 ; // cin >> t ;
    while( t -- ) solve() ;
    return 0 ;
}
