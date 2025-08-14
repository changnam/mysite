COMMIT;
SELECT * FROM d7_method;
SELECT * FROM d7_method WHERE REGEXP_LIKE(name,'image|img','i') ORDER BY name,val,scr;


SELECT * FROM d7_method WHERE REGEXP_LIKE(name,'line|multi','i') ORDER BY name,val,scr;

SELECT * FROM d7_method WHERE REGEXP_LIKE(name,'progress','i') ORDER BY name,val,scr;

SELECT * FROM d7_method WHERE REGEXP_LIKE(name,'shape','i') ORDER BY name,val,scr;

SELECT * FROM d7_method WHERE REGEXP_LIKE(name,'tab','i') AND NOT REGEXP_LIKE(name,'database','i') ORDER BY name,val,scr;

SELECT * FROM d7_method WHERE REGEXP_LIKE(name,'timer','i') ORDER BY name,val,scr;

SELECT * FROM d7_method WHERE REGEXP_LIKE(name,'web|browser','i') ORDER BY name,val,scr;

