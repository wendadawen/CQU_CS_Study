package ClassDemo;

import java.sql.*;
import java.util.Scanner;

public class DepartmentManage {
    Connection conn ;
    public DepartmentManage(Connection _conn) {
        conn = _conn ;
    }

    // -------------------------------------------------------------------------------------
    // 新增
    private boolean department_add_helper(String department_id, // 新增部门
                                                String dep_department_id,
                                                String department_header_id,
                                                String department_name) throws SQLException{

        Statement sta = conn.createStatement() ;
        String sql ;

        // 插入员工
        sql = String.format("INSERT INTO department values(%s,%s,%s,'%s') ;",
                department_id, dep_department_id, department_header_id, department_name) ;
        sta.executeUpdate(sql) ;
        return true ;

    }
    public void department_add() throws SQLException {
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("输入新增部门信息:\n部门编号 | 上级部门编号 | 部门负责人编号 | 部门名称") ;
        String s = sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split("\\s") ;
        if(info.length != 4) {
            System.out.println("添加失败！");
            System.out.println("===============================================================================================");
            return ;
        }
        if(department_add_helper(info[0], info[1], info[2], info[3])) {
            System.out.println("添加成功！");
        } else {
            System.out.println("添加失败！");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 删除
    private boolean department_del_helper(String id) throws SQLException {
        Statement sta = conn.createStatement(); String sql ;
        sql = String.format("DELETE FROM department WHERE department_id = %s", id) ;
        sta.executeUpdate(sql) ;
        return true ;
    }

    public void department_del() throws SQLException {  // 删除部门
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("需要删除的部门编号：");
        String id = sc.nextLine() ;
        if(department_del_helper(id)){
            System.out.println("删除成功!");
        } else {
            System.out.println("删除失败!");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 更新
    private boolean department_update_helper( String department_id, // 更新部门
                                                    String dep_department_id,
                                                    String department_header_id,
                                                    String department_name) throws SQLException {
        Statement sta ; String sql ;
        sta = conn.createStatement() ;

        sql = String.format("update department set dep_department_id=%s,department_header=%s,department_name='%s' WHERE department_id=%s;",
                dep_department_id, department_header_id, department_name, department_id) ;
        sta.executeUpdate(sql) ;
        return true ;
    }
    public void department_update() throws SQLException {
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("需要更新的部门编号：");
        String s = sc.nextLine() + " ";
        System.out.println("依次更新后的信息:\n上级部门编号 | 部门负责人编号 | 部门名称") ;
        s += sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split("\\s") ;
        if(info.length != 4) {
            System.out.println("更新失败!");
            System.out.println("===============================================================================================");
            return ;
        }
        if(department_update_helper(info[0], info[1], info[2], info[3])){
            System.out.println("更新成功!");
        } else {
            System.out.println("更新失败!");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 查询
    private boolean department_query_helper(String department_id, // 查询部门
                                                  String dep_department_id,
                                                  String department_header_id,
                                                  String department_name) throws SQLException {
        Statement sta ; String sql ; ResultSet rs ;
        sta = conn.createStatement() ;
        // 拼接查询条件
        String con = "WHERE " ;
        if(!department_id.equals("*")) {
            con += String.format("AND department.department_id=%s ", department_id) ;
        }
        if(!dep_department_id.equals("*")) {
            con += String.format("AND department.dep_department_id=%s ", dep_department_id) ;
        }
        if(!department_header_id.equals("*")) {
            con += String.format("AND department.department_header=%s ", department_header_id) ;
        }
        if(!department_name.equals("*")) {
            con += String.format("AND department.department_name='%s' ", department_name) ;
        }
        // 查询，执行sql语句,三表联查,将对应的id替换成为相应的姓名
        sql = "SELECT d.department_id, d.department_name, d2.department_name AS dep_department_name, e.name AS department_header_name\n" +
                "FROM department d\n" +
                "LEFT JOIN department d2 ON d.dep_department_id = d2.department_id\n" +
                "LEFT JOIN employee e ON d.department_header = e.id\n" ;
        if(!con.equals("WHERE ")) sql += con ;
        rs = sta.executeQuery(sql) ;
        // 打印结果
        System.out.println("-----------------------------------------------------------------------------------------------");
        System.out.println("部门编号 | 部门名称 | 上级部门 | 部门负责人") ;
        System.out.println("-----------------------------------------------------------------------------------------------");
        while(rs.next()) {
            System.out.printf("   %s   | %s | %s | %s\n",
                    rs.getString("department_id"), rs.getString("department_name"),
                    rs.getString("dep_department_name"), rs.getString("department_header_name"));
        }
        System.out.println("-----------------------------------------------------------------------------------------------");
        return true ;
    }
    public void department_query()throws SQLException{
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("依次输入信息(未知请写0,空格作为分隔符，回车结束输入):\n部门编号 | 上级部门编号 | 部门负责人编号 | 部门名称") ;
        String s = sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split(" ") ;
        if(info.length != 4) {
            System.out.println("查询失败！");
            System.out.println("===============================================================================================");
            return ;
        }
        for (int i = 0 ; i < info.length ; ++ i) {
            if(info[i].equals("0")) info[i] = "*" ;
        };
        if(department_query_helper(info[0], info[1], info[2], info[3])){
            System.out.println("查询成功！") ;
        } else {
            System.out.println("查询失败！") ;
        }
        System.out.println("===============================================================================================");
    }

}
