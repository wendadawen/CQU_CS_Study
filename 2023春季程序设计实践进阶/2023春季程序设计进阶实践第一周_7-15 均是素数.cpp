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


bool isprime(int n) {
    if (n <= 1) {
        return false;
    }
    int root = std::sqrt(n);
    for (int i = 2; i <= root; i++) {
        if (n % i == 0) {
            return false;
        }
    }
    return true;
}

void solve(){
    int a, b ; cin >> a >> b ;
    vector<int> v ;
    for(int i = a ; i <= b ; ++ i) {
        if(isprime(i)) v.push_back(i) ;
    }
    int ret = 0 ;
    for(int i = 0 ; i < v.size() ; ++ i) {
        for(int j = i + 1 ; j < v.size() ; ++ j) {
            for(int k = j + 1 ; k < v.size() ; ++ k) {
                if( isprime(v[i]*v[j]+v[k]) && 
                    isprime(v[i]*v[k]+v[j]) &&
                    isprime(v[k]*v[j]+v[i])) ret ++ ;
            }
        }
    }
    cout << ret << endl ;
}

signed main(){
    ios::sync_with_stdio(false) ; 
    cin.tie(nullptr) ; cout.tie(nullptr) ;
    int t = 1 ; // cin >> t ;
    while( t -- ) solve() ;
    return 0 ;
}
