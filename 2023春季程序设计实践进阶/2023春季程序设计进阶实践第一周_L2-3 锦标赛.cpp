#include <bits/stdc++.h>
using namespace std;
 
 // 借鉴：https://blog.csdn.net/m0_63938020/article/details/130564609
const int N = 2e6 + 1 ;
struct node {
    int win, lose;
} tree[N] ;
int max_lose[N] ;

int k, n ;
bool flag = true;
 
int lc(int x) {
    return x << 1 ;
}
int rc(int x) {
    return x << 1 | 1 ;
}
int getid(int i, int j) { // 第i轮第j次
    return (1 << (k - i)) + j - 1 ;
}

void solve(int i) {
    for(int j = 1 ; j <= (1 << (k - i)) ; ++ j) {
        int root = getid(i, j) ;
        if(tree[root].lose > tree[root].win) {
            flag = false ;
            return ;
        }
        if(i != 1) {
            int lchild = lc(root) ;
            int rchild = rc(root) ;
            if(tree[root].lose >= max_lose[lchild]) {
                tree[lchild].win = tree[root].lose ;
                tree[rchild].win = tree[root].win ;
            } else {
                tree[lchild].win = tree[root].win ;
                tree[rchild].win = tree[root].lose ;
            }
        }
    }
}
 
int main() {
    cin >> k;
    for (int i = 1; i <= k; ++ i) {
        for(int j = 1 ; j <= (1 << (k - i)) ; ++ j) {
            cin >> tree[getid(i,j)].lose;
        }
    }
    cin >> tree[1].win;

    for (int i = 1; i <= k; ++ i) {
        if(i == 1) {
            for(int j = 1 ; j <= (1 << (k - i)) ; ++ j) {
                max_lose[getid(i, j)] = tree[getid(i, j)].lose ;
            }
        }
        else for(int j = 1 ; j <= (1 << (k - i)) ; ++ j) {
            max_lose[getid(i, j)] = max(max_lose[getid(i-1, 2*j - 1)], max_lose[getid(i-1, 2*j)]) ;
            max_lose[getid(i, j)] = max(max_lose[getid(i, j)], tree[getid(i, j)].lose) ;
        }

    }

    for(int i = k ; i >= 1 ; -- i) {
        solve(i) ;
    }
 
    if (!flag) cout << "No Solution";
    else {
        int start = getid(1, 1) ; 
        int end   = getid(1, 1 << (k-1)) ;
        for(int i = start ; i <= end ; ++ i) {
            if(i != end) cout << tree[i].win << " " << tree[i].lose << " " ;
            else cout << tree[i].win << " " << tree[i].lose << endl ;
        }
    }
 
    return 0;
}