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
    vector<int> k(n) ;
    for(int i = 0 ; i < n ; ++ i) {
        cin >> k[i] ;
    }
    string s ;
    int cnt = 0 ; int i = 0 ;
    while(cin >> s) {
        if(s == "End") break ;
        if(cnt == k[i]) {
            cout << k[i] << endl ;
            if(s == "ChuiZi") {
                cout << "JianDao" << endl ;
            } else if(s == "JianDao") {
                cout << "Bu" << endl ;
            } else {
                cout << "ChuiZi" << endl ;
            }
            cnt = 0 ;
            i ++ ;
            if(i == n) i = 0 ;
            continue ;
        }
        cnt ++ ;
        if(s == "ChuiZi") {
            cout << "Bu" << endl ;
        } else if(s == "JianDao") {
            cout << "ChuiZi" << endl ;
        } else {
            cout << "JianDao" << endl ;
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
