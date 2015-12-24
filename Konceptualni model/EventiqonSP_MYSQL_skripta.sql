/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     24.12.2015 20:53:27                          */
/*==============================================================*/


drop table if exists Aktivnost;

drop table if exists Dogodek;

drop table if exists Drzava;

drop table if exists IzbrisanRacun;

drop table if exists Kraj;

drop table if exists Naslov;

drop table if exists Obvestilo;

drop table if exists PostavkaAktivnosti;

drop table if exists PostavkaDogodka;

drop table if exists SeznamAktivnosti;

drop table if exists SeznamDogodkov;

drop table if exists Uporabnik;

/*==============================================================*/
/* Table: Aktivnost                                             */
/*==============================================================*/
create table Aktivnost
(
   idAktivnost          int not null,
   idKraj               int not null,
   kraticaDrzave        varchar(10) not null,
   omejitevMest         int,
   datumVnosa           datetime not null,
   datumOd              date not null,
   datumDo              date,
   jeEnkratna           bool not null,
   latitude             float not null,
   longitude            float not null,
   nazivLokacije        varchar(100) not null,
   opis                 varchar(1024) not null,
   primary key (idAktivnost)
);

/*==============================================================*/
/* Table: Dogodek                                               */
/*==============================================================*/
create table Dogodek
(
   id2                  int not null,
   kraticaDrzave        varchar(10) not null,
   idKraj               int not null,
   omejitevMest         int,
   datumVnosa           datetime not null,
   datumOd              date not null,
   datumDo              date not null,
   latitude             float not null,
   longitude            float not null,
   nazivLokacije        varchar(100) not null,
   opis                 varchar(1024) not null,
   primary key (id2)
);

/*==============================================================*/
/* Table: Drzava                                                */
/*==============================================================*/
create table Drzava
(
   kraticaDrzave        varchar(10) not null,
   imeDrzave            varchar(100) not null,
   primary key (kraticaDrzave)
);

/*==============================================================*/
/* Table: IzbrisanRacun                                         */
/*==============================================================*/
create table IzbrisanRacun
(
   uprabniskoIme        varchar(100) not null,
   razlog               varchar(1024) not null,
   datum                datetime not null,
   primary key (uprabniskoIme)
);

/*==============================================================*/
/* Table: Kraj                                                  */
/*==============================================================*/
create table Kraj
(
   idKraj               int not null,
   nazivKraja           varchar(100) not null,
   primary key (idKraj)
);

/*==============================================================*/
/* Table: Naslov                                                */
/*==============================================================*/
create table Naslov
(
   idNaslov             int not null,
   idKraj               int not null,
   kraticaDrzave        varchar(10) not null,
   hisnaStevilka        int not null,
   ulica                varchar(128) not null,
   primary key (idNaslov)
);

/*==============================================================*/
/* Table: Obvestilo                                             */
/*==============================================================*/
create table Obvestilo
(
   uprabniskoIme        varchar(100) not null,
   idObvestilo          int not null,
   tema                 varchar(50) not null,
   sporocilo            varchar(1024) not null,
   datum                datetime not null,
   primary key (uprabniskoIme, idObvestilo)
);

/*==============================================================*/
/* Table: PostavkaAktivnosti                                    */
/*==============================================================*/
create table PostavkaAktivnosti
(
   idAktivnost          int not null,
   idPostavkaAktivnosti int not null,
   naziv                varchar(20) not null,
   casovniOpisKdaj      varchar(30) not null,
   opisCasaTrajanja     varchar(30) not null,
   polniOpis            varchar(1024) not null,
   primary key (idAktivnost, idPostavkaAktivnosti)
);

/*==============================================================*/
/* Table: PostavkaDogodka                                       */
/*==============================================================*/
create table PostavkaDogodka
(
   id2                  int not null,
   idPostavkaDogodka    int not null,
   naziv                varchar(20) not null,
   casovniOpisKdaj      varchar(30) not null,
   opisCasaTrajanja     varchar(30) not null,
   polniOpis            varchar(1024) not null,
   primary key (id2, idPostavkaDogodka)
);

