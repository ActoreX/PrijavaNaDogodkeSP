
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 01/10/2016 14:42:12
-- Generated from EDMX file: C:\Users\Čebelica\Documents\Aleksander Tomič\PrijavaNaDogodkeSP\EventiqonWebApp\EventiqonWebApp\Models\EventiqonDB.edmx


-- --------------------------------------------------

CREATE DATABASE [Eventiqon];

SET QUOTED_IDENTIFIER OFF;
GO
USE [Eventiqon];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_AKTIVNOS_AKTIVNOST_DRZAVA]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Aktivnost] DROP CONSTRAINT [FK_AKTIVNOS_AKTIVNOST_DRZAVA];
GO
IF OBJECT_ID(N'[dbo].[FK_AKTIVNOS_AKTIVNOST_KRAJ]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Aktivnost] DROP CONSTRAINT [FK_AKTIVNOS_AKTIVNOST_KRAJ];
GO
IF OBJECT_ID(N'[dbo].[FK_DOGODEK_DOGODEK_V_DRZAVA]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Dogodek] DROP CONSTRAINT [FK_DOGODEK_DOGODEK_V_DRZAVA];
GO
IF OBJECT_ID(N'[dbo].[FK_DOGODEK_DOGODEK_V_KRAJ]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Dogodek] DROP CONSTRAINT [FK_DOGODEK_DOGODEK_V_KRAJ];
GO
IF OBJECT_ID(N'[dbo].[FK_IZBRISAN_UPORABNIK_UPORABNI]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[IzbrisanRacun] DROP CONSTRAINT [FK_IZBRISAN_UPORABNIK_UPORABNI];
GO
IF OBJECT_ID(N'[dbo].[FK_NASLOV_NASLOV_IM_KRAJ]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Naslov] DROP CONSTRAINT [FK_NASLOV_NASLOV_IM_KRAJ];
GO
IF OBJECT_ID(N'[dbo].[FK_NASLOV_NASLOV_V__DRZAVA]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Naslov] DROP CONSTRAINT [FK_NASLOV_NASLOV_V__DRZAVA];
GO
IF OBJECT_ID(N'[dbo].[FK_OBVESTIL_UPORABNIK_UPORABNI]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Obvestilo] DROP CONSTRAINT [FK_OBVESTIL_UPORABNIK_UPORABNI];
GO
IF OBJECT_ID(N'[dbo].[FK_POSTAVKA_AKTIVNOST_AKTIVNOS]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PostavkaAktivnosti] DROP CONSTRAINT [FK_POSTAVKA_AKTIVNOST_AKTIVNOS];
GO
IF OBJECT_ID(N'[dbo].[FK_POSTAVKA_DOGODEK_I_DOGODEK]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PostavkaDogodka] DROP CONSTRAINT [FK_POSTAVKA_DOGODEK_I_DOGODEK];
GO
IF OBJECT_ID(N'[dbo].[FK_SEZNAMAK_AKTIVNOST_AKTIVNOS]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SeznamAktivnosti] DROP CONSTRAINT [FK_SEZNAMAK_AKTIVNOST_AKTIVNOS];
GO
IF OBJECT_ID(N'[dbo].[FK_SEZNAMAK_UPORABNIK_UPORABNI]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SeznamAktivnosti] DROP CONSTRAINT [FK_SEZNAMAK_UPORABNIK_UPORABNI];
GO
IF OBJECT_ID(N'[dbo].[FK_SEZNAMDO_DOGODEK_I_DOGODEK]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SeznamDogodkov] DROP CONSTRAINT [FK_SEZNAMDO_DOGODEK_I_DOGODEK];
GO
IF OBJECT_ID(N'[dbo].[FK_SEZNAMDO_UPORABNIK_UPORABNI]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SeznamDogodkov] DROP CONSTRAINT [FK_SEZNAMDO_UPORABNIK_UPORABNI];
GO
IF OBJECT_ID(N'[dbo].[FK_UPORABNI_PREBIVALI_NASLOV]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Uporabnik] DROP CONSTRAINT [FK_UPORABNI_PREBIVALI_NASLOV];
GO
IF OBJECT_ID(N'[dbo].[FK_UPORABNI_UPORABNIK_UPORABNI]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[uporabnik_ima_vlogo] DROP CONSTRAINT [FK_UPORABNI_UPORABNIK_UPORABNI];
GO
IF OBJECT_ID(N'[dbo].[FK_UPORABNI_UPORABNIK_VLOGA]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[uporabnik_ima_vlogo] DROP CONSTRAINT [FK_UPORABNI_UPORABNIK_VLOGA];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Aktivnost]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Aktivnost];
GO
IF OBJECT_ID(N'[dbo].[Dogodek]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Dogodek];
GO
IF OBJECT_ID(N'[dbo].[Drzava]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Drzava];
GO
IF OBJECT_ID(N'[dbo].[IzbrisanRacun]', 'U') IS NOT NULL
    DROP TABLE [dbo].[IzbrisanRacun];
GO
IF OBJECT_ID(N'[dbo].[Kraj]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Kraj];
GO
IF OBJECT_ID(N'[dbo].[Naslov]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Naslov];
GO
IF OBJECT_ID(N'[dbo].[Obvestilo]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Obvestilo];
GO
IF OBJECT_ID(N'[dbo].[PostavkaAktivnosti]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PostavkaAktivnosti];
GO
IF OBJECT_ID(N'[dbo].[PostavkaDogodka]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PostavkaDogodka];
GO
IF OBJECT_ID(N'[dbo].[PotrditvenaKoda]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PotrditvenaKoda];
GO
IF OBJECT_ID(N'[dbo].[SeznamAktivnosti]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SeznamAktivnosti];
GO
IF OBJECT_ID(N'[dbo].[SeznamDogodkov]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SeznamDogodkov];
GO
IF OBJECT_ID(N'[dbo].[Uporabnik]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Uporabnik];
GO
IF OBJECT_ID(N'[dbo].[uporabnik_ima_vlogo]', 'U') IS NOT NULL
    DROP TABLE [dbo].[uporabnik_ima_vlogo];
GO
IF OBJECT_ID(N'[dbo].[Vloga]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Vloga];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Aktivnost'
CREATE TABLE [dbo].[Aktivnost] (
    [idAktivnost] int  NOT NULL,
    [idKraj] int  NOT NULL,
    [kraticaDrzave] varchar(10)  NOT NULL,
    [naziv] varchar(24)  NOT NULL,
    [omejitevMest] int  NULL,
    [datumVnosa] datetime  NOT NULL,
    [datumOd] datetime  NOT NULL,
    [datumDo] datetime  NULL,
    [jeEnkratna] bit  NOT NULL,
    [latitude] float  NOT NULL,
    [longitude] float  NOT NULL,
    [nazivLokacije] varchar(100)  NOT NULL,
    [opis] varchar(1024)  NOT NULL,
    [cena] decimal(19,4)  NOT NULL,
    [status] varchar(16)  NULL
);
GO

-- Creating table 'Dogodek'
CREATE TABLE [dbo].[Dogodek] (
    [idDogodek] int  NOT NULL,
    [kraticaDrzave] varchar(10)  NOT NULL,
    [idKraj] int  NOT NULL,
    [naziv] varchar(24)  NOT NULL,
    [omejitevMest] int  NULL,
    [datumVnosa] datetime  NOT NULL,
    [datumOd] datetime  NOT NULL,
    [datumDo] datetime  NOT NULL,
    [latitude] float  NOT NULL,
    [longitude] float  NOT NULL,
    [nazivLokacije] varchar(100)  NOT NULL,
    [opis] varchar(1024)  NOT NULL,
    [cena] decimal(19,4)  NOT NULL,
    [status] varchar(16)  NULL
);
GO

-- Creating table 'Drzava'
CREATE TABLE [dbo].[Drzava] (
    [kraticaDrzave] varchar(10)  NOT NULL,
    [imeDrzave] varchar(100)  NOT NULL
);
GO

-- Creating table 'IzbrisanRacun'
CREATE TABLE [dbo].[IzbrisanRacun] (
    [uprabniskoIme] varchar(100)  NOT NULL,
    [razlog] varchar(1024)  NOT NULL,
    [datum] datetime  NOT NULL
);
GO

-- Creating table 'Kraj'
CREATE TABLE [dbo].[Kraj] (
    [idKraj] int  NOT NULL,
    [nazivKraja] varchar(100)  NOT NULL
);
GO

-- Creating table 'Naslov'
CREATE TABLE [dbo].[Naslov] (
    [idNaslov] int  NOT NULL,
    [idKraj] int  NOT NULL,
    [kraticaDrzave] varchar(10)  NOT NULL,
    [hisnaStevilka] int  NOT NULL,
    [ulica] varchar(128)  NOT NULL
);
GO

-- Creating table 'Obvestilo'
CREATE TABLE [dbo].[Obvestilo] (
    [uprabniskoIme] varchar(100)  NOT NULL,
    [idObvestilo] int  NOT NULL,
    [tema] varchar(50)  NOT NULL,
    [sporocilo] varchar(1024)  NOT NULL,
    [datum] datetime  NOT NULL
);
GO

-- Creating table 'PostavkaAktivnosti'
CREATE TABLE [dbo].[PostavkaAktivnosti] (
    [idAktivnost] int  NOT NULL,
    [idPostavkaAktivnosti] int  NOT NULL,
    [naziv] varchar(20)  NOT NULL,
    [casovniOpisKdaj] varchar(30)  NOT NULL,
    [opisCasaTrajanja] varchar(30)  NOT NULL,
    [polniOpis] varchar(1024)  NOT NULL
);
GO

-- Creating table 'PostavkaDogodka'
CREATE TABLE [dbo].[PostavkaDogodka] (
    [idDogodek] int  NOT NULL,
    [idPostavkaDogodka] int  NOT NULL,
    [naziv] varchar(20)  NOT NULL,
    [casovniOpisKdaj] varchar(30)  NOT NULL,
    [opisCasaTrajanja] varchar(30)  NOT NULL,
    [polniOpis] varchar(1024)  NOT NULL
);
GO

-- Creating table 'PotrditvenaKoda'
CREATE TABLE [dbo].[PotrditvenaKoda] (
    [uporabniskoIme] varchar(100)  NOT NULL,
    [koda] varchar(256)  NOT NULL,
    [datumVnosa] datetime  NOT NULL,
    [datumPoteka] datetime  NOT NULL
);
GO

-- Creating table 'SeznamAktivnosti'
CREATE TABLE [dbo].[SeznamAktivnosti] (
    [uprabniskoIme] varchar(100)  NOT NULL,
    [idAktivnost] int  NOT NULL,
    [idSeznamAktivnosti] int  NOT NULL,
    [statusUdelezbe] varchar(20)  NOT NULL,
    [cena] decimal(19,4)  NULL
);
GO

-- Creating table 'SeznamDogodkov'
CREATE TABLE [dbo].[SeznamDogodkov] (
    [uprabniskoIme] varchar(100)  NOT NULL,
    [idDogodek] int  NOT NULL,
    [idSeznamDogodkov] int  NOT NULL,
    [statusUdelezbe] varchar(20)  NOT NULL,
    [steviloVstopnic] int  NOT NULL,
    [cena] decimal(19,4)  NULL
);
GO

-- Creating table 'Uporabnik'
CREATE TABLE [dbo].[Uporabnik] (
    [uprabniskoIme] varchar(100)  NOT NULL,
    [idNaslov] int  NOT NULL,
    [email] varchar(100)  NOT NULL,
    [Ime] varchar(50)  NULL,
    [Priimek] varchar(90)  NULL,
    [recoveryEmail] varchar(100)  NULL,
    [datumRojstva] datetime  NULL,
    [geslo] varchar(512)  NOT NULL,
    [telefon] varchar(20)  NULL,
    [paypalRacun] varchar(100)  NULL,
    [status] varchar(10)  NOT NULL
);
GO

-- Creating table 'Vloga'
CREATE TABLE [dbo].[Vloga] (
    [nazivVloge] varchar(10)  NOT NULL
);
GO

-- Creating table 'uporabnik_ima_vlogo'
CREATE TABLE [dbo].[uporabnik_ima_vlogo] (
    [Uporabnik_uprabniskoIme] varchar(100)  NOT NULL,
    [Vloga_nazivVloge] varchar(10)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [idAktivnost] in table 'Aktivnost'
ALTER TABLE [dbo].[Aktivnost]
ADD CONSTRAINT [PK_Aktivnost]
    PRIMARY KEY CLUSTERED ([idAktivnost] ASC);
GO

-- Creating primary key on [idDogodek] in table 'Dogodek'
ALTER TABLE [dbo].[Dogodek]
ADD CONSTRAINT [PK_Dogodek]
    PRIMARY KEY CLUSTERED ([idDogodek] ASC);
GO

-- Creating primary key on [kraticaDrzave] in table 'Drzava'
ALTER TABLE [dbo].[Drzava]
ADD CONSTRAINT [PK_Drzava]
    PRIMARY KEY CLUSTERED ([kraticaDrzave] ASC);
GO

-- Creating primary key on [uprabniskoIme] in table 'IzbrisanRacun'
ALTER TABLE [dbo].[IzbrisanRacun]
ADD CONSTRAINT [PK_IzbrisanRacun]
    PRIMARY KEY CLUSTERED ([uprabniskoIme] ASC);
GO

-- Creating primary key on [idKraj] in table 'Kraj'
ALTER TABLE [dbo].[Kraj]
ADD CONSTRAINT [PK_Kraj]
    PRIMARY KEY CLUSTERED ([idKraj] ASC);
GO

-- Creating primary key on [idNaslov] in table 'Naslov'
ALTER TABLE [dbo].[Naslov]
ADD CONSTRAINT [PK_Naslov]
    PRIMARY KEY CLUSTERED ([idNaslov] ASC);
GO

-- Creating primary key on [uprabniskoIme], [idObvestilo] in table 'Obvestilo'
ALTER TABLE [dbo].[Obvestilo]
ADD CONSTRAINT [PK_Obvestilo]
    PRIMARY KEY CLUSTERED ([uprabniskoIme], [idObvestilo] ASC);
GO

-- Creating primary key on [idAktivnost], [idPostavkaAktivnosti] in table 'PostavkaAktivnosti'
ALTER TABLE [dbo].[PostavkaAktivnosti]
ADD CONSTRAINT [PK_PostavkaAktivnosti]
    PRIMARY KEY CLUSTERED ([idAktivnost], [idPostavkaAktivnosti] ASC);
GO

-- Creating primary key on [idDogodek], [idPostavkaDogodka] in table 'PostavkaDogodka'
ALTER TABLE [dbo].[PostavkaDogodka]
ADD CONSTRAINT [PK_PostavkaDogodka]
    PRIMARY KEY CLUSTERED ([idDogodek], [idPostavkaDogodka] ASC);
GO

-- Creating primary key on [uporabniskoIme] in table 'PotrditvenaKoda'
ALTER TABLE [dbo].[PotrditvenaKoda]
ADD CONSTRAINT [PK_PotrditvenaKoda]
    PRIMARY KEY CLUSTERED ([uporabniskoIme] ASC);
GO

-- Creating primary key on [uprabniskoIme], [idAktivnost], [idSeznamAktivnosti] in table 'SeznamAktivnosti'
ALTER TABLE [dbo].[SeznamAktivnosti]
ADD CONSTRAINT [PK_SeznamAktivnosti]
    PRIMARY KEY CLUSTERED ([uprabniskoIme], [idAktivnost], [idSeznamAktivnosti] ASC);
GO

-- Creating primary key on [uprabniskoIme], [idDogodek], [idSeznamDogodkov] in table 'SeznamDogodkov'
ALTER TABLE [dbo].[SeznamDogodkov]
ADD CONSTRAINT [PK_SeznamDogodkov]
    PRIMARY KEY CLUSTERED ([uprabniskoIme], [idDogodek], [idSeznamDogodkov] ASC);
GO

-- Creating primary key on [uprabniskoIme] in table 'Uporabnik'
ALTER TABLE [dbo].[Uporabnik]
ADD CONSTRAINT [PK_Uporabnik]
    PRIMARY KEY CLUSTERED ([uprabniskoIme] ASC);
GO

-- Creating primary key on [nazivVloge] in table 'Vloga'
ALTER TABLE [dbo].[Vloga]
ADD CONSTRAINT [PK_Vloga]
    PRIMARY KEY CLUSTERED ([nazivVloge] ASC);
GO

-- Creating primary key on [Uporabnik_uprabniskoIme], [Vloga_nazivVloge] in table 'uporabnik_ima_vlogo'
ALTER TABLE [dbo].[uporabnik_ima_vlogo]
ADD CONSTRAINT [PK_uporabnik_ima_vlogo]
    PRIMARY KEY CLUSTERED ([Uporabnik_uprabniskoIme], [Vloga_nazivVloge] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [kraticaDrzave] in table 'Aktivnost'
ALTER TABLE [dbo].[Aktivnost]
ADD CONSTRAINT [FK_AKTIVNOS_AKTIVNOST_DRZAVA]
    FOREIGN KEY ([kraticaDrzave])
    REFERENCES [dbo].[Drzava]
        ([kraticaDrzave])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AKTIVNOS_AKTIVNOST_DRZAVA'
CREATE INDEX [IX_FK_AKTIVNOS_AKTIVNOST_DRZAVA]
ON [dbo].[Aktivnost]
    ([kraticaDrzave]);
GO

-- Creating foreign key on [idKraj] in table 'Aktivnost'
ALTER TABLE [dbo].[Aktivnost]
ADD CONSTRAINT [FK_AKTIVNOS_AKTIVNOST_KRAJ]
    FOREIGN KEY ([idKraj])
    REFERENCES [dbo].[Kraj]
        ([idKraj])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AKTIVNOS_AKTIVNOST_KRAJ'
CREATE INDEX [IX_FK_AKTIVNOS_AKTIVNOST_KRAJ]
ON [dbo].[Aktivnost]
    ([idKraj]);
GO

-- Creating foreign key on [idAktivnost] in table 'PostavkaAktivnosti'
ALTER TABLE [dbo].[PostavkaAktivnosti]
ADD CONSTRAINT [FK_POSTAVKA_AKTIVNOST_AKTIVNOS]
    FOREIGN KEY ([idAktivnost])
    REFERENCES [dbo].[Aktivnost]
        ([idAktivnost])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [idAktivnost] in table 'SeznamAktivnosti'
ALTER TABLE [dbo].[SeznamAktivnosti]
ADD CONSTRAINT [FK_SEZNAMAK_AKTIVNOST_AKTIVNOS]
    FOREIGN KEY ([idAktivnost])
    REFERENCES [dbo].[Aktivnost]
        ([idAktivnost])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_SEZNAMAK_AKTIVNOST_AKTIVNOS'
CREATE INDEX [IX_FK_SEZNAMAK_AKTIVNOST_AKTIVNOS]
ON [dbo].[SeznamAktivnosti]
    ([idAktivnost]);
GO

-- Creating foreign key on [kraticaDrzave] in table 'Dogodek'
ALTER TABLE [dbo].[Dogodek]
ADD CONSTRAINT [FK_DOGODEK_DOGODEK_V_DRZAVA]
    FOREIGN KEY ([kraticaDrzave])
    REFERENCES [dbo].[Drzava]
        ([kraticaDrzave])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DOGODEK_DOGODEK_V_DRZAVA'
CREATE INDEX [IX_FK_DOGODEK_DOGODEK_V_DRZAVA]
ON [dbo].[Dogodek]
    ([kraticaDrzave]);
GO

-- Creating foreign key on [idKraj] in table 'Dogodek'
ALTER TABLE [dbo].[Dogodek]
ADD CONSTRAINT [FK_DOGODEK_DOGODEK_V_KRAJ]
    FOREIGN KEY ([idKraj])
    REFERENCES [dbo].[Kraj]
        ([idKraj])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DOGODEK_DOGODEK_V_KRAJ'
CREATE INDEX [IX_FK_DOGODEK_DOGODEK_V_KRAJ]
ON [dbo].[Dogodek]
    ([idKraj]);
GO

-- Creating foreign key on [idDogodek] in table 'PostavkaDogodka'
ALTER TABLE [dbo].[PostavkaDogodka]
ADD CONSTRAINT [FK_POSTAVKA_DOGODEK_I_DOGODEK]
    FOREIGN KEY ([idDogodek])
    REFERENCES [dbo].[Dogodek]
        ([idDogodek])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [idDogodek] in table 'SeznamDogodkov'
ALTER TABLE [dbo].[SeznamDogodkov]
ADD CONSTRAINT [FK_SEZNAMDO_DOGODEK_I_DOGODEK]
    FOREIGN KEY ([idDogodek])
    REFERENCES [dbo].[Dogodek]
        ([idDogodek])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_SEZNAMDO_DOGODEK_I_DOGODEK'
CREATE INDEX [IX_FK_SEZNAMDO_DOGODEK_I_DOGODEK]
ON [dbo].[SeznamDogodkov]
    ([idDogodek]);
GO

-- Creating foreign key on [kraticaDrzave] in table 'Naslov'
ALTER TABLE [dbo].[Naslov]
ADD CONSTRAINT [FK_NASLOV_NASLOV_V__DRZAVA]
    FOREIGN KEY ([kraticaDrzave])
    REFERENCES [dbo].[Drzava]
        ([kraticaDrzave])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_NASLOV_NASLOV_V__DRZAVA'
CREATE INDEX [IX_FK_NASLOV_NASLOV_V__DRZAVA]
ON [dbo].[Naslov]
    ([kraticaDrzave]);
GO

-- Creating foreign key on [uprabniskoIme] in table 'IzbrisanRacun'
ALTER TABLE [dbo].[IzbrisanRacun]
ADD CONSTRAINT [FK_IZBRISAN_UPORABNIK_UPORABNI]
    FOREIGN KEY ([uprabniskoIme])
    REFERENCES [dbo].[Uporabnik]
        ([uprabniskoIme])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [idKraj] in table 'Naslov'
ALTER TABLE [dbo].[Naslov]
ADD CONSTRAINT [FK_NASLOV_NASLOV_IM_KRAJ]
    FOREIGN KEY ([idKraj])
    REFERENCES [dbo].[Kraj]
        ([idKraj])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_NASLOV_NASLOV_IM_KRAJ'
CREATE INDEX [IX_FK_NASLOV_NASLOV_IM_KRAJ]
ON [dbo].[Naslov]
    ([idKraj]);
GO

-- Creating foreign key on [idNaslov] in table 'Uporabnik'
ALTER TABLE [dbo].[Uporabnik]
ADD CONSTRAINT [FK_UPORABNI_PREBIVALI_NASLOV]
    FOREIGN KEY ([idNaslov])
    REFERENCES [dbo].[Naslov]
        ([idNaslov])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UPORABNI_PREBIVALI_NASLOV'
CREATE INDEX [IX_FK_UPORABNI_PREBIVALI_NASLOV]
ON [dbo].[Uporabnik]
    ([idNaslov]);
GO

-- Creating foreign key on [uprabniskoIme] in table 'Obvestilo'
ALTER TABLE [dbo].[Obvestilo]
ADD CONSTRAINT [FK_OBVESTIL_UPORABNIK_UPORABNI]
    FOREIGN KEY ([uprabniskoIme])
    REFERENCES [dbo].[Uporabnik]
        ([uprabniskoIme])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [uprabniskoIme] in table 'SeznamAktivnosti'
ALTER TABLE [dbo].[SeznamAktivnosti]
ADD CONSTRAINT [FK_SEZNAMAK_UPORABNIK_UPORABNI]
    FOREIGN KEY ([uprabniskoIme])
    REFERENCES [dbo].[Uporabnik]
        ([uprabniskoIme])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [uprabniskoIme] in table 'SeznamDogodkov'
ALTER TABLE [dbo].[SeznamDogodkov]
ADD CONSTRAINT [FK_SEZNAMDO_UPORABNIK_UPORABNI]
    FOREIGN KEY ([uprabniskoIme])
    REFERENCES [dbo].[Uporabnik]
        ([uprabniskoIme])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Uporabnik_uprabniskoIme] in table 'uporabnik_ima_vlogo'
ALTER TABLE [dbo].[uporabnik_ima_vlogo]
ADD CONSTRAINT [FK_uporabnik_ima_vlogo_Uporabnik]
    FOREIGN KEY ([Uporabnik_uprabniskoIme])
    REFERENCES [dbo].[Uporabnik]
        ([uprabniskoIme])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Vloga_nazivVloge] in table 'uporabnik_ima_vlogo'
ALTER TABLE [dbo].[uporabnik_ima_vlogo]
ADD CONSTRAINT [FK_uporabnik_ima_vlogo_Vloga]
    FOREIGN KEY ([Vloga_nazivVloge])
    REFERENCES [dbo].[Vloga]
        ([nazivVloge])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_uporabnik_ima_vlogo_Vloga'
CREATE INDEX [IX_FK_uporabnik_ima_vlogo_Vloga]
ON [dbo].[uporabnik_ima_vlogo]
    ([Vloga_nazivVloge]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------