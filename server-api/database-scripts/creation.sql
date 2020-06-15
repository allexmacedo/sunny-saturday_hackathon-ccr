create type usr_types as enum ('driver', 'partner');

create table tb_users (
	usr_id int generated always as identity primary key not null,
	usr_email text not null,
	usr_password text,
	usr_roles text[],
	usr_created_at date not null,
	usr_updated_at date not null,
	usr_type usr_types
);

create table tb_drivers (
	drv_id int generated always as identity primary key not null,
	drv_name text not null,
	drv_age int not null,
	drv_uf character(2) not null,
    usr_created_at date not null,
	usr_updated_at date not null,
	drv_usr_id int not null,
	foreign key (drv_usr_id) references tb_users (usr_id)
);


create table tb_partners (
	prt_id int generated always as identity primary key not null,
	usr_created_at date not null,
	usr_updated_at date not null,
    prt_usr_id int not null,
	foreign key (prt_usr_id) references tb_users (usr_id)
)

create table tb_companies (
	cpn_id int generated always as identity primary key not null,
    usr_created_at date not null,
	usr_updated_at date not null,
	cpn_prt_id int not null,
	foreign key (cpn_prt_id) references tb_partners (prt_id)
)

create table tb_places (
	plc_id int generated always as identity primary key not null,
    usr_created_at date not null,
	usr_updated_at date not null,
	plc_cpn_id int not null,
	plc_ctg_id int not null,
	foreign key (plc_cpn_id) references tb_companies (cpn_id),
	foreign key (plc_ctg_id) references tb_categories (ctg_id)
)

create table tb_categories (
	ctg_id int generated always as identity primary key not null,
    usr_created_at date not null,
	usr_updated_at date not null,
	ctg_name text not null,
	ctg_type text not null
)

create table tb_wallet (
	wlt_id int generated always as identity primary key not null,
    usr_created_at date not null,
	usr_updated_at date not null,
	wlt_drv_id int not null,
	wlt_cashback numeric default 0,
	foreign key (wlt_drv_id) references tb_drivers (drv_id)
)

create table tb_transacions (
	tra_id int generated always as identity primary key not null,
    tra_date date not null,
	tra_place_id int not null,
	tra_wlt_id int not null,
	foreign key (tra_place_id) references tb_places (plc_id),
	foreign key (tra_wlt_id) references tb_wallet (wlt_id)
)
    