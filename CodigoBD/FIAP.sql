CREATE SEQUENCE CATEGORIA_SEQuence START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER tr_insert_id_categoria
                  BEFORE INSERT ON categoria FOR EACH ROW       
BEGIN
 
SELECT CATEGORIA_SEQuence.NEXTVAL
INTO :new.idcategoria
FROM DUAL;
END;
/







