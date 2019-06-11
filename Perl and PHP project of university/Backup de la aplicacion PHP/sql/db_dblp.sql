create database db_dblp;






CREATE TABLE TB_DBLP_AUTOR
(
	id_publicacion       bigint(20) NOT NULL,
	id_autor             bigint(20) NOT NULL,
	autor_num            int(3) NOT NULL,
	editor               int(1) NOT NULL DEFAULT '0'
)ENGINE=MyISAM DEFAULT CHARACTER SET=utf8;



ALTER TABLE TB_DBLP_AUTOR
ADD PRIMARY KEY (id_publicacion,id_autor);


--ALTER TABLE TB_DBLP_AUTOR ADD KEY id_publicacion (id_publicacion);


ALTER TABLE TB_DBLP_AUTOR ADD KEY id_autor (id_autor);









CREATE TABLE TB_DBLP_CAMINOS
(
	id_autor_inicial         bigint(20) NOT NULL,
	id_autor_final           bigint(20) NOT NULL,
	num_nodos            int(10) NOT NULL,
	camino               varchar(255) NOT NULL
)ENGINE=MyISAM DEFAULT CHARACTER SET=utf8;



ALTER TABLE TB_DBLP_CAMINOS
ADD PRIMARY KEY (id_autor_inicial,id_autor_final);


--ALTER TABLE TB_DBLP_CAMINOS ADD KEY num_nodos (num_nodos);









CREATE TABLE TB_DBLP_DATOS_PUBLICACION
(
	id_publicacion       bigint(20) NOT NULL AUTO_INCREMENT,
	dblp_key             varchar(150) NOT NULL,
	dblp_key_1           varchar(100) NOT NULL,
	dblp_key_2           varchar(100) NOT NULL,
	dblp_key_3           varchar(100) NOT NULL,
	dblp_key_4           varchar(100) NOT NULL,
	year                 int(4) DEFAULT '0',
	id_tipo              int(8) NOT NULL,
	tipo		     varchar(20) NULL,
	PRIMARY KEY (id_publicacion)
)ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


--ALTER TABLE TB_DBLP_DATOS_PUBLICACION ADD KEY dblp_key (dblp_key, id_tipo);

-- El siguiente indice se crea para cuando se actualiza la tabla con nuevas publicaciones
ALTER TABLE TB_DBLP_DATOS_PUBLICACION ADD KEY dblp_key2 (dblp_key);

--ALTER TABLE TB_DBLP_DATOS_PUBLICACION ADD KEY year (year);

--ALTER TABLE TB_DBLP_DATOS_PUBLICACION ADD KEY id_tipo (id_tipo);











CREATE TABLE TB_DBLP_DETALLE_AUTOR
(
	id_autor             bigint(20) NOT NULL AUTO_INCREMENT,
	nombre               varchar(60) NOT NULL,
	nombrecorto          varchar(30) NULL,
	sexo                 varchar(10) DEFAULT NULL,
	PRIMARY KEY (id_autor)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;




ALTER TABLE TB_DBLP_DETALLE_AUTOR ADD KEY nombre (nombre);

-- ALTER TABLE TB_DBLP_DETALLE_AUTOR ADD KEY id_autor (id_autor,nombre);









CREATE TABLE TB_DBLP_DETALLE_TIPO
(
	id_tipo              int(8) NOT NULL AUTO_INCREMENT,
	descripcion_tipo     varchar(30) NOT NULL,
	PRIMARY KEY (id_tipo)
)ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;




INSERT INTO tb_dblp_detalle_tipo
(`id_tipo`, `descripcion_tipo`) 
VALUES
(1, 'article'),
(2, 'inproceedings'),
(3, 'proceedings'),
(4, 'book'),
(5, 'incollection'),
(6, 'phdthesis'),
(7, 'mastersthesis'),
(8, 'www');









CREATE TABLE TB_DBLP_REL
(
	id_autor	bigint(20) NOT NULL,
	id_coautor	bigint(20) NOT NULL
)ENGINE=MyISAM DEFAULT CHARSET=utf8;



ALTER TABLE TB_DBLP_REL
ADD PRIMARY KEY (id_autor,id_coautor);


-- Creado para mejorar las consultas en el algoritmo de Dijkstra
ALTER TABLE TB_DBLP_REL ADD KEY id_autor(id_autor);

-- Creado para mejorar las consultas en el algoritmo de Dijkstra
ALTER TABLE TB_DBLP_REL ADD KEY id_coautor(id_coautor);









ALTER TABLE TB_DBLP_AUTOR
ADD CONSTRAINT AUTOR2 FOREIGN KEY (id_publicacion) REFERENCES TB_DBLP_DATOS_PUBLICACION (id_publicacion)
		ON DELETE CASCADE;



ALTER TABLE TB_DBLP_AUTOR
ADD CONSTRAINT R_38 FOREIGN KEY (id_autor) REFERENCES TB_DBLP_DETALLE_AUTOR (id_autor) 	ON DELETE CASCADE;
