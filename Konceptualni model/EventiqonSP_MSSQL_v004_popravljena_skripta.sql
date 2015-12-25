/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2005                    */
/* Created on:     25.12.2015 8:30:48                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Aktivnost') and o.name = 'FK_AKTIVNOS_AKTIVNOST_KRAJ')
alter table Aktivnost
   drop constraint FK_AKTIVNOS_AKTIVNOST_KRAJ
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Aktivnost') and o.name = 'FK_AKTIVNOS_AKTIVNOST_DRZAVA')
alter table Aktivnost
   drop constraint FK_AKTIVNOS_AKTIVNOST_DRZAVA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Dogodek') and o.name = 'FK_DOGODEK_DOGODEK_V_DRZAVA')
alter table Dogodek
   drop constraint FK_DOGODEK_DOGODEK_V_DRZAVA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Dogodek') and o.name = 'FK_DOGODEK_DOGODEK_V_KRAJ')
alter table Dogodek
   drop constraint FK_DOGODEK_DOGODEK_V_KRAJ
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('IzbrisanRacun') and o.name = 'FK_IZBRISAN_UPORABNIK_UPORABNI')
alter table IzbrisanRacun
   drop constraint FK_IZBRISAN_UPORABNIK_UPORABNI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Naslov') and o.name = 'FK_NASLOV_NASLOV_IM_KRAJ')
alter table Naslov
   drop constraint FK_NASLOV_NASLOV_IM_KRAJ
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Naslov') and o.name = 'FK_NASLOV_NASLOV_V__DRZAVA')
alter table Naslov
   drop constraint FK_NASLOV_NASLOV_V__DRZAVA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Obvestilo') and o.name = 'FK_OBVESTIL_UPORABNIK_UPORABNI')
alter table Obvestilo
   drop constraint FK_OBVESTIL_UPORABNIK_UPORABNI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PostavkaAktivnosti') and o.name = 'FK_POSTAVKA_AKTIVNOST_AKTIVNOS')
alter table PostavkaAktivnosti
   drop constraint FK_POSTAVKA_AKTIVNOST_AKTIVNOS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PostavkaDogodka') and o.name = 'FK_POSTAVKA_DOGODEK_I_DOGODEK')
alter table PostavkaDogodka
   drop constraint FK_POSTAVKA_DOGODEK_I_DOGODEK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SeznamAktivnosti') and o.name = 'FK_SEZNAMAK_AKTIVNOST_AKTIVNOS')
alter table SeznamAktivnosti
   drop constraint FK_SEZNAMAK_AKTIVNOST_AKTIVNOS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SeznamAktivnosti') and o.name = 'FK_SEZNAMAK_UPORABNIK_UPORABNI')
alter table SeznamAktivnosti
   drop constraint FK_SEZNAMAK_UPORABNIK_UPORABNI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SeznamDogodkov') and o.name = 'FK_SEZNAMDO_DOGODEK_I_DOGODEK')
alter table SeznamDogodkov
   drop constraint FK_SEZNAMDO_DOGODEK_I_DOGODEK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SeznamDogodkov') and o.name = 'FK_SEZNAMDO_UPORABNIK_UPORABNI')
alter table SeznamDogodkov
   drop constraint FK_SEZNAMDO_UPORABNIK_UPORABNI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Uporabnik') and o.name = 'FK_UPORABNI_PREBIVALI_NASLOV')
alter table Uporabnik
   drop constraint FK_UPORABNI_PREBIVALI_NASLOV
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Aktivnost')
            and   name  = 'aktivnost_v_kraju_FK'
            and   indid > 0
            and   indid < 255)
   drop index Aktivnost.aktivnost_v_kraju_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Aktivnost')
            and   name  = 'aktivnosti_v_drzavi_FK'
            and   indid > 0
            and   indid < 255)
   drop index Aktivnost.aktivnosti_v_drzavi_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Aktivnost')
            and   type = 'U')
   drop table Aktivnost
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Dogodek')
            and   name  = 'dogodek_v_kraju_FK'
            and   indid > 0
            and   indid < 255)
   drop index Dogodek.dogodek_v_kraju_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Dogodek')
            and   name  = 'dogodek_v_drzavi_FK'
            and   indid > 0
            and   indid < 255)
   drop index Dogodek.dogodek_v_drzavi_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Dogodek')
            and   type = 'U')
   drop table Dogodek
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Drzava')
            and   type = 'U')
   drop table Drzava
go

if exists (select 1
            from  sysobjects
           where  id = object_id('IzbrisanRacun')
            and   type = 'U')
   drop table IzbrisanRacun
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Kraj')
            and   type = 'U')
   drop table Kraj
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Naslov')
            and   name  = 'naslov_v_drzavi_FK'
            and   indid > 0
            and   indid < 255)
   drop index Naslov.naslov_v_drzavi_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Naslov')
            and   name  = 'naslov_ima_kraj_FK'
            and   indid > 0
            and   indid < 255)
   drop index Naslov.naslov_ima_kraj_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Naslov')
            and   type = 'U')
   drop table Naslov
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Obvestilo')
            and   name  = 'uporabnik_ima_obvestilo_FK'
            and   indid > 0
            and   indid < 255)
   drop index Obvestilo.uporabnik_ima_obvestilo_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Obvestilo')
            and   type = 'U')
   drop table Obvestilo
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PostavkaAktivnosti')
            and   name  = 'aktivnost_ima_postavko_FK'
            and   indid > 0
            and   indid < 255)
   drop index PostavkaAktivnosti.aktivnost_ima_postavko_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PostavkaAktivnosti')
            and   type = 'U')
   drop table PostavkaAktivnosti
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PostavkaDogodka')
            and   name  = 'dogodek_ima_postavko_FK'
            and   indid > 0
            and   indid < 255)
   drop index PostavkaDogodka.dogodek_ima_postavko_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PostavkaDogodka')
            and   type = 'U')
   drop table PostavkaDogodka
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PotrditvenaKoda')
            and   type = 'U')
   drop table PotrditvenaKoda
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SeznamAktivnosti')
            and   name  = 'aktivnost_ima_uporabnike_FK'
            and   indid > 0
            and   indid < 255)
   drop index SeznamAktivnosti.aktivnost_ima_uporabnike_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SeznamAktivnosti')
            and   name  = 'uporabnik_ima_aktivnosti_FK'
            and   indid > 0
            and   indid < 255)
   drop index SeznamAktivnosti.uporabnik_ima_aktivnosti_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SeznamAktivnosti')
            and   type = 'U')
   drop table SeznamAktivnosti
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SeznamDogodkov')
            and   name  = 'dogodek_ima_uporabnike_FK'
            and   indid > 0
            and   indid < 255)
   drop index SeznamDogodkov.dogodek_ima_uporabnike_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SeznamDogodkov')
            and   name  = 'uporabnik_ima_dogodke_FK'
            and   indid > 0
            and   indid < 255)
   drop index SeznamDogodkov.uporabnik_ima_dogodke_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SeznamDogodkov')
            and   type = 'U')
   drop table SeznamDogodkov
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Uporabnik')
            and   name  = 'prebivalisce_FK'
            and   indid > 0
            and   indid < 255)
   drop index Uporabnik.prebivalisce_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Uporabnik')
            and   type = 'U')
   drop table Uporabnik
go

/*==============================================================*/
/* Table: Aktivnost                                             */
/*==============================================================*/
create table Aktivnost (
   idAktivnost          int                  not null,
   idKraj               int                  not null,
   kraticaDrzave        varchar(10)          not null,
   omejitevMest         int                  null,
   datumVnosa           datetime             not null,
   datumOd              datetime             not null,
   datumDo              datetime             null,
   jeEnkratna           bit                  not null,
   latitude             float                not null,
   longitude            float                not null,
   nazivLokacije        varchar(100)         not null,
   opis                 varchar(1024)        not null,
   cena                 money                not null,
   constraint PK_AKTIVNOST primary key nonclustered (idAktivnost)
)
go

