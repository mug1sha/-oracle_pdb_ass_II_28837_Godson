
--Task 1: Create a New Pluggable Database

-- Create Pluggable Database
CREATE PLUGGABLE DATABASE go_pdb_28837
ADMIN USER pdbadmin IDENTIFIED BY m2027
FILE_NAME_CONVERT = ('pdbseed', 'go_pdb_28837');

-- Open Pluggable Database

ALTER PLUGGABLE DATABASE go_pdb_28837 OPEN;

-- check status
SHOW PDBS;

-- Switch to pdb
ALTER SESSION SET CONTAINER = go_pdb_28837;

-- check current container
SHOW CON_NAME;

--Create user in PDB
CREATE USER godson_plsqlauca_28837
IDENTIFIED BY m2027;

-- Grant privileges to user
GRANT CONNECT, RESOURCE TO godson_plsqlauca_28837;

-- Check if user is created
SELECT username FROM dba_users
WHERE username = 'GODSON_PLSQLAUCA_28837';

--Connect to PDB using SQL*Plus
sqlplus godson_plsqlauca_28837/m2027@go_pdb_28837

--Task 2: Create and Delete a PDB

CREATE PLUGGABLE DATABASE go_to_delete_pdb_28837
ADMIN USER admin IDENTIFIED BY m2027 
FILE_NAME_CONVERT = ('pdbseed', 'go_to_delete_pdb_28837');

-- Close the PDB before dropping it
ALTER PLUGGABLE DATABASE go_to_delete_pdb_28837 CLOSE IMMEDIATE;

-- Drop the PDB
DROP PLUGGABLE DATABASE go_to_delete_pdb_28837 INCLUDING DATAFILES;

-- list all PDBs to confirm deletion
COLUMN name FORMAT A30
SELECT name, open_mode FROM v$pdbs;

--Task 3: Oracle Enterprise Manager (OEM)
-- open sqlplus as sysdba to start the database and access OEM
sqlplus / as sysdba

--Check if a port is already set:
SELECT DBMS_XDB_CONFIG.GETHTTPSPORT() FROM DUAL;
--open port if needed
EXEC DBMS_XDB_CONFIG.SETHTTPSPORT(5500);