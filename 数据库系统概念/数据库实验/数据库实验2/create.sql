/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2023/5/8 0:31:00                             */
/*==============================================================*/


drop table if exists department;

drop table if exists employee;

drop table if exists employee_project;

drop table if exists post;

drop table if exists post_department;

drop table if exists project;

drop table if exists salary;

/*==============================================================*/
/* Table: department                                            */
/*==============================================================*/
create table department
(
   department_id        int not null,
   dep_department_id    int,
   department_header    int,
   department_name      varchar(100),
   primary key (department_id)
);

/*==============================================================*/
/* Table: employee                                              */
/*==============================================================*/
create table employee
(
   id                   int not null,
   post_id              int,
   department_id        int,
   tel                  varchar(50),
   gender               varchar(10),
   name                 varchar(100),
   entry_time           date,
   id_card              varchar(50),
   year                 int,
   primary key (id)
);

/*==============================================================*/
/* Table: employee_project                                      */
/*==============================================================*/
create table employee_project
(
   id                   int not null,
   project_id           int not null,
   primary key (id, project_id)
);

/*==============================================================*/
/* Table: post                                                  */
/*==============================================================*/
create table post
(
   post_id              int not null,
   post_name            varchar(100),
   primary key (post_id)
);

/*==============================================================*/
/* Table: post_department                                       */
/*==============================================================*/
create table post_department
(
   post_id              int not null,
   department_id        int not null,
   primary key (post_id, department_id)
);

/*==============================================================*/
/* Table: project                                               */
/*==============================================================*/
create table project
(
   project_id           int not null,
   department_id        int,
   project_name         varchar(100),
   start_time           date,
   end_time             date,
   project_header       int,
   primary key (project_id)
);

/*==============================================================*/
/* Table: salary                                                */
/*==============================================================*/
create table salary
(
   basic_salary         int,
   merit_salary         int,
   allowance            int,
   overtime_salary      int,
   salary_id            int not null,
   id                   int,
   release_time         date,
   primary key (salary_id)
);

alter table department add constraint FK_Reference_11 foreign key (department_header)
      references employee (id) on delete restrict on update restrict;

alter table department add constraint FK_department_upper foreign key (dep_department_id)
      references department (department_id) on delete restrict on update restrict;

alter table employee add constraint FK_employee_department foreign key (department_id)
      references department (department_id) on delete restrict on update restrict;

alter table employee add constraint FK_employee_post foreign key (post_id)
      references post (post_id) on delete restrict on update restrict;

alter table employee_project add constraint FK_employee_project foreign key (id)
      references employee (id) on delete restrict on update restrict;

alter table employee_project add constraint FK_employee_project2 foreign key (project_id)
      references project (project_id) on delete restrict on update restrict;

alter table post_department add constraint FK_post_department foreign key (post_id)
      references post (post_id) on delete restrict on update restrict;

alter table post_department add constraint FK_post_department2 foreign key (department_id)
      references department (department_id) on delete restrict on update restrict;

alter table project add constraint FK_Reference_10 foreign key (project_header)
      references employee (id) on delete restrict on update restrict;

alter table project add constraint FK_department_project foreign key (department_id)
      references department (department_id) on delete restrict on update restrict;

alter table salary add constraint FK_employee_salary foreign key (id)
      references employee (id) on delete restrict on update restrict;

