package FunctionDemo;

import ClassDemo.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;

public class EmployeeManagementSystem {
    static final String JDBC_DRIVER = "com.huawei.opengauss.jdbc.Driver";
    static final String DB_URL = "jdbc:opengauss://110.41.126.115:8000/CQU_DB2021?ApplicationName=app1";
    // 数据库的用户名与密码
    static final String USER = "db_user2021_24";
    static final String PASSWORD = "db_user@123";
    static Connection conn ;
    static ProjectManage projectmanage ;
    static DepartmentManage departmentmanage ;
    static EmployManage employeemanage ;
    static PostManage postmanage ;
    static SalaryManage salarymanage ;
    static{
        try {
            Class.forName(JDBC_DRIVER) ;
            conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        projectmanage = new ProjectManage(conn);
        departmentmanage = new DepartmentManage(conn) ;
        employeemanage = new EmployManage(conn) ;
        postmanage = new PostManage(conn) ;
        salarymanage = new SalaryManage(conn) ;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int choice;

        do {
            System.out.println("********************************************************************");
            System.out.println("欢迎来到企业员工管理系统！");
            System.out.println("1、员工管理");
            System.out.println("2、部门管理");
            System.out.println("3、职位管理");
            System.out.println("4、工资管理");
            System.out.println("5、项目管理");
            System.out.println("6、退出系统");
            System.out.println("********************************************************************");
            System.out.print("请选择操作：");
            choice = scanner.nextInt();
            System.out.println("") ;

            switch (choice) {
                case 1:
                    try {
                        employeeManagement();
                    } catch (SQLException throwables) {
                        System.out.println("操作错误！");
                    }
                    break;
                case 2:
                    try {
                        departmentManagement();
                    } catch (SQLException throwables) {
                        System.out.println("操作错误！");
                    }
                    break;
                case 3:
                    try {
                        positionManagement();
                    } catch (SQLException throwables) {
                        System.out.println("操作错误！");
                    }
                    break;
                case 4:
                    try {
                        salaryManagement();
                    } catch (SQLException throwables) {
                        System.out.println("操作错误！");
                    }
                    break;
                case 5:
                    try {
                        projectManagement();
                    } catch (SQLException throwables) {
                        System.out.println("操作错误！");
                    }
                    break;
                case 6:
                    System.out.println("感谢使用企业员工管理系统，再见！");
                    break;
                default:
                    System.out.println("请输入正确的操作编号！");
                    break;
            }
        } while (choice != 6);
    }

    private static void employeeManagement() throws SQLException{
        Scanner scanner = new Scanner(System.in);
        int choice;
        do {
            System.out.println("");
            System.out.println("********************************************************************");
            System.out.println("员工管理");
            System.out.println("1、添加员工");
            System.out.println("2、删除员工");
            System.out.println("3、修改员工信息");
            System.out.println("4、查询员工信息");
            System.out.println("5、返回上一级菜单");
            System.out.println("********************************************************************");
            System.out.print("请选择操作：");
            choice = scanner.nextInt();
            System.out.println("");

            switch (choice) {
                case 1:
                    employeemanage.employee_add();
                    break;
                case 2:
                    employeemanage.employee_del() ;
                    break;
                case 3:
                    employeemanage.employee_update();
                    break;
                case 4:
                    employeemanage.employee_query();
                    break;
                case 5:
                    return;
                default:
                    System.out.println("请输入正确的操作编号！");
                    break;
            }
        } while (true);
    }

    private static void departmentManagement() throws SQLException{
        Scanner scanner = new Scanner(System.in);
        int choice;
        do {
            System.out.println("");
            System.out.println("********************************************************************");
            System.out.println("部门管理");
            System.out.println("1、添加部门");
            System.out.println("2、删除部门");
            System.out.println("3、修改部门信息");
            System.out.println("4、查询部门信息");
            System.out.println("5、返回上一级菜单");
            System.out.println("********************************************************************");
            System.out.print("请选择操作：");
            choice = scanner.nextInt();
            System.out.println("");

            switch (choice) {
                case 1:
                    departmentmanage.department_add();
                    break;
                case 2:
                    departmentmanage.department_del() ;
                    break;
                case 3:
                    departmentmanage.department_update();
                    break;
                case 4:
                    departmentmanage.department_query();
                    break;
                case 5:
                    return;
                default:
                    System.out.println("请输入正确的操作编号！");
                    break;
            }
        } while (true);
    }

    private static void positionManagement() throws SQLException{
        Scanner scanner = new Scanner(System.in);
        int choice;

        do {
            System.out.println("");
            System.out.println("********************************************************************");
            System.out.println("职位管理");
            System.out.println("1、添加职位");
            System.out.println("2、删除职位");
            System.out.println("3、修改职位信息");
            System.out.println("4、查询职位信息");
            System.out.println("5、返回上一级菜单");
            System.out.println("********************************************************************");
            System.out.print("请选择操作：");
            choice = scanner.nextInt();
            System.out.println("");

            switch (choice) {
                case 1:
                    postmanage.post_add();
                    break;
                case 2:
                    postmanage.post_del() ;
                    break;
                case 3:
                    postmanage.post_update();
                    break;
                case 4:
                    postmanage.post_query();
                    break;
                case 5:
                    return;
                default:
                    System.out.println("请输入正确的操作编号！");
                    break;
            }
        } while (true);
    }

    private static void salaryManagement() throws SQLException{
        Scanner scanner = new Scanner(System.in);
        int choice;

        do {
            System.out.println("");
            System.out.println("********************************************************************");
            System.out.println("工资管理");
            System.out.println("1、添加工资记录");
            System.out.println("2、删除工资记录");
            System.out.println("3、修改工资记录");
            System.out.println("4、查询工资记录");
            System.out.println("5、返回上一级菜单");
            System.out.println("********************************************************************");
            System.out.print("请选择操作：");
            choice = scanner.nextInt();
            System.out.println("");

            switch (choice) {
                case 1:
                    salarymanage.salary_add();
                    break;
                case 2:
                    salarymanage.salary_del();
                    break;
                case 3:
                    salarymanage.salary_update();
                    break;
                case 4:
                    salarymanage.salary_query();
                    break;
                case 5:
                    return;
                default:
                    System.out.println("请输入正确的操作编号！");
                    break;
            }
        } while (true);
    }

    private static void projectManagement() throws SQLException{
        Scanner scanner = new Scanner(System.in);
        int choice;
        do {
            System.out.println("");
            System.out.println("********************************************************************");
            System.out.println("项目管理");
            System.out.println("1、添加项目");
            System.out.println("2、删除项目");
            System.out.println("3、修改项目信息");
            System.out.println("4、查询项目信息");
            System.out.println("5、返回上一级菜单");
            System.out.println("********************************************************************");
            System.out.print("请选择操作：");
            choice = scanner.nextInt();
            System.out.println("");

            switch (choice) {
                case 1:
                    projectmanage.project_add();
                    break;
                case 2:
                    projectmanage.project_del();
                    break;
                case 3:
                    projectmanage.project_update();
                    break;
                case 4:
                    projectmanage.project_query();
                    break;
                case 5:
                    return;
                default:
                    System.out.println("请输入正确的操作编号！");
                    break;
            }
        } while (true);
    }
}