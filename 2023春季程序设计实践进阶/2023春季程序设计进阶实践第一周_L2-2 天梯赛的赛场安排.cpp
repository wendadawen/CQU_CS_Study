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

struct qwq{
    int idx ;
    string s ;
    bool operator<(const qwq& rhs) const {
        return idx < rhs.idx ;
    }
} ;

struct node{
    int num_people ;
    string s ;
    bool operator<(const node& rhs) const {
        return num_people < rhs.num_people ;
    } 
} ;

void solve(){
    int n, c ; cin >> n >> c ;
    string s ; int x ; 
    unordered_map<string, int> mp ;
    map<qwq, int> cnt ;
    priority_queue<node> q ; 
    for(int i = 0 ; i < n ; ++ i) {
        cin >> s >> x ;
        q.push({x, s}) ;
        mp[s] = i ;
        cnt[{i, s}] = 0 ;
    }
    vector<int> v ; // 存放考场剩余人数
    int ret = 0 ;
    while(q.size()) {
        auto tt = q.top() ; q.pop() ;
        int num = tt.num_people ;
        string school = tt.s ;
        cnt[{mp[school], school}] ++ ;
        if(num > c) {
            ret ++ ;
            q.push({num - c, school}) ;
        } else if(num == c) {
            ret ++ ;
        } else {
            // 在v中查找第一个大于等于num的下标
            // 找到了就删除它，重新插入合适的位置,若不是0的话    
            // 没找到直接找到合适位置插入c-num
            auto it = lower_bound(v.begin(), v.end(), num) ;
            if(it != v.end()) { // 找到了
                int x = *it ;
                v.erase(it) ;
                if(x != num) {
                    auto it = upper_bound(v.begin(), v.end(), x - num) ;
                    v.insert(it, x - num) ;
                }
            } else {
                auto it = upper_bound(v.begin(), v.end(), c - num) ;
                v.insert(it, c - num) ;
                ret ++ ;
            }
        }
    }
    for(auto e: cnt) {
        cout << e.first.s << " " << e.second << endl ;
    }
    cout << ret ;
}

signed main(){
    ios::sync_with_stdio(false) ; 
    cin.tie(nullptr) ; cout.tie(nullptr) ;
    int t = 1 ; // cin >> t ;
    while( t -- ) solve() ;
    return 0 ;
}
