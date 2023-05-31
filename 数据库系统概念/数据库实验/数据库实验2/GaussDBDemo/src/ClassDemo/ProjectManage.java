package ClassDemo;

import java.sql.*;
import java.util.Scanner;

public class ProjectManage {
     Connection conn ;
    public ProjectManage(Connection _conn) {
        conn = _conn ;
    }


    // -------------------------------------------------------------------------------------
    // 新增
    private boolean project_add_helper(   String project_id, // 新增项目
                                                String department_id,
                                                String project_name,
                                                String start_time,
                                                String end_time,
                                                String project_header) throws SQLException {

        Statement sta = conn.createStatement() ;
        String sql ;

        // 插入员工
        sql = String.format("INSERT INTO project values(%s,%s,'%s','%s','%s',%s) ;",
                project_id,department_id, project_name, start_time, end_time,project_header) ;
        sta.executeUpdate(sql) ;
        return true ;

    }
    public void project_add() throws SQLException {
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("输入新增项目信息:\n项目编号 | 所属部门编号 | 项目名称 | 开始时间名称 | 结束时间 | 项目负责人编号") ;
        String s = sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split("\\s") ;
        if(info.length != 6) {
            System.out.println("添加失败！");
            System.out.println("===============================================================================================");
            return ;
        }
        if(project_add_helper(info[0], info[1], info[2], info[3], info[4], info[5])) {
            System.out.println("添加成功！");
        } else {
            System.out.println("添加失败！");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 删除
    private boolean project_del_helper(String id) throws SQLException {
        Statement sta = conn.createStatement(); String sql ;
        sql = String.format("DELETE FROM project WHERE project_id = %s", id) ;
        sta.executeUpdate(sql) ;
        return true ;
    }

    public void project_del() throws SQLException {  // 删除项目
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("需要删除的项目编号：");
        String id = sc.nextLine() ;
        if(project_del_helper(id)){
            System.out.println("删除成功!");
        } else {
            System.out.println("删除失败!");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 更新
    private boolean project_update_helper( String project_id, // 更新项目
                                                 String department_id,
                                                 String project_name,
                                                 String start_time,
                                                 String end_time,
                                                 String project_header) throws SQLException {
        Statement sta ; String sql ;
        sta = conn.createStatement() ;

        sql = String.format("update project set department_id=%s,project_name='%s',start_time='%s',end_time='%s',project_header=%s WHERE project_id=%s;",
                department_id, project_name, start_time, end_time,project_header,project_id) ;
        sta.executeUpdate(sql) ;
        return true ;
    }
    public void project_update() throws SQLException {
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("需要更新的项目编号：");
        String s = sc.nextLine() + " ";
        System.out.println("依次更新后的信息:\n所属部门编号 | 项目名称 | 开始时间名称 | 结束时间 | 项目负责人编号") ;
        s += sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split("\\s") ;
        if(info.length != 6) {
            System.out.println("更新失败!");
            System.out.println("===============================================================================================");
            return ;
        }
        if(project_update_helper(info[0], info[1], info[2], info[3], info[4], info[5])){
            System.out.println("更新成功!");
        } else {
            System.out.println("更新失败!");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 查询
    private boolean project_query_helper(String project_id, // 查询项目
                                               String department_id,
                                               String project_name,
                                               String start_time,
                                               String end_time,
                                               String project_header) throws SQLException {
        Statement sta ; String sql ; ResultSet rs ;
        sta = conn.createStatement() ;
        // 拼接查询条件
        String con = "WHERE " ;
        if(!project_id.equals("*")) {
            con += String.format("AND project.project_id=%s ", project_id) ;
        }
        if(!department_id.equals("*")) {
            con += String.format("AND project.department_id=%s ", department_id) ;
        }
        if(!project_name.equals("*")) {
            con += String.format("AND project.project_name='%s' ", project_name) ;
        }
        if(!start_time.equals("*")) {
            con += String.format("AND project.start_time='%s' ", start_time) ;
        }
        if(!end_time.equals("*")) {
            con += String.format("AND project.end_time='%s' ", end_time) ;
        }
        if(!project_header.equals("*")) {
            con += String.format("AND project.project_header='%s' ", project_header) ;
        }
        // 查询，执行sql语句，三表联查，将对应的id替换成为响应的姓名
        sql = "SELECT project_id,d.department_name as d_name, project_name, start_time, end_time,e.name as e_name \n" +
                "FROM project p\n" +
                "LEFT JOIN department d ON d.department_id=p.department_id\n" +
                "LEFT JOIN employee e\n ON e.id=p.project_header\n" ;
        if(!con.equals("WHERE ")) sql += con ;
        rs = sta.executeQuery(sql) ;
        // 打印结果
        System.out.println("-----------------------------------------------------------------------------------------------");
        System.out.println("项目编号 | 所属部门 | 项目名称 | 开始时间名称 | 结束时间 | 项目负责人") ;
        System.out.println("-----------------------------------------------------------------------------------------------");
        while(rs.next()) {
            System.out.printf("   %s   | %s | %s | %s | %s | %s\n",
                    rs.getString("project_id"), rs.getString("d_name"),
                    rs.getString("project_name"), rs.getString("start_time"),
                    rs.getString("end_time"), rs.getString("e_name"));
        }
        System.out.println("-----------------------------------------------------------------------------------------------");
        return true ;
    }
    public void project_query()throws SQLException{
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("依次输入信息(未知请写0,空格作为分隔符，回车结束输入):\n项目编号 | 所属部门编号 | 项目名称 | 开始时间名称 | 结束时间 | 项目负责人编号") ;
        String s = sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split(" ") ;
        if(info.length != 6) {
            System.out.println("查询失败！");
            System.out.println("===============================================================================================");
            return ;
        }
        for (int i = 0 ; i < info.length ; ++ i) {
            if(info[i].equals("0")) info[i] = "*" ;
        };
        if(project_query_helper(info[0], info[1], info[2], info[3], info[4], info[5])){
            System.out.println("查询成功！") ;
        } else {
            System.out.println("查询失败！") ;
        }
        System.out.println("===============================================================================================");
    }
}
