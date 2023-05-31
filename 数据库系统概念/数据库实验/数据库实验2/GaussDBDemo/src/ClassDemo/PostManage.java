package ClassDemo;

import java.sql.*;
import java.util.Scanner;

public class PostManage {
    Connection conn ;
    public PostManage(Connection _conn) {
        conn = _conn ;
    }


    // -------------------------------------------------------------------------------------
    // 增加
    private boolean post_add_helper(  String post_id, // 新增职位
                                            String post_name) throws SQLException{

        Statement sta = conn.createStatement() ;
        String sql ;

        // 插入员工
        sql = String.format("INSERT INTO post values(%s,'%s') ;",
                post_id, post_name) ;
        sta.executeUpdate(sql) ;
        return true ;

    }
    public void post_add() throws SQLException {
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("输入新增职位信息:\n职位编号 | 职位名称") ;
        String s = sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split("\\s") ;
        if(info.length != 2) {
            System.out.println("添加失败！");
            System.out.println("===============================================================================================");
            return ;
        }
        if(post_add_helper(info[0], info[1])) {
            System.out.println("添加成功！");
        } else {
            System.out.println("添加失败！");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 删除
    private boolean post_del_helper(String id) throws SQLException {
        Statement sta = conn.createStatement(); String sql ;
        sql = String.format("DELETE FROM post WHERE post_id = %s", id) ;
        sta.executeUpdate(sql) ;
        return true ;
    }

    public void post_del() throws SQLException {  // 删除职位
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("需要删除的职位编号：");
        String id = sc.nextLine() ;
        if(post_del_helper(id)){
            System.out.println("删除成功!");
        } else {
            System.out.println("删除失败!");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 更新
    private boolean post_update_helper( String post_id, // 更新部门
                                              String post_name) throws SQLException {
        Statement sta ; String sql ;
        sta = conn.createStatement() ;

        sql = String.format("update post set post_name='%s' WHERE post_id=%s;",
                 post_name, post_id) ;
        sta.executeUpdate(sql) ;
        return true ;
    }
    public void post_update() throws SQLException {
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("需要更新的职位编号：");
        String s = sc.nextLine() + " ";
        System.out.println("依次更新后的信息:\n职位名称") ;
        s += sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split("\\s") ;
        if(info.length != 2) {
            System.out.println("更新失败!");
            System.out.println("===============================================================================================");
            return ;
        }
        if(post_update_helper(info[0], info[1])){
            System.out.println("更新成功!");
        } else {
            System.out.println("更新失败!");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 查询
    private boolean post_query_helper(String post_id, // 查询部门
                                            String post_name) throws SQLException {
        Statement sta ; String sql ; ResultSet rs ;
        sta = conn.createStatement() ;
        // 拼接查询条件
        String con = "WHERE " ;
        if(!post_id.equals("*")) {
            con += String.format("AND post.post_id=%s ", post_id) ;
        }
        if(!post_name.equals("*")) {
            con += String.format("AND post.post_name='%s' ", post_name) ;
        }
        // 查询，执行sql语句
        sql = "SELECT post_id,post_name FROM post " ;
        if(!con.equals("WHERE ")) sql += con ;
        rs = sta.executeQuery(sql) ;
        // 打印结果
        System.out.println("-----------------------------------------------------------------------------------------------");
        System.out.println("职位编号 | 职位名称") ;
        System.out.println("-----------------------------------------------------------------------------------------------");
        while(rs.next()) {
            System.out.printf("   %s   | %s \n",
                    rs.getString("post_id"), rs.getString("post_name"));
        }
        System.out.println("-----------------------------------------------------------------------------------------------");
        return true ;
    }
    public void post_query()throws SQLException{
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("依次输入信息(未知请写0,空格作为分隔符，回车结束输入):\n职位编号 | 职位名称") ;
        String s = sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split(" ") ;
        if(info.length != 2) {
            System.out.println("查询失败！");
            System.out.println("===============================================================================================");
            return ;
        }
        for (int i = 0 ; i < info.length ; ++ i) {
            if(info[i].equals("0")) info[i] = "*" ;
        };
        if(post_query_helper(info[0], info[1])){
            System.out.println("查询成功！") ;
        } else {
            System.out.println("查询失败！") ;
        }
        System.out.println("===============================================================================================");
    }

}
