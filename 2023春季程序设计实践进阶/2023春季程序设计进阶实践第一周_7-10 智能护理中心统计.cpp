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

const int N = 1e4 + 5 ;
string old[N + 1] ; // 老人的上级归属
unordered_map<string, vector<string>> header ; // 管理节点的下级部门
unordered_map<string, int> cnt ; // 每个管理节点的老人数量

int query(string s) {
    int ret = cnt[s] ;
    queue<string> q ;
    q.push(s) ;
    while(q.size()) {
        s = q.front() ; q.pop() ;
        for(auto ss: header[s]) {
            q.push(ss) ;
            ret += cnt[ss] ;
        }
    }
    
    return ret ;
}


void solve(){
    int n, m ; cin >> n >> m ;
    string a, b ; 

    for(int i = 0 ; i < m ; ++ i) {
         cin >> a >> b ;
         if(a[0] <= '9' && a[0] >= '0') {
            old[stoi(a)] = b ;
            cnt[b] ++ ;
         } else {
            header[b].push_back(a) ;
         }
    }

    char s ; int x ;
    while(cin >> s) {
        if(s == 'E') break ;
        if(s == 'Q') {
            cin >> a ;
            cout << query(a) << endl ;
        } else if(s == 'T'){
            cin >> x >> a ;
            cnt[old[x]] -- ;
            old[x] = a ;
            cnt[old[x]] ++ ;
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