/*==============================================================*/
/* Index: aktivnosti_v_drzavi_FK                                */
/*==============================================================*/
create index aktivnosti_v_drzavi_FK on Aktivnost (
kraticaDrzave ASC
)
go

/*==============================================================*/
/* Index: aktivnost_v_kraju_FK                                  */
/*==============================================================*/
create index aktivnost_v_kraju_FK on Aktivnost (
idKraj ASC
)
go

/*==============================================================*/
/* Table: Dogodek                                               */
/*==============================================================*/
create table Dogodek (
   idDogodek                  int                  not null,
   kraticaDrzave        varchar(10)          not null,
   idKraj               int                  not null,
   omejitevMest         int                  null,
   datumVnosa           datetime             not null,
   datumOd              datetime             not null,
   datumDo              datetime             not null,
   latitude             float                not null,
   longitude            float                not null,
   nazivLokacije        varchar(100)         not null,
   opis                 varchar(1024)        not null,
   cena                 money                not null,
   constraint PK_DOGODEK primary key nonclustered (idDogodek)
)
go

/*==============================================================*/
/* Index: dogodek_v_drzavi_FK                                   */
/*==============================================================*/
create index dogodek_v_drzavi_FK on Dogodek (
kraticaDrzave ASC
)
go

/*==============================================================*/
/* Index: dogodek_v_kraju_FK                                    */
/*==============================================================*/
create index dogodek_v_kraju_FK on Dogodek (
idKraj ASC
)
go

