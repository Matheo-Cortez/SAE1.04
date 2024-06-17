---
--- SAE1.04 - B12 - Script SQL
---

drop schema if exists programme_but cascade; 
create schema programme_but; 
set schema 'programme_but';
-- Table _competences
CREATE TABLE _competences( 
  	lib_competences VARCHAR(20) NOT NULL, 
CONSTRAINT _competences_pk PRIMARY KEY(lib_competences) 
);
-- Table _activites
CREATE TABLE _activites( 
  	lib_activite VARCHAR(20) NOT NULL, 
CONSTRAINT _activites_pk PRIMARY KEY(lib_activite) 
);
-- Table _niveau
CREATE TABLE _niveau( 
    numero_N INT NOT NULL, 
CONSTRAINT _niveau_pk PRIMARY KEY(numero_N) 
);
-- Table _semestre
CREATE TABLE _semestre( 
 	numero_sem VARCHAR(20) NOT NULL,
    numero_N INT NOT NULL, 
CONSTRAINT _semestre_pk PRIMARY KEY(numero_sem),
CONSTRAINT _semestre_fk_niveau
    FOREIGN KEY(numero_N) REFERENCES _niveau(numero_N)
);
-- Table _ue
CREATE TABLE _ue( 
  	code_ue VARCHAR(20) NOT NULL, 
    lib_activite VARCHAR(20) NOT NULL, 
    numero_sem VARCHAR(20) NOT NULL, 
CONSTRAINT _ue_pk PRIMARY KEY(code_ue), 
CONSTRAINT est_realisee_dans 
    FOREIGN KEY(lib_activite) REFERENCES _activites(lib_activite), 
CONSTRAINT dans  
    FOREIGN KEY(numero_sem) REFERENCES _semestre(numero_sem), 
CONSTRAINT code_ue_check CHECK (code_ue ~ 'UE[1-9].[0-9]')
);
-- Table _parcours
CREATE TABLE _parcours( 
    code_p CHAR(7) NOT NULL, 
    libelle_parcours VARCHAR(20) NOT NULL, 
    nbre_gpe_TD_P INT NOT NULL, 
    nbre_gpe_TP_P INT NOT NULL, 
CONSTRAINT _parcours_pk PRIMARY KEY(code_p), 
CONSTRAINT code_p_check CHECK (code_p LIKE '^R[1-9]+\.[A|C]\.[0-9]{2}$')
);
-- Table _ressources
CREATE TABLE _ressources( 
    code_R VARCHAR(20) NOT NULL, 
    lib_R VARCHAR(20) NOT NULL, 
    nb_h_TD_PN INT NOT NULL, 
    nb_h_TP_PN INT NOT NULL, 
    numero_sem VARCHAR(20) NOT NULL, 
CONSTRAINT _ressources_pk PRIMARY KEY(code_R),
CONSTRAINT _quand_fk FOREIGN KEY(numero_sem) REFERENCES _semestre(numero_sem),
CONSTRAINT code_r_check CHECK (code_R ~ '^R[1-9]+\.[0-9]{2}$') 
);
-- Table _comprend_r
CREATE TABLE _comprend_r( 
    nb_h_TD_C INT NOT NULL, 
    nb_h_TP_C INT NOT NULL, 
CONSTRAINT _comprend_r_pk PRIMARY KEY(nb_h_TD_C, nb_h_TP_C) 
);
-- Table _sae
CREATE TABLE _sae( 
 	code_SAE VARCHAR(20) NOT NULL, 
 	lib_SAE VARCHAR(20) NOT NULL, 
  	nb_h_TD_enc INT NOT NULL, 
    nb_h_TD_projet_autonomie INT NOT NULL, 
CONSTRAINT _sae_pk PRIMARY KEY(code_SAE),
CONSTRAINT code_SAE_check CHECK (code_SAE ~ '^S[1-9]+\.[0-9]{2}$') 
);
-- Table _correspond
CREATE TABLE _correspond( 
 	code_P CHAR(20) NOT NULL, 
    numero_N INT NOT NULL, 
    lib_activite VARCHAR(20) NOT NULL, 
CONSTRAINT _correspond_pk PRIMARY KEY(code_P, numero_N, lib_activite),
CONSTRAINT _correspond_fk_activites 
    FOREIGN KEY(lib_activite) REFERENCES _activites(lib_activite),
CONSTRAINT correspond_fk_niveau 
    FOREIGN KEY(numero_N) REFERENCES _niveau(numero_N),
CONSTRAINT correspond_fk_parcours 
    FOREIGN KEY(code_P) REFERENCES _parcours(code_P),
CONSTRAINT code_p_check CHECK (code_p LIKE 'R[1-9].[AC].[0-9][0-9]') 

);
-- Table _releve_de
CREATE TABLE _releve_de( 
 	lib_competences VARCHAR(20) NOT NULL, 
    lib_activite VARCHAR(20) NOT NULL, 
CONSTRAINT _releve_de_pk PRIMARY KEY(lib_competences, lib_activite),
CONSTRAINT _releve_de_fk_competences 
    FOREIGN KEY(lib_competences) REFERENCES _competences(lib_competences),
CONSTRAINT _releve_de_fk_activites 
    FOREIGN KEY(lib_activite) REFERENCES _activites(lib_activite)
);
-- Table _est_enseigne
CREATE TABLE _est_enseigne( 
    code_p VARCHAR(20) NOT NULL, 
    code_R VARCHAR(20) NOT NULL, 
CONSTRAINT pk_est_enseigne 
	PRIMARY KEY(code_p,code_r), 
CONSTRAINT fk_est_enseigne_parcours  
    FOREIGN KEY (code_p) REFERENCES _parcours(code_p),  
CONSTRAINT fk_est_enseigne_ressources  
    FOREIGN KEY (code_R) REFERENCES _ressources(code_R)
); 