/*==============================================================*/
/* Table: SeznamAktivnosti                                      */
/*==============================================================*/
create table SeznamAktivnosti
(
   uprabniskoIme        varchar(100) not null,
   idAktivnost          int not null,
   idSeznamAktivnosti   int not null,
   statusUdelezbe       varchar(20) not null,
   primary key (uprabniskoIme, idAktivnost, idSeznamAktivnosti)
);

alter table SeznamAktivnosti comment 'Moje aktivnosti';

/*==============================================================*/
/* Table: SeznamDogodkov                                        */
/*==============================================================*/
create table SeznamDogodkov
(
   uprabniskoIme        varchar(100) not null,
   id2                  int not null,
   idSeznamDogodkov     int not null,
   statusUdelezbe       varchar(20) not null,
   steviloVstopnic      int not null,
   primary key (uprabniskoIme, id2, idSeznamDogodkov)
);

alter table SeznamDogodkov comment 'Moji dogodki
';

/*==============================================================*/
/* Table: Uporabnik                                             */
/*==============================================================*/
create table Uporabnik
(
   uprabniskoIme        varchar(100) not null,
   idNaslov             int not null,
   Izb_uprabniskoIme    varchar(100),
   email                varchar(100) not null,
   Ime                  varchar(50),
   Priimek              varchar(90),
   recoveryEmail        varchar(100),
   datumRojstva         date,
   geslo                varchar(512) not null,
   telefon              varchar(20),
   paypalRacun          varchar(100),
   primary key (uprabniskoIme)
);

alter table Aktivnost add constraint FK_aktivnost_v_kraju foreign key (idKraj)
      references Kraj (idKraj) on delete restrict on update restrict;

alter table Aktivnost add constraint FK_aktivnosti_v_drzavi foreign key (kraticaDrzave)
      references Drzava (kraticaDrzave) on delete restrict on update restrict;

alter table Dogodek add constraint FK_dogodek_v_drzavi foreign key (kraticaDrzave)
      references Drzava (kraticaDrzave) on delete restrict on update restrict;

alter table Dogodek add constraint FK_dogodek_v_kraju foreign key (idKraj)
      references Kraj (idKraj) on delete restrict on update restrict;

alter table IzbrisanRacun add constraint FK_uporabnik_ima_izbrisan_racun2 foreign key (uprabniskoIme)
      references Uporabnik (uprabniskoIme) on delete restrict on update restrict;

alter table Naslov add constraint FK_naslov_ima_kraj foreign key (idKraj)
      references Kraj (idKraj) on delete restrict on update restrict;

alter table Naslov add constraint FK_naslov_v_drzavi foreign key (kraticaDrzave)
      references Drzava (kraticaDrzave) on delete restrict on update restrict;

alter table Obvestilo add constraint FK_uporabnik_ima_obvestilo foreign key (uprabniskoIme)
      references Uporabnik (uprabniskoIme) on delete restrict on update restrict;

alter table PostavkaAktivnosti add constraint FK_aktivnost_ima_postavko foreign key (idAktivnost)
      references Aktivnost (idAktivnost) on delete restrict on update restrict;

alter table PostavkaDogodka add constraint FK_dogodek_ima_postavko foreign key (id2)
      references Dogodek (id2) on delete restrict on update restrict;

alter table SeznamAktivnosti add constraint FK_aktivnost_ima_uporabnike foreign key (idAktivnost)
      references Aktivnost (idAktivnost) on delete restrict on update restrict;

alter table SeznamAktivnosti add constraint FK_uporabnik_ima_aktivnosti foreign key (uprabniskoIme)
      references Uporabnik (uprabniskoIme) on delete restrict on update restrict;

alter table SeznamDogodkov add constraint FK_dogodek_ima_uporabnike foreign key (id2)
      references Dogodek (id2) on delete restrict on update restrict;

alter table SeznamDogodkov add constraint FK_uporabnik_ima_dogodke foreign key (uprabniskoIme)
      references Uporabnik (uprabniskoIme) on delete restrict on update restrict;

alter table Uporabnik add constraint FK_prebivalisce foreign key (idNaslov)
      references Naslov (idNaslov) on delete restrict on update restrict;

alter table Uporabnik add constraint FK_uporabnik_ima_izbrisan_racun foreign key (Izb_uprabniskoIme)
      references IzbrisanRacun (uprabniskoIme) on delete restrict on update restrict;

