package ClassDemo;

import java.sql.*;
import java.util.Scanner;

public class SalaryManage {
    Connection conn ;
    public SalaryManage(Connection _conn) {
        conn = _conn ;
    }

    // -------------------------------------------------------------------------------------
    // 新增
    private boolean salary_add_helper(   String salary_id,  // 新增工资条
                                               String basic_salary,
                                               String merit_salary,
                                               String allowance,
                                               String overtime_salary,
                                               String id,
                                               String release_time) throws SQLException{

        Statement sta = conn.createStatement() ;
        String sql ;

        // 插入工资条
        sql = String.format("INSERT INTO salary values(%s,%s,%s,%s,%s,%s,'%s') ;",
                basic_salary, merit_salary,allowance,overtime_salary,salary_id,id,release_time) ;
        sta.executeUpdate(sql) ;
        return true ;

    }
    public void salary_add() throws SQLException {
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("输入新增工资条信息:\n工资条编号 | 基本工资 | 绩效工资 | 补贴 | 加班工资 | 员工编号 | 发放时间") ;
        String s = sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split("\\s") ;
        if(info.length != 7) {
            System.out.println("添加失败！");
            System.out.println("===============================================================================================");
            return ;
        }
        if(salary_add_helper(info[0], info[1], info[2], info[3], info[4], info[5], info[6])) {
            System.out.println("添加成功！");
        } else {
            System.out.println("添加失败！");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 删除
    private boolean salary_del_helper(String id) throws SQLException {
        Statement sta = conn.createStatement(); String sql ;
        sql = String.format("DELETE FROM salary WHERE salary_id = %s", id) ;
        sta.executeUpdate(sql) ;
        return true ;
    }

    public void salary_del() throws SQLException {  // 删除工资信息
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("需要删除的工资条编号：");
        String id = sc.nextLine() ;
        if(salary_del_helper(id)){
            System.out.println("删除成功!");
        } else {
            System.out.println("删除失败!");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 更新
    private boolean salary_update_helper( String salary_id,  // 更新工资条
                                                String basic_salary,
                                                String merit_salary,
                                                String allowance,
                                                String overtime_salary,
                                                String id,
                                                String release_time) throws SQLException {
        Statement sta ; String sql ;
        sta = conn.createStatement() ;
        sql = String.format("update salary set basic_salary=%s,merit_salary=%s,allowance=%s,overtime_salary=%s,id=%s,release_time='%s' WHERE salary_id=%s ;",
                basic_salary,merit_salary,allowance,overtime_salary,id,release_time,salary_id) ;
        sta.executeUpdate(sql) ;
        return true ;
    }
    public void salary_update() throws SQLException {
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("需要更新的工资条编号：");
        String s = sc.nextLine() + " ";
        System.out.println("依次更新后的信息:\n基本工资 | 绩效工资 | 补贴 | 加班工资 | 员工编号 | 发放时间") ;
        s += sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split("\\s") ;
        if(info.length != 7) {
            System.out.println("更新失败!");
            System.out.println("===============================================================================================");
            return ;
        }
        if(salary_update_helper(info[0], info[1], info[2], info[3], info[4], info[5], info[6])){
            System.out.println("更新成功!");
        } else {
            System.out.println("更新失败!");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 查询
    private boolean salary_query_helper(String salary_id,  // 查询工资条
                                              String basic_salary,
                                              String merit_salary,
                                              String allowance,
                                              String overtime_salary,
                                              String id,
                                              String release_time) throws SQLException {
        Statement sta ; String sql ; ResultSet rs ;
        sta = conn.createStatement() ;
        // 拼接查询条件
        String con = "WHERE " ;
        if(!salary_id.equals("*")) {
            con += String.format("AND salary.salary_id=%s ", salary_id) ;
        }
        if(!basic_salary.equals("*")) {
            con += String.format("AND salary.basic_salary=%s ", basic_salary) ;
        }
        if(!merit_salary.equals("*")) {
            con += String.format("AND salary.merit_salary=%s ", merit_salary) ;
        }
        if(!allowance.equals("*")) {
            con += String.format("AND salary.allowance=%s ", allowance) ;
        }
        if(!overtime_salary.equals("*")) {
            con += String.format("AND salary.overtime_salary=%s ", overtime_salary) ;
        }
        if(!id.equals("*")) {
            con += String.format("AND salary.id=%s ", id) ;
        }
        if(!release_time.equals("*")) {
            con += String.format("AND salary.release_time='%s' ", release_time) ;
        }
        // 查询，执行sql语句,多表联查，将员工id替换成员工姓名
        sql = "SELECT salary_id,basic_salary,merit_salary, allowance,overtime_salary,e.name as name,release_time \n" +
                "FROM salary s\n " +
                "LEFT JOIN employee e ON s.id = e.id";
        if(!con.equals("WHERE ")) sql += con ;
        rs = sta.executeQuery(sql) ;
        // 打印结果
        System.out.println("-----------------------------------------------------------------------------------------------");
        System.out.println("工资条编号 | 基本工资 | 绩效工资 | 补贴 | 加班工资 | 员工姓名 | 发放时间") ;
        System.out.println("-----------------------------------------------------------------------------------------------");
        while(rs.next()) {
            System.out.printf("   %s   | %s | %s | %s | %s | %s | %s\n",
                    rs.getString("salary_id"), rs.getString("basic_salary"),
                    rs.getString("merit_salary"), rs.getString("allowance"),
                    rs.getString("overtime_salary"), rs.getString("name"),
                    rs.getString("release_time"));
        }
        System.out.println("-----------------------------------------------------------------------------------------------");
        return true ;
    }
    public void salary_query()throws SQLException{
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("依次输入信息(未知请写0,空格作为分隔符，回车结束输入):\n工资条编号 | 基本工资 | 绩效工资 | 补贴 | 加班工资 | 员工编号 | 发放时间") ;
        String s = sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split(" ") ;
        if(info.length != 7) {
            System.out.println("查询失败！");
            System.out.println("===============================================================================================");
            return ;
        }
        for (int i = 0 ; i < info.length ; ++ i) {
            if(info[i].equals("0")) info[i] = "*" ;
        };
        if(salary_query_helper(info[0], info[1], info[2], info[3], info[4], info[5], info[6])) {
            System.out.println("查询成功！") ;
        } else {
            System.out.println("查询失败！") ;
        }
        System.out.println("===============================================================================================");
    }
}
