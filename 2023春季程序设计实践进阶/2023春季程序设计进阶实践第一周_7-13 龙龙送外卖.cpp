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

const int N = 2e5 + 5 ;
vector<int> fa(N) ;
int tag[N] ; // 标记这个地点是否走过
int dep[N] ; // 标记每个地点的深度
int total = 0 ;  // 走过的所有路径的2倍
int max_depth = 0 ; // 根节点深度是0
int d = -1 ; // 临时变量

int upsearch(int x) {
    if(x == -1) return -1 ;
    d ++ ;
    if(tag[x]) {
        return dep[x] ;
    }
    tag[x] = 1 ;
    dep[x] = upsearch(fa[x]) + 1 ;
    return dep[x] ;
}

void solve(){
    int n, m ; cin >> n >> m ;
    for(int i = 1 ; i <= n ; ++ i) {
        int x ; cin >> x ;
        fa[i] = x ;
    }
    for(int i = 1 ; i <= m ; ++ i) {
        int x ; cin >> x ;
        d = -1 ;
        upsearch(x) ;
        total += 2 * d ;
        max_depth = std::max(max_depth, dep[x]) ;
        cout << total - max_depth << endl ;
    }
}

signed main(){
    ios::sync_with_stdio(false) ; 
    cin.tie(nullptr) ; cout.tie(nullptr) ;
    int t = 1 ; // cin >> t ;
    while( t -- ) solve() ;
    return 0 ;
}
