create table tb_categories (
	cat_id int generated always as identity primary key not null,
	cat_name text not null,
	cat_description text
)

insert into tb_categories(cat_name) values ('Alimentação');
insert into tb_categories(cat_name) values ('Área de descanso');
insert into tb_categories(cat_name) values ('Borracharia');
insert into tb_categories(cat_name) values ('Hotéis');
insert into tb_categories(cat_name) values ('Mecânica');
insert into tb_categories(cat_name) values ('Pontos de Apoio');
insert into tb_categories(cat_name) values ('Posto de combustivel');
insert into tb_categories(cat_name) values ('Postos de serviço');
insert into tb_categories(cat_name) values ('Saúde');
insert into tb_categories(cat_name) values ('Socorro');