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
    int n, k, x ; cin >> n >> k >> x ;
    vector<vector<int>> v(n+1, vector<int>(n+1)) ;
    vector<int> ret(n + 1) ;
    int cnt = 1 ;
    for(int  i = 1 ; i <= n ; ++ i) {
        cnt = 1 ;
        for(int j = 1 ; j  <= n ; ++ j) {
            cin >> v[i][j] ;
            if(j % 2 == 0) {
                if(i - cnt <= 0) ret[i] += x ;
                else ret[i] += v[i-cnt][j] ;
                if(++ cnt == k + 1) cnt = 1 ;
            } else {
                ret[i] += v[i][j] ;
            }
        }
    }
    for(int i = 1 ; i <= n ; ++ i) {
        if(i != n) cout << ret[i] << ' ' ;
        else cout << ret[i] << endl ;
    }
}

signed main(){
    ios::sync_with_stdio(false) ; 
    cin.tie(nullptr) ; cout.tie(nullptr) ;
    int t = 1 ; // cin >> t ;
    while( t -- ) solve() ;
    return 0 ;
}