/*==============================================================*/
/* Table: Drzava                                                */
/*==============================================================*/
create table Drzava (
   kraticaDrzave        varchar(10)          not null,
   imeDrzave            varchar(100)         not null,
   constraint PK_DRZAVA primary key nonclustered (kraticaDrzave)
)
go

/*==============================================================*/
/* Table: IzbrisanRacun                                         */
/*==============================================================*/
create table IzbrisanRacun (
   uprabniskoIme        varchar(100)         not null,
   razlog               varchar(1024)        not null,
   datum                datetime             not null,
   constraint PK_IZBRISANRACUN primary key (uprabniskoIme)
)
go

/*==============================================================*/
/* Table: Kraj                                                  */
/*==============================================================*/
create table Kraj (
   idKraj               int                  not null,
   nazivKraja           varchar(100)         not null,
   constraint PK_KRAJ primary key nonclustered (idKraj)
)
go

/*==============================================================*/
/* Table: Naslov                                                */
/*==============================================================*/
create table Naslov (
   idNaslov             int                  not null,
   idKraj               int                  not null,
   kraticaDrzave        varchar(10)          not null,
   hisnaStevilka        int                  not null,
   ulica                varchar(128)         not null,
   constraint PK_NASLOV primary key nonclustered (idNaslov)
)
go

/*==============================================================*/
/* Index: naslov_ima_kraj_FK                                    */
/*==============================================================*/
create index naslov_ima_kraj_FK on Naslov (
idKraj ASC
)
go

/*==============================================================*/
/* Index: naslov_v_drzavi_FK                                    */
/*==============================================================*/
create index naslov_v_drzavi_FK on Naslov (
kraticaDrzave ASC
)
go

/*==============================================================*/
/* Table: Obvestilo                                             */
/*==============================================================*/
create table Obvestilo (
   uprabniskoIme        varchar(100)         not null,
   idObvestilo          int                  not null,
   tema                 varchar(50)          not null,
   sporocilo            varchar(1024)        not null,
   datum                datetime             not null,
   constraint PK_OBVESTILO primary key nonclustered (uprabniskoIme, idObvestilo)
)
go

/*==============================================================*/
/* Index: uporabnik_ima_obvestilo_FK                            */
/*==============================================================*/
create index uporabnik_ima_obvestilo_FK on Obvestilo (
uprabniskoIme ASC
)
go

