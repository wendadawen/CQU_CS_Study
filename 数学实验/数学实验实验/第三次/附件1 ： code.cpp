#include <bits/stdc++.h>
using namespace std ;
using ll = long long ;

const int NUM_OF_CREDIT = 4 ;  // 每位债权人可以获得的最大物品数量

int n ,m , S, T ;  // 债权人数量, 物品数量, 超级源点，超级汇点

const int inf = 0x3f3f3f3f;
const int N = 1e5 + 1 ;
const int M = 2e6 + 1 ;

// 每位债权人选择的物品
unordered_map<int, unordered_map<int,int>> ret ; 

int h[N] , tot = 1 ;
struct node{int to,w,c,ne;}e[M] ;
void add(int u,int v,int c,int w){
    e[++tot] = {v,w,c,h[u]} ; h[u] = tot ;
    e[++tot] = {u,-w,0,h[v]} ; h[v] = tot ;
}

 // spfa EK 两个函数为 求解最大费用最大流的函数
int dis[N] , mf[N] , pre[N] , vis[N] ;
bool spfa(int s,int t){
    memset(dis,0x3f,sizeof(dis)) ; dis[s] = 0 ;  
    memset(mf,0,sizeof(mf)) ; 
    queue<int> q ; q.push(s) ; vis[s] = 1 ; mf[s] = inf ;
    while(q.size()){
        int u = q.front() ; q.pop() ; vis[u] = 0 ;
        for(int i=h[u];i;i=e[i].ne){
            int v = e[i].to , w = e[i].w , c = e[i].c ;
            if(c && dis[v] > dis[u] + w) {
                dis[v] = dis[u] + w ;
                mf[v] = min(mf[u] , c) ; pre[v] = i ;
                if(!vis[v]) q.push(v) , vis[v] = 1 ;
            } 
        }
    }
    return mf[t] > 0 ;
}

pair<ll,ll> EK(int s,int t){
    ll minCost = 0 ; ll tp = 0 ;
    while(spfa(s,t)){
        int v = t ; 
        vector<int> arr ; 
        while(v != s){
        	if(v != t) arr.push_back(v) ; 
            int i = pre[v] ;
            e[i].c -= mf[t] ;
            e[i^1].c += mf[t] ;
            v = e[i^1].to ;
        }
    	int pre = arr[0] ;
    	for(int i = 1 ; i < arr.size() ; ++ i) {
    		if(arr[i] < pre) {
    			ret[arr[i]][pre - n] ++ ;
    		} else {
    			ret[pre][arr[i] - n] -- ;
    		}
    		pre = arr[i] ;
    	}

        tp += mf[t] ;
        minCost += dis[t] * mf[t] ;
    }
    return {tp,minCost} ;
}

void solve() {

	freopen("three.in", "r", stdin) ;
	freopen("three.txt", "w", stdout) ;

	cin >> n ; // 输入债权人数量 n
	cin >> m ; // 输入物品数量 m

	S = 0 ; // 超级源点的编号是 0
	T = n + m + 1 ;  // 超级汇点的编号是 n + m + 1

	int x ; // 临时变量 x

	// 输入物品数量，并且向超级汇点连边
	for(int i = 1 ; i <= m ; ++ i) {  
		// 输入数据的 i 代表第 i 种物品，它的编号是 n + i 
		cin >> x ; 
		add(n + i , T , x , 0) ;
	}

	// 输入每位债权人对于每个物品的偏好值
	// 并且继续建图，超级源点向每位债权人连边，每位债权人向每种物品连边
	// 第 i 位债权人的编号是 i 
	for(int i = 1 ; i <= n ; ++ i) { 
		add(S , i , NUM_OF_CREDIT , 0) ;
		for(int j = 1 ; j <= m ; ++ j) {
			cin >> x ;
			add(i , n + j , 1 , -x) ;
		}
	}

	auto it = EK(S, T) ;
	cout << it.first << " " << -it.second << endl ;

	for(int i = 1 ; i <= n ; ++ i) {
		cout << "第" << i << "位债权人选择的物品情况:\t" ;
		for(auto& elem : ret[i]) {
			if(elem.second == 0) continue ;
			cout << elem.first << ":" << elem.second << " " ;
		}
		if(ret[i].size() == 0) cout << "不选择" ;
		cout << endl ;
	}
}

int main(){
	ios::sync_with_stdio(false) ; 
    cin.tie(nullptr) ; cout.tie(nullptr) ;
    int t = 1 ; // cin >> t ;
    while( t -- ) solve() ;
	return 0 ;
}