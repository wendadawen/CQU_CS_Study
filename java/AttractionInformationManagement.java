import java.io.*;
import java.util.*;

public class AttractionInformationManagement {
    // 创建存储景点的HashMap
    private static HashMap<Integer, spot> spots = new HashMap<>() ;
    // 创建储存路径的数组
    private static ArrayList<path> paths = new ArrayList<>() ;
    // 景区编号的最大值
    private static final int N = 1001 ;
    static final int inf = 0x3f3f3f3f; // 最大值
    // 通过邻接表创建图
    private static ArrayList<ArrayList<edge>> graph= new ArrayList<>(N) ;

    public static void main(String[] args) {
        init() ;
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("****************************");
            System.out.println("欢迎来到旅游导游程序！");
            System.out.print  ("1. 增加景点   ");
            System.out.println("2. 增加路径");
            System.out.print  ("3. 删除景点   ");
            System.out.println("4. 删除路径");
            System.out.print  ("5. 更新景点   ");
            System.out.println("6. 更新路径");
            System.out.println("7. 查询景点的信息");
            System.out.println("8. 查询任意两个景点间的最短路径");
            System.out.println("9. 查询图中任意两个景点间的所有路径");
            System.out.println("10.查询多个景点的最短游览路径");
            System.out.println("11. 退出系统");
            System.out.print("请选择操作：");
            int choice = scanner.nextInt();
            System.out.println("****************************");
            switch (choice) {
                case 1:
                    System.out.println("您选择了增加景点。");
                    // TODO: 实现增加景点的代码
                    add_spot();
                    break;
                case 2:
                    System.out.println("您选择了增加路径。");
                    // TODO: 实现增加路径的代码
                    add_path();
                    break;
                case 3:
                    System.out.println("您选择了删除景点。");
                    // TODO: 实现删除景点的代码
                    delete_spot();
                    break;
                case 4:
                    System.out.println("您选择了删除路径。");
                    // TODO: 实现删除路径的代码
                    delete_path();
                    break;
                case 5:
                    System.out.println("您选择了更新景点。");
                    // TODO: 实现更新景点的代码
                    update_spot();
                    break;
                case 6:
                    System.out.println("您选择了更新路径。");
                    // TODO: 实现更新路径的代码
                    update_path();
                    break;
                case 7:
                    System.out.println("您选择了查询景点的信息。");
                    // TODO: 实现查询景点信息的代码
                    query_spot();
                    break;
                case 8:
                    System.out.println("您选择了查询任意两个景点间的最短路径。");
                    // TODO: 实现查询最短路径的代码
                    query_two_shortest_path();
                    break;
                case 9:
                    System.out.println("您选择了查询图中任意两个景点间的所有路径。");
                    // TODO: 实现查询所有路径的代码
                    query_two_all_path();
                    break;
                case 10:
                    System.out.println("您选择了查询多个景点的最短游览路径。");
                    // TODO: 实现查询最短游览路径的代码
                    query_multi_shortest_path();
                    break;
                case 11:
                    System.out.println("感谢使用。");
                    load_to_file() ;
                    return;
                default:
                    System.out.println("无效的选择，请重新选择。");
                    break;
            }

        }
    }

    // 初始化，从文件里面读取信息
    public static void init(){
        // 从文件读入景点信息
        try (BufferedReader reader = new BufferedReader(new FileReader("spot.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",") ;
                spot it = new spot(Integer.parseInt(parts[0]),
                        parts[1],
                        parts[2]) ;
                spots.put(Integer.parseInt(parts[0]), it) ;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 从文件读入路径信息
        try (BufferedReader reader = new BufferedReader(new FileReader("path.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(" ") ;
                path it = new path(Integer.parseInt(parts[0]),
                        Integer.parseInt(parts[1]),
                        Integer.parseInt(parts[2])) ;
                paths.add(it) ;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 建图
        create_graph();
    }

    // 退出系统的时候把数据加载进入文件
    private static void load_to_file() {
        // 写入景点
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("spot.txt"))) {
            for (Map.Entry<Integer, spot> entry : spots.entrySet()) {
                spot it = entry.getValue();
                String data = it.getSpot_num() + "," + it.getSpot_name() + "," + it.getSpot_info() ;
                writer.write(data);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 写入路径
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("path.txt"))) {
            for (path it : paths) {
                String data = it.getStart() + " " + it.getEnd() + " " + it.getDis() ;
                writer.write(data);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 主要从文件里面读取信息，初始化图
    public static void create_graph(){
        graph = new ArrayList<>(N) ;
        for (int i = 0; i < N; i++) {
            graph.add(new ArrayList<>());  // 添加一个空列表，表示 i 号顶点的邻接表
        }
        for (path path : paths) {
            int u = path.getStart();
            int v = path.getEnd();
            int d = path.getDis();
            graph.get(u).add(new edge(v, d)) ;  // 创建邻接表,建立双向边
            graph.get(v).add(new edge(u, d)) ;
        }
    }

    // 增加景点的方法，增加一个景点，放进文件里面
    public static void add_spot(){
        // 输入信息----------------------------------------------------------------------------------------
        Scanner sc = new Scanner(System.in) ;
        System.out.println("请输入你要添加景点的基本信息：");
        // 输入景点编号
        System.out.print("景点编号：");
        int spot_num = sc.nextInt() ;  // 输入一个数字编号
        // 输入景点编号
        System.out.print("景点名称：");
        String spot_name = sc.next() ;  // 输入一个字符串名称，不能带有空格
        // 输入景点编号
        sc.nextLine() ;  // 不用管这行代码，只是为了吸收缓冲区残留的换行符，以免对后续输入造成影响
        System.out.print("景点信息：");
        String spot_info = sc.nextLine();  // 输入一行信息，可以带有空格

        // 写入HashMap
        if(spots.containsKey(spot_num)) {
            System.out.println("该景点编号已经存在！");
        }else {
            spots.put(spot_num, new spot(spot_num, spot_name, spot_info)) ;
        }
        // 更新图
        create_graph();
    }

    // 增加景点之间的路径
    public static void add_path(){
        // 输入信息----------------------------------------------------------------------------------------
        Scanner sc = new Scanner(System.in) ;
        System.out.print("请输入要增加路径起点的编号,终点的编号和之间的距离：");
        int start = sc.nextInt() ;
        int end   = sc.nextInt() ;
        int dis   = sc.nextInt() ;
        // ----------------------------------------------------------------------------------------
        paths.add(new path(start, end, dis)) ;
        // 更新图
        create_graph();
    }

    // 删除景点的方法，删除文件里面的一个景点
    public static void delete_spot(){
        // 输入信息----------------------------------------------------------------------------------------
        Scanner sc = new Scanner(System.in) ;
        System.out.print("请输入你要删除景点的编号：");
        int spot_num = sc.nextInt() ;
        // 删除景点----------------------------------------------------------------------------------------
        spots.remove(spot_num) ;

        // 不仅要删除景点，还要删除含有该景点的路径----------------------------------------------------------------
        ArrayList<Integer> delete_index = new ArrayList<>() ;
        for (int i = 0; i < paths.size(); i++) {
            if(paths.get(i).getStart() == spot_num || paths.get(i).getEnd() == spot_num) {
                delete_index.add(i) ;
            }
        }
        for (int deleteIndex : delete_index) {
            paths.remove(deleteIndex);
        }
        // 更新图
        create_graph();
    }

    // 删除景点之间的路径，删除文件里面的一个路径
    public static void delete_path(){
        // 输入信息----------------------------------------------------------------------------------------
        Scanner sc = new Scanner(System.in) ;
        System.out.print("请输入要删除的路径起点的编号,终点的编号和之间的距离：");
        int start = sc.nextInt() ;
        int end   = sc.nextInt() ;
        int dis   = sc.nextInt() ;
        // ----------------------------------------------------------------------------------------
        ArrayList<Integer> delete_index = new ArrayList<>() ;
        for (int i = 0; i < paths.size(); i++) {
            if(paths.get(i).getStart() == start
                    && paths.get(i).getEnd() == end
                    && paths.get(i).getDis() == dis) {
                delete_index.add(i) ;
            }
        }
        for (int deleteIndex : delete_index) {
            paths.remove(deleteIndex);
        }
        // 更新图
        create_graph();
    }

    // 修改景点的方法
    public static void update_spot(){
        // 输入信息----------------------------------------------------------------------------------------
        Scanner sc = new Scanner(System.in) ;
        System.out.print("请输入要更新景点的编号：");
        int spot_num = sc.nextInt() ;
        System.out.print("请输入修改后的景点名称：") ;
        String spot_name = sc.next() ;
        sc.nextLine() ;
        System.out.print("请输入修改后的景点信息：") ;
        String spot_info = sc.nextLine() ;

        // 处理信息
        spots.remove(spot_num) ;
        spots.put(spot_num, new spot(spot_num, spot_name, spot_info)) ;
        // 更新图
        create_graph();
    }

    // 修改景点之间的路径
    public static void update_path(){
        // 输入信息----------------------------------------------------------------------------------------
        Scanner sc = new Scanner(System.in) ;
        System.out.print("请输入要更新的路径起点的编号,终点的编号和之间的距离：");
        int start = sc.nextInt() ;
        int end   = sc.nextInt() ;
        int dis   = sc.nextInt() ;
        System.out.print("请输入修改后的距离：");
        int modify_dis = sc.nextInt() ;
        // 处理信息
        for (int i = 0; i < paths.size(); i++) {
            if(paths.get(i).getStart() == start
                    && paths.get(i).getEnd() == end
                    && paths.get(i).getDis() == dis) {
                paths.remove(i) ;
                paths.add(new path(start, end, modify_dis)) ;
                break ;
            }
        }
        // 更新图
        create_graph();
    }

    // 查询景点的信息，读取文件，查询信息。
    public static void query_spot(){
        // 输入信息----------------------------------------------------------------------------------------
        Scanner sc = new Scanner(System.in) ;
        System.out.print("请输入要查询的景点编号：");
        int spot_num = sc.nextInt() ;
        // 处理信息
        System.out.println(spots.get(spot_num));
    }

    // 查询任意两个景点间的最短路径，dijkstra算法
    public static void query_two_shortest_path(){
        Scanner sc = new Scanner(System.in) ;
        System.out.print("请输入起点和终点的编号：");
        int start = sc.nextInt() ;
        int end   = sc.nextInt() ;
        int[] dis = new int[N];
        int[] pre = new int[N];
        boolean[] vis = new boolean[N];
        Arrays.fill(dis, inf);
        dis[start] = 0; pre[start] = -1 ;
        PriorityQueue<node> q = new PriorityQueue<>();
        q.offer(new node(dis[start], start));
        while (!q.isEmpty()) {
            int u = q.poll().pos;
            if (vis[u]) continue;
            vis[u] = true;
            for (edge e : graph.get(u)) {
                int v = e.end;
                int w = e.dis;
                if (dis[v] > dis[u] + w) {
                    dis[v] = dis[u] + w;
                    pre[v] = u ;
                    q.offer(new node(dis[v], v));
                }
            }
        }
        if(dis[end] == inf) {
            System.out.println("两景点之间不可相互到达！");
        } else {
            System.out.println("两景点之间的最短距离是：" + dis[end]);
            ArrayList<Integer> arr = new ArrayList<>() ;
            int t = end ;
            while(t != -1) {
                arr.add(t) ;
                t = pre[t] ;
            }
            System.out.print("最短路径：" + start);
            for(int i = arr.size()-2 ; i >= 0 ; -- i) {
                System.out.print("->"+ arr.get(i));
            }
            System.out.println();
        }
    }

    // 查询图中任意两个景点间的所有路径，深度搜索
    public static void query_two_all_path(){
        Scanner sc = new Scanner(System.in) ;
        System.out.print("请输入起点和终点的编号：");
        int start = sc.nextInt() ;
        int end   = sc.nextInt() ;
        class helper{
            ArrayList<Integer> path = new ArrayList<>() ;
            int path_num = 0 ;
            boolean[] vis = new boolean[N] ;
            public void dfs(int u, int end) {
                if(u == end) {
                    path_num ++ ;
                    System.out.print(start);
                    for(int i = 1 ; i < path.size() ; ++ i) {
                        System.out.print("->"+ path.get(i));
                    }
                    System.out.println();
                    return ;
                }
                for(edge e: graph.get(u)) {
                    int v = e.end ;
                    if(vis[v]) continue ;
                    path.add(v) ;
                    vis[v] = true ;
                    dfs(v, end) ;
                    vis[v] = false ;
                    path.remove(path.size()-1) ;
                }
            }
        }
        helper h = new helper() ;
        h.vis[start] = true ; h.path.add(start) ;
        h.dfs(start, end) ;
        System.out.println("路径总数：" + h.path_num);
    }

    // 查询多个景点的最短游览路径，TSP问题，而TSP问题属于NP难问题。
    public static void query_multi_shortest_path(){
        Scanner sc = new Scanner(System.in) ;
        System.out.print("请输入景点的数量n：");
        int n = sc.nextInt() ;
        HashMap<Integer, Integer> mp = new HashMap<>() ;
        ArrayList<Integer> arr = new ArrayList<>() ;
        System.out.print("请输入n个景点编号：");
        for(int i = 0 ; i < n ; ++ i) {
            int x = sc.nextInt() ;
            mp.put(x, 0) ; arr.add(x) ;
        }
        class helper{
            ArrayList<Integer> path = new ArrayList<>() ;
            ArrayList<Integer> ret = new ArrayList<>() ;
            int Min_dis = inf ; int temp = 0 ;
            boolean[] vis = new boolean[N] ;
            public void dfs(int u) {
                if(mp.size() == 0) {
                    if(Min_dis >= temp) {
                        Min_dis = temp ;
                        ret = new ArrayList<>(path);
                    }
                    return ;
                }
                for(edge e: graph.get(u)) {
                    int v = e.end ;
                    if(vis[v]) continue ;
                    temp += e.dis ;
                    boolean tag = false ;
                    if(mp.containsKey(v)) {
                        mp.remove(v) ;
                        tag = true ;
                    }
                    path.add(v) ;vis[v] = true ;
                    dfs(v) ;
                    vis[v] = false ;path.remove(path.size()-1) ;
                    temp -= e.dis ;if(tag) mp.put(v, 0) ;
                }
            }
        }
        helper h = new helper() ;
        for(int x: arr) {
            h.vis[x] = true ; h.path.add(x) ;
            mp.remove(x) ; h.dfs(x) ;
            h.vis[x] = false ; h.path.remove(h.path.size()-1) ;
            mp.put(x, 0) ;
        }
        if(h.Min_dis >= inf) {
            System.out.println("不存在路径！");
        } else {
            System.out.println("最短距离是：" + h.Min_dis);
            System.out.print  ("最短路径是：");
            System.out.print(h.ret.get(0));
            for(int i = 1 ; i < h.ret.size() ; ++ i) {
                System.out.print("->"+ h.ret.get(i));
            }
            System.out.println();
        }
    }
}

// 景点的类
class spot{
    private int    spot_num  ;  // 景点编号
    private String spot_name ;  // 景点名称
    private String spot_info ;  // 景点信息

    public spot(int spot_num, String spot_name, String spot_info) {
        this.spot_num = spot_num;
        this.spot_name = spot_name;
        this.spot_info = spot_info;
    }

    @Override
    public String toString() {
        return "spot{" +
                "spot_num=" + spot_num +
                ", spot_name='" + spot_name + '\'' +
                ", spot_info='" + spot_info + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        spot spot = (spot) o;
        return spot_num == spot.spot_num &&
                Objects.equals(spot_name, spot.spot_name) &&
                Objects.equals(spot_info, spot.spot_info);
    }

    @Override
    public int hashCode() {
        return Objects.hash(spot_num, spot_name, spot_info);
    }

    public int getSpot_num() {
        return spot_num;
    }

    public void setSpot_num(int spot_num) {
        this.spot_num = spot_num;
    }

    public String getSpot_name() {
        return spot_name;
    }

    public void setSpot_name(String spot_name) {
        this.spot_name = spot_name;
    }

    public String getSpot_info() {
        return spot_info;
    }

    public void setSpot_info(String spot_info) {
        this.spot_info = spot_info;
    }
}

// 路径类
class path{
    private int start ;  // 起始景点的编号
    private int end   ;  // 结束景点的编号
    private int dis   ;  // 两个景点之间的距离

    public path(int start, int end, int dis) {
        this.start = start;
        this.end = end;
        this.dis = dis;
    }


    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    public int getDis() {
        return dis;
    }

    public void setDis(int dis) {
        this.dis = dis;
    }
}

// 图的边，辅助图的建立的class
class edge{
    public int end ;
    public int dis ;

    public edge(int end, int dis) {
        this.end = end;
        this.dis = dis;
    }
}

// 用与dijkstra算法的辅助class，重载运算符
class node implements Comparable<node> {
    int dis, pos;

    public node(int dis, int pos) {
        this.dis = dis;
        this.pos = pos;
    }

    public int compareTo(node x) {
        return Integer.compare(dis, x.dis);
    }
}