/*==============================================================*/
/* Table: PostavkaAktivnosti                                    */
/*==============================================================*/
create table PostavkaAktivnosti (
   idAktivnost          int                  not null,
   idPostavkaAktivnosti int                  not null,
   naziv                varchar(20)          not null,
   casovniOpisKdaj      varchar(30)          not null,
   opisCasaTrajanja     varchar(30)          not null,
   polniOpis            varchar(1024)        not null,
   constraint PK_POSTAVKAAKTIVNOSTI primary key nonclustered (idAktivnost, idPostavkaAktivnosti)
)
go

/*==============================================================*/
/* Index: aktivnost_ima_postavko_FK                             */
/*==============================================================*/
create index aktivnost_ima_postavko_FK on PostavkaAktivnosti (
idAktivnost ASC
)
go

/*==============================================================*/
/* Table: PostavkaDogodka                                       */
/*==============================================================*/
create table PostavkaDogodka (
   idDogodek                  int                  not null,
   idPostavkaDogodka    int                  not null,
   naziv                varchar(20)          not null,
   casovniOpisKdaj      varchar(30)          not null,
   opisCasaTrajanja     varchar(30)          not null,
   polniOpis            varchar(1024)        not null,
   constraint PK_POSTAVKADOGODKA primary key nonclustered (idDogodek, idPostavkaDogodka)
)
go

/*==============================================================*/
/* Index: dogodek_ima_postavko_FK                               */
/*==============================================================*/
create index dogodek_ima_postavko_FK on PostavkaDogodka (
idDogodek ASC
)
go

/*==============================================================*/
/* Table: PotrditvenaKoda                                       */
/*==============================================================*/
create table PotrditvenaKoda (
   uporabniskoIme       varchar(100)         not null,
   koda                 varchar(256)         not null,
   datumVnosa           datetime             not null,
   datumPoteka          datetime             not null,
   constraint PK_POTRDITVENAKODA primary key nonclustered (uporabniskoIme)
)
go

