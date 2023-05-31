package ClassDemo;

import java.sql.*;
import java.util.Scanner;

public class EmployManage {
    Connection conn ;
    public EmployManage(Connection _conn) {
        conn = _conn ;
    }

    // -------------------------------------------------------------------------------------
    // 新增
    private boolean employee_add_helper(   String id,  // 新增员工
                                           String post,
                                           String department,
                                           String tel,
                                           String gender,
                                           String name,
                                           String entry_time,
                                           String id_card,
                                           String year) throws SQLException{
        // 查询post的id
        Statement sta = conn.createStatement() ;
        String sql = String.format("SELECT post_id FROM post WHERE post_name='%s'", post) ;
        ResultSet rs = sta.executeQuery(sql) ;
        int post_id ;
        if(rs.next()) post_id = rs.getInt("post_id") ;
        else return false ;

        // 查询department的id
        sql = String.format("SELECT department_id FROM department WHERE department_name='%s'", department) ;
        rs = sta.executeQuery(sql) ;
        int department_id ;
        if(rs.next()) department_id = rs.getInt("department_id") ;
        else return false ;

        // 插入员工
        sql = String.format("INSERT INTO employee values(%s,%d,%d,'%s','%s','%s','%s','%s',%s) ;",
                id, post_id, department_id,tel,gender,name,entry_time,id_card,year ) ;
        sta.executeUpdate(sql) ;
        return true ;
    }
    public void employee_add() throws SQLException {
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("输入新增员工信息:\n员工编号 | 职位 | 部门 | 电话 | 性别 | 姓名 | 入职时间 | 身份证号 | 出生年") ;
        String s = sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split("\\s") ;
        if(info.length != 9) {
            System.out.println("添加失败！");
            System.out.println("===============================================================================================");
            return ;
        }
        if(employee_add_helper(info[0], info[1], info[2], info[3], info[4], info[5], info[6], info[7], info[8])) {
            System.out.println("添加成功！");
        } else {
            System.out.println("添加失败！");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 删除
    private boolean employee_del_helper(String id) throws SQLException {
        Statement sta = conn.createStatement(); String sql ;
        sql = String.format("DELETE FROM employee WHERE employee.id = %s", id) ;
        sta.executeUpdate(sql) ;
        return true ;
    }
    
    public void employee_del() throws SQLException {  // 删除员工
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("需要删除的员工编号：");
        String id = sc.nextLine() ;
        if(employee_del_helper(id)){
            System.out.println("删除成功!");
        } else {
            System.out.println("删除失败!");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 更新
    public boolean employee_update_helper(    String id,   // 更新员工信息
                                              String post,
                                              String department,
                                              String tel,
                                              String gender,
                                              String name,
                                              String entry_time,
                                              String id_card,
                                              String year) throws SQLException {
        Statement sta ; String sql ; ResultSet rs ;
        sta = conn.createStatement() ; int post_id = 0, department_id = 0 ;
        // 查询post的id
        if(!post.equals("*")) {
            sql = String.format("SELECT post_id FROM post WHERE post_name='%s'", post) ;
            rs = sta.executeQuery(sql) ;
            if(rs.next()) post_id = rs.getInt("post_id") ;
            else return false ;
        }
        // 查询department的id
        if(!department.equals("*")) {
            sql = String.format("SELECT department_id FROM department WHERE department_name='%s'", department) ;
            rs = sta.executeQuery(sql) ;
            if(rs.next()) department_id = rs.getInt("department_id") ;
            else return false ;
        }

        sql = String.format("update employee set post_id=%d,department_id=%d,tel='%s',gender='%s',name='%s',entry_time='%s',id_card='%s',year=%s WHERE id=%s;",
                post_id, department_id, tel, gender, name, entry_time, id_card, year, id) ;
        sta.executeUpdate(sql) ;
        return true ;
    }
    public void employee_update() throws SQLException {
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("需要更新的员工编号：");
        String s = sc.nextLine() + " ";
        System.out.println("依次更新后的信息:\n职位 | 部门 | 电话 | 性别 | 姓名 | 入职时间 | 身份证号 | 出生年") ;
        s += sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split("\\s") ;
        if(info.length != 9) {
            System.out.println("更新失败!");
            System.out.println("===============================================================================================");
            return ;
        }
        if(employee_update_helper(info[0], info[1], info[2], info[3], info[4], info[5], info[6], info[7], info[8])){
            System.out.println("更新成功!");
        } else {
            System.out.println("更新失败!");
        }
        System.out.println("===============================================================================================");
    }

    // -------------------------------------------------------------------------------------
    // 查询
    private boolean employee_query_helper(  String id,   // 查询员工信息
                                            String post,
                                            String department,
                                            String tel,
                                            String gender,
                                            String name,
                                            String entry_time,
                                            String id_card,
                                            String year) throws SQLException {
        Statement sta ; String sql ; ResultSet rs ;
        sta = conn.createStatement() ;
        // 查询post的id
        if(!post.equals("*")) {
            sql = String.format("SELECT post_id FROM post WHERE post_name='%s'", post) ;
            rs = sta.executeQuery(sql) ;
            if(rs.next()) post = rs.getString("post_id") ;
            else return false ;
        }
        // 查询department的id
        if(!department.equals("*")) {
            sql = String.format("SELECT department_id FROM department WHERE department_name='%s'", department) ;
            rs = sta.executeQuery(sql) ;
            if(rs.next()) department = rs.getString("department_id") ;
            else return false ;
        }
        // 拼接查询条件
        String con = "WHERE employee.post_id = post.post_id AND employee.department_id = department.department_id " ;
        if(!id.equals("*")) {
            con += String.format("AND employee.id=%s ", id) ;
        }
        if(!post.equals("*")) {
            con += String.format("AND employee.post_id='%s' ", post) ;
        }
        if(!department.equals("*")) {
            con += String.format("AND employee.department_id='%s' ", department) ;
        }
        if(!tel.equals("*")) {
            con += String.format("AND employee.tel='%s' ", tel) ;
        }
        if(!gender.equals("*")) {
            con += String.format("AND employee.gender='%s' ", gender) ;
        }
        if(!name.equals("*")) {
            con += String.format("AND employee.name='%s' ", name) ;
        }
        if(!entry_time.equals("*")) {
            con += String.format("AND employee.entry_time='%s' ", entry_time) ;
        }
        if(!id_card.equals("*")) {
            con += String.format("AND employee.id_card='%s' ", id_card) ;
        }
        if(!year.equals("*")) {
            con += String.format("AND employee.year=%s ", year) ;
        }
        // 查询，执行sql语句
        sql = "SELECT id,post_name, department_name,tel,gender,name,entry_time,id_card,year FROM employee, post,department " + con ;
        rs = sta.executeQuery(sql) ;
        // 打印结果
        System.out.println("-----------------------------------------------------------------------------------------------");
        System.out.println("员工编号 | 职位 | 部门 | 电话 | 性别 | 姓名 | 入职时间 | 身份证号 | 出生年") ;
        System.out.println("-----------------------------------------------------------------------------------------------");
        while(rs.next()) {
            System.out.printf("   %s   | %s | %s | %s | %s | %s | %s | %s | %s\n",
                    rs.getString("id"), rs.getString("post_name"), rs.getString("department_name"), rs.getString("tel"),
                    rs.getString("gender"), rs.getString("name"), rs.getString("entry_time"), rs.getString("id_card"),
                    rs.getString("year"));
        }
        System.out.println("-----------------------------------------------------------------------------------------------");
        return true ;
    }
    public void employee_query()throws SQLException{
        Scanner sc = new Scanner(System.in) ;
        System.out.println("===============================================================================================");
        System.out.println("依次输入信息(未知请写0,空格作为分隔符，回车结束输入):\n员工编号 | 职业 | 部门 | 性别 | 姓名 ") ;
        String s = sc.nextLine() ;
        // 处理输入参数
        String[] info = s.split(" ") ;
        if(info.length != 5) {
            System.out.println("查询失败！");
            System.out.println("===============================================================================================");
            return ;
        }
        for (int i = 0 ; i < info.length ; ++ i) {
            if(info[i].equals("0")) info[i] = "*" ;
        };
        if(employee_query_helper(info[0], info[1], info[2], "*", info[3], info[4], "*", "*", "*")) {
            System.out.println("查询成功！") ;
        } else {
            System.out.println("查询失败！") ;
        }
        System.out.println("===============================================================================================");
    }

}