/*==============================================================*/
/* Table: SeznamAktivnosti                                      */
/*==============================================================*/
create table SeznamAktivnosti (
   uprabniskoIme        varchar(100)         not null,
   idAktivnost          int                  not null,
   idSeznamAktivnosti   int                  not null,
   statusUdelezbe       varchar(20)          not null,
   cena                 money                null,
   constraint PK_SEZNAMAKTIVNOSTI primary key nonclustered (uprabniskoIme, idAktivnost, idSeznamAktivnosti)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Moje aktivnosti',
   'user', @CurrentUser, 'table', 'SeznamAktivnosti'
go

/*==============================================================*/
/* Index: uporabnik_ima_aktivnosti_FK                           */
/*==============================================================*/
create index uporabnik_ima_aktivnosti_FK on SeznamAktivnosti (
uprabniskoIme ASC
)
go

/*==============================================================*/
/* Index: aktivnost_ima_uporabnike_FK                           */
/*==============================================================*/
create index aktivnost_ima_uporabnike_FK on SeznamAktivnosti (
idAktivnost ASC
)
go

/*==============================================================*/
/* Table: SeznamDogodkov                                        */
/*==============================================================*/
create table SeznamDogodkov (
   uprabniskoIme        varchar(100)         not null,
   idDogodek                  int                  not null,
   idSeznamDogodkov     int                  not null,
   statusUdelezbe       varchar(20)          not null,
   steviloVstopnic      int                  not null,
   cena                 money                null,
   constraint PK_SEZNAMDOGODKOV primary key nonclustered (uprabniskoIme, idDogodek, idSeznamDogodkov)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Moji dogodki
   ',
   'user', @CurrentUser, 'table', 'SeznamDogodkov'
go

/*==============================================================*/
/* Index: uporabnik_ima_dogodke_FK                              */
/*==============================================================*/
create index uporabnik_ima_dogodke_FK on SeznamDogodkov (
uprabniskoIme ASC
)
go

/*==============================================================*/
/* Index: dogodek_ima_uporabnike_FK                             */
/*==============================================================*/
create index dogodek_ima_uporabnike_FK on SeznamDogodkov (
idDogodek ASC
)
go

/*==============================================================*/
/* Table: Uporabnik                                             */
/*==============================================================*/
create table Uporabnik (
   uprabniskoIme        varchar(100)         not null,
   idNaslov             int                  not null,
   email                varchar(100)         not null,
   Ime                  varchar(50)          null,
   Priimek              varchar(90)          null,
   recoveryEmail        varchar(100)         null,
   datumRojstva         datetime             null,
   geslo                varchar(512)         not null,
   telefon              varchar(20)          null,
   paypalRacun          varchar(100)         null,
   status               varchar(10)          not null,
   constraint PK_UPORABNIK primary key nonclustered (uprabniskoIme)
)
go

/*==============================================================*/
/* Index: prebivalisce_FK                                       */
/*==============================================================*/
create index prebivalisce_FK on Uporabnik (
idNaslov ASC
)
go

alter table Aktivnost
   add constraint FK_AKTIVNOS_AKTIVNOST_KRAJ foreign key (idKraj)
      references Kraj (idKraj)
go

alter table Aktivnost
   add constraint FK_AKTIVNOS_AKTIVNOST_DRZAVA foreign key (kraticaDrzave)
      references Drzava (kraticaDrzave)
go

alter table Dogodek
   add constraint FK_DOGODEK_DOGODEK_V_DRZAVA foreign key (kraticaDrzave)
      references Drzava (kraticaDrzave)
go

alter table Dogodek
   add constraint FK_DOGODEK_DOGODEK_V_KRAJ foreign key (idKraj)
      references Kraj (idKraj)
go

alter table IzbrisanRacun
   add constraint FK_IZBRISAN_UPORABNIK_UPORABNI foreign key (uprabniskoIme)
      references Uporabnik (uprabniskoIme)
go

alter table Naslov
   add constraint FK_NASLOV_NASLOV_IM_KRAJ foreign key (idKraj)
      references Kraj (idKraj)
go

alter table Naslov
   add constraint FK_NASLOV_NASLOV_V__DRZAVA foreign key (kraticaDrzave)
      references Drzava (kraticaDrzave)
go

alter table Obvestilo
   add constraint FK_OBVESTIL_UPORABNIK_UPORABNI foreign key (uprabniskoIme)
      references Uporabnik (uprabniskoIme)
go

alter table PostavkaAktivnosti
   add constraint FK_POSTAVKA_AKTIVNOST_AKTIVNOS foreign key (idAktivnost)
      references Aktivnost (idAktivnost)
go

alter table PostavkaDogodka
   add constraint FK_POSTAVKA_DOGODEK_I_DOGODEK foreign key (idDogodek)
      references Dogodek (idDogodek)
go

alter table SeznamAktivnosti
   add constraint FK_SEZNAMAK_AKTIVNOST_AKTIVNOS foreign key (idAktivnost)
      references Aktivnost (idAktivnost)
go

alter table SeznamAktivnosti
   add constraint FK_SEZNAMAK_UPORABNIK_UPORABNI foreign key (uprabniskoIme)
      references Uporabnik (uprabniskoIme)
go

alter table SeznamDogodkov
   add constraint FK_SEZNAMDO_DOGODEK_I_DOGODEK foreign key (idDogodek)
      references Dogodek (idDogodek)
go

alter table SeznamDogodkov
   add constraint FK_SEZNAMDO_UPORABNIK_UPORABNI foreign key (uprabniskoIme)
      references Uporabnik (uprabniskoIme)
go

alter table Uporabnik
   add constraint FK_UPORABNI_PREBIVALI_NASLOV foreign key (idNaslov)
      references Naslov (idNaslov)
go

